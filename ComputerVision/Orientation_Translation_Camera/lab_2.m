clear all
close all
%Lab 1
%The pose of the camera to world is
t_c_w = [10;25;40];

%the rotations about the frame are defined as: 
ax = 1.1; ay = -0.5; az = 0.1 %Radians

%The rotation matricies are calculated by: 
Rx = [1 0 0; 0 cos(ax) -sin(ax); 0 sin(ax) cos(ax) ];
Ry = [cos(ay) 0 sin(ay); 0 1 0; -sin(ay) 0 cos(ay) ];
Rz = [cos(az) -sin(az) 0; sin(az) cos(az) 0; 0 0 1 ];

%The full rotation matricie is given by: 
R_c_w = Rz*Ry*Rx; 

%The homogeneous transformation matricie is given by: 

H_c_w = [R_c_w t_c_w; 0 0 0 1];

%The pose of the world with respect to the camera is given by:

H_w_c = inv(H_c_w);
Mext = H_w_c(1:3, :);

%Intrinsic Camera Matrix: 
cx = 256/2; 
cy = 170/2; 
f = 400; %pixels
K = [f 0 cx;
     0 f cy; 
     0 0 1];
%Define the 3d points in toe world
%Each column is one point in the homogeneous coordinates: 
P_w = [6.8158 7.8493 9.9579 8.8219 9.5890 10.8082 13.2690;
        -35.1954 -36.1723 -25.2799 -38.3767 -28.8402 -48.8146 -58.0988;
        43.0640 43.7815 40.1151 46.6153 42.2858 56.1475 59.1422;
        1 1 1 1 1  1];
%Project points onto an image
%The pose of the camera to world is
t_c_w = [10;-25;40];
p_img = K*Mext*P_w;

% Divide through by the last element of each column, since these are
% homogeneous points.
p_img(1,:) = p_img(1,:) ./ p_img(3,:);
p_img(2,:) = p_img(2,:) ./ p_img(3,:);
p_img(3,:) = p_img(3,:) ./ p_img(3,:);
% Create an image showing those points.
HEIGHT = 700;
WIDTH = 700;
I = zeros(HEIGHT, WIDTH);

for i=1:size(p_img,2)
r = p_img(2,i); % row is y
c = p_img(1,i); % col is x
r = round(r); % round to nearest integer
c = round(c);
% Make sure (r,c) is within image boundaries.
if r>0 && r<=HEIGHT && c>0 && c<=WIDTH
I(r,c) = 255;
end
end
imshow(I);
% Can also use Matlab's plot function. This will draw on top of an already
% displayed image.
hold on
plot(p_img(1,:), p_img(2,:), 'Color', 'w', 'Marker', 'd', 'LineStyle', 'none');
line(p_img(1,:),p_img(2,:));

% % Draw 3D scene plot.
% plot3(0,0,0,'+'); % Draw a dot at the world origin
% drawCoordinateAxes(eye(4), 'W'); % Draw world axes
% drawCoordinateAxes(H_c_w, 'C'); % Draw camera frame axes
% axis equal
% axis vis3d
% 
% function drawCoordinateAxes(H_c_w, label)
% % This function draws xyz coordinate axes on the active figure.
% % Inputs: H is the 4x4 transformation matrix, label is a string.
% p = H_c_w(1:3,4); % Origin
% text(p(1),p(2),p(3),label);
% ux = H_c_w * [1;0;0;1]; % x axis
% uy = H_c_w * [0;1;0;1]; % y axis
% uz = H_c_w * [0;0;1;1]; % z axis
% line([p(1),ux(1)], [p(2),ux(2)], [p(3),ux(3)], 'Color', 'r'); % x axis
% line([p(1),uy(1)], [p(2),uy(2)], [p(3),uy(3)], 'Color', 'g'); % y axis
% line([p(1),uz(1)], [p(2),uz(2)], [p(3),uz(3)], 'Color', 'b'); % z axis
% end
