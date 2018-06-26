% FUNCTION NAME : dhTransform(a, d, alpha, theta) 
% DESCRIPTION   : This function returns a homogenoustransformation matrix.
%                 This matrix describes the rotation and translation about
%                 the "z" and "x".
% H = dhTransform(a, d, alpha, theta)........returns the transform matrix
% that produces the result of rotation about "z" and "x" axes with the
% inputs "a,d,alpha and theta".
%
% OUTPUT        : The output obtained is a homogenous transformation matrix
%                 "H".
%
% INPUT 1       : It is the displacement along the x-direction.
% INPUT 2       : It is the displacement along the z-direction.
% INPUT 3       : It is the rotation about the x-direction.
% INPUT 4       : It is the rotation about the z-direction.
%
% NAME          : Akshay Swaminathan
% CWID          : 10832697
% COURSE NO.    : MEGN 544
% DATE          : 10/01/2017
%%
function H = dhTransform(a, d, alpha, theta)     
% A = [1 0 0 0;    %translation along z
%      0 1 0 0; 
%      0 0 1 d;
%      0 0 0 1]
% B = [cos(theta) -sin(theta) 0 0;  %rotation about z
%      sin(theta) cos(theta) 0 0;
%      0 0 1 0;
%      0 0 0 1]
% C = [1 0 0 a;    %translation along x
%      0 1 0 0;
%      0 0 1 0;
%      0 0 0 1]
% D = [1 0 0 0;    %rotation about x
%      0 cos(alpha) -sin(alpha) 0;
%      0 sin(alpha) cos(alpha) 0;
%      0 0 0 1]
H = zeros (4,4);
Rx = rotX(alpha);
Rz = rotZ(theta);
T1 = [Rz [0 0 d]';0 0 0 1];
T2 = [Rx [a 0 0]';0 0 0 1];

H = T1 * T2;  %final homogenous tranformation matrix
end
