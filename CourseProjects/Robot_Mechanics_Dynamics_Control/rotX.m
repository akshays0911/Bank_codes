% FUNCTION NAME : rotX(theta) 
% DESCRIPTION   : This function returns a rotation matrix, which describes
%                 the rotation about X-AXIS.
% R = rotX(theta).....provides the rotation about the "x" direction with
% the angle "theta".
%
% OUTPUT        : The put is the final rotation matrix post rotation about
%                 given axis.
%
% INPUT         : The input is the angle that is to be rotated.
%
% NAME          : Akshay Swaminathan
% CWID          : 10832697
% COURSE NO.    : MEGN 544
% DATE          : 10/01/2017
%%
function [R] = rotX(theta)
R = zeros (3,3);
R(1,:) = [1 0 0];              %final rotation matrix corresponding to rotation about "x " axis
R(2,:) = [0 cos(theta) -sin(theta)];
R(3,:) = [0 sin(theta) cos(theta)];
end
