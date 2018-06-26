% % FUNCTION NAME : twist2Transform(t) 
% DESCRIPTION   : This function returns a homogenous transform matrix.
%                 This matrix is the result of the twist that occurred
%                 about a particular axis with a particular angle.
% twist2Transform(t)......provides the transformation matrix upon
% rotation about angle "theta" and axis "v" with angular velocity "w".
%
% OUTPUT        : The ouput is a 4*4 matrix that describes the rotation and
%                 translation.
%
% INPUT         : The input is a twist component that provides the axis "v"
%                 and angular velocity "w" and angle of rotation "theta".
%
% NAME          : Akshay Swaminathan
% CWID          : 10832697
% COURSE NO.    : MEGN 544
% DATE          : 10/01/2017
%%
function H = twist2Transform(t)
v = [t(1,1);       %provides the axis of rotation
     t(2,1);
     t(3,1)]

 wth = [t(4,1);    %provides the angular velocity and angle
        t(5,1);
        t(6,1)];

w = zeros(3,1);
I = eye(3);
theta = norm(wth);
if(theta==0)     %special case of no rotation
    R = I;
    d = v;
    H = [R(1,1) R(1,2) R(1,3) d(1,1);
         R(2,1) R(2,2) R(2,3) d(2,1);
         R(3,1) R(3,2) R(3,3) d(3,1);
         0      0      0      1];
else
w = wth/theta;  %general case of rotation

X = I*cos(theta);
Y = sin(theta)*[0 -w(3,1) w(2,1); 
                w(3,1) 0 -w(1,1);
                -w(2,1) w(1,1) 0];
Z = w*w'*(1-cos(theta));

R = X+Y+Z;  %rotation matrix

M = (I-R)*[0 -w(3,1) w(2,1);
           w(3,1) 0 -w(1,1);
           -w(2,1) w(1,1) 0];
N = w*w'*theta;
d = (M+N)*v;  %displacement matrix

H = [R(1,1) R(1,2) R(1,3) d(1,1);     %final homogenous transform
     R(2,1) R(2,2) R(2,3) d(2,1);
     R(3,1) R(3,2) R(3,3) d(3,1);
     0      0      0      1]
end
end
  
