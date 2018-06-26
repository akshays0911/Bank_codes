% FUNCTION NAME : abbInvKine 
% DESCRIPTION   : This function returns the joint angles required to reach 
%                 the desired transformation for the ABB arm
%
% OUTPUT        : The output gives the six thetas corresponding to the six
%                 links of the ABB arm.
%
% INPUT         : The inputs are the desired homogenous transform 
%                 and the given 6*1 theta values.
%
% NAME          : Akshay Swaminathan
% CWID          : 10832697
% COURSE NO.    : MEGN 544
% DATE          : 11/19/2017
%%
function [th1,th2,th3,th4,th5,th6,reachable] = abbInvKine(T_des,th_last)
%%
% Initializing the values
a = [0 0.270 0.070 0 0 0];
d = [0.290 0 0 0.302 0 0.072];
alpha = [-pi/2 0 -pi/2 pi/2 -pi/2 0];

d_06 = T_des(1:3,4);
z_06 = T_des(1:3,3);
d_05 = d_06 - z_06*d(6);
z_00 = [0; 0; 1];

theta = zeros(8,6);
%% Finding theta1
for i = 1:4
    theta(i,1) = atan2(d_05(2),d_05(1));
end

for i = 5:8
    theta(i,1) = atan2(d_05(2),d_05(1))+pi;
end


T01_l = dhTransform(a(1),d(1),alpha(1),theta(1,1));
T01_r = dhTransform(a(1),d(1),alpha(1),theta(5,1));

d_15 = zeros(3,1,8);

for i = 1:4
    d_15(:,:,i) = (T01_l(1:3,1:3).')*(d_06-z_06*d(6)-z_00*d(1));
end
for i = 5:8
    d_15(:,:,i) = (T01_r(1:3,1:3).')*(d_06-z_06*d(6)-z_00*d(1));
end


%% Finding theta3
d_15_mag = zeros(2,1);
d_15_mag(1) = sqrt(d_15(1,:,1)^2+d_15(2,:,1)^2+d_15(3,:,1)^2);
d_15_mag(2) = sqrt(d_15(1,:,5)^2+d_15(2,:,2)^2+d_15(3,:,5)^2);


nu = atan2(d(4),a(3));

phi_l_p = 2*atan(sqrt((2*a(2)*sqrt(d(4)^2+a(3)^2)-a(2)^2-d(4)^2-a(3)^2+d_15_mag(1)^2)/(2*a(2)*sqrt(d(4)^2+a(3)^2)+a(2)^2+d(4)^2+a(3)^2-d_15_mag(1)^2)));
phi_l_n = -phi_l_p;

phi_r_p = 2*atan(sqrt((2*a(2)*sqrt(d(4)^2+a(3)^2)-a(2)^2-d(4)^2-a(3)^2+d_15_mag(2)^2)/(2*a(2)*sqrt(d(4)^2+a(3)^2)+a(2)^2+d(4)^2+a(3)^2-d_15_mag(2)^2)));
phi_r_n = -phi_r_p;

for i = 1:8
    if i == 1 || i == 2
        theta(i,3) = pi - phi_l_p - nu;
    elseif i == 3 || i ==  4
        theta(i,3) = pi - phi_l_n - nu;
    elseif i == 5 || i ==  6
        theta(i,3) = pi - phi_r_p - nu;
    elseif i == 7 || i ==  8
        theta(i,3) = pi - phi_r_n - nu;
    end
end

if isreal(theta(1:8,3)) == 0
    reachable = 0;
    theta(:,3) = real(theta(:,3));
else
    reachable = 1;
end

%% Finding theta2

eeta = zeros(8,1);
si = zeros(8,1);

for i = 1:8
    eeta(i) = a(2) + a(3)*cos(theta(i,3)) + d(4)*cos(theta(i,3)+pi/2);
    si(i) = a(3)*sin(theta(i,3)) + d(4)*sin(theta(i,3)+pi/2);
    theta(i,2) = (atan2((eeta(i)*d_15(2,:,i)-si(i)*d_15(1,:,i))/(eeta(i)^2+si(i)^2),(eeta(1)*d_15(1,:,i)+si(i)*d_15(2,:,i))/(eeta(i)^2+si(i)^2)));
end
%% Finding theta4, theta5, theta6
T03 = zeros(4,4,8);
for i = 1:8
    T03(:,:,i) = dhTrans(a(1:3),d(1:3),alpha(1:3),theta(i,1:3),0,3);
end

%Finding R36
R36 = zeros(3,3,8);
for i = 1:8
    R36(:,:,i) = T03(1:3,1:3,i).'*T_des(1:3,1:3);
end

for i = 1:8
    if mod(i,2) == 1
        theta(i,5) = atan2(sqrt(R36(3,1,i)^2+R36(3,2,i)^2),R36(3,3,i));
    else
        theta(i,5) = atan2(-sqrt(R36(3,1,i)^2+R36(3,2,i)^2),R36(3,3,i));
    end
end

%Computing for theta5
for i = 1:8
    if theta(i,5)==pi
        theta(i,4) = 0;
        theta(i,6)=atan2(-R36(1,2,i),R36(1,1,i));    
    else
        theta(i,6) = atan2(-R36(3,2,i)/sin(theta(i,5)),R36(3,1,i)/sin(theta(i,5)));
        theta(i,4) = atan2(-R36(2,3,i)/sin(theta(i,5)),-R36(1,3,i)/sin(theta(i,5)));
    end
end

for i = 1:8
    for j = 1:6
        if theta(i,j) >= pi
            theta(i,j) = theta(i,j) - 2*pi;
        end
    end
end

if exist('th_last','var') == 0
    th1 = theta(:,1);
    th2 = theta(:,2);
    th3 = theta(:,3);
    th4 = theta(:,4);
    th5 = theta(:,5);
    th6 = theta(:,6);
    return;
end
%% Path selection based on cost function
diff = zeros(8,6);
costFunc = zeros(8,1);
th_last(2) = th_last(2) - pi/2;

for i = 1:8
    for j = 1:6
        diff(i,j) = abs(theta(i,j)-th_last(j));
        costFunc(i) = costFunc(i) + diff(i,j);
    end
end

[min_cost,branch] = min(costFunc);

th1 = theta(branch,1);
th2 = theta(branch,2) + pi/2;
th3 = theta(branch,3);
th4 = theta(branch,4);
th5 = theta(branch,5);
th6 = theta(branch,6);

end
