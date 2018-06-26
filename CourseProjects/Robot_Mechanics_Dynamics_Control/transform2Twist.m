% FUNCTION NAME : transform2Twist(H) 
% DESCRIPTION   : This function returns a twist correswponding to the homogenous transform.
% t = transform2Twist(H)......provides the twist upon provided with the
% transformation matrix.
%
% OUTPUT        : The ouput is a 6*1 matrix that describes the axis of rotation,
%                 angle of rotation and angular velocity.
%
% INPUT         : The input is a a homogenous transformation matrix that
%                 is 4*4. This provides the rotation and displacement components.
% 
% NAME          : Akshay Swaminathan
% CWID          : 10832697
% COURSE NO.    : MEGN 544
% DATE          : 10/01/2017
%%
function t = transform2Twist(H)
R = [H(1,1) H(1,2) H(1,3);    %rotation matrix
     H(2,1) H(2,2) H(2,3);
     H(3,1) H(3,2) H(3,3)];
 
d = [H(1,4);     %displacement matrix
     H(2,4);
     H(3,4)];
 
theta=acos((R(1,1)+R(2,2)+R(3,3)-1)/2)   %angle of rotation

if(theta==0)   %special case
     w=[zeros(3,1)];
     v = d;   %axis of rotation
     t = [v(1,1); %homogenous transform
          v(2,1);
          v(3,1);
          w(1,1);
          w(2,1);
          w(3,1)]
 else
s = [R(3,2)-R(2,3);   %rotation matrix
     R(1,3)-R(3,1);
     R(2,1)-R(1,2)]
w = (1/(2*sin(theta)))*s;   %angular velocity
wth = w*theta;           

I =eye(3);

X = (I-R)*[0 -w(3,1) w(2,1);
           w(3,1) 0 -w(1,1);
           -w(2,1) w(1,1) 0];
Y = w*w'*theta;
Z = inv(X+Y);
v = Z*d;  %axis of rotation

t = [v(1,1);   %homogenous transform
     v(2,1);
     v(3,1);
     wth(1,1);
     wth(2,1);
     wth(3,1)]
end
end
