% FUNCTION NAME : rotX(theta) 
% DESCRIPTION   : This function returns a rotation matrix, which describes
%                 the rotation about X-AXIS.
% R = rotX(theta)
% NAME          : Akshay Swaminathan
% CWID          : 10832697

function R = angleAxis2Rot(k, theta)
kx=k(1,1);
ky=k(2,1);
kz=k(3,1);
A = [cos(theta) 0 0;0 cos(theta) 0;0 0 cos(theta)];
B = sin(theta).*[0 -kz ky;kz 0 -kx;-ky kx 0];
C = (1-cos(theta)).*([kx;ky;kz]*[kx ky kz]);
R = A+B+C;
end
