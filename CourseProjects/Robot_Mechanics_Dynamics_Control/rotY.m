% FUNCTION NAME : rotY(theta) 
% DESCRIPTION   : This function returns a rotation matrix, which describes
%                 the rotation about Y-AXIS.
% R = rotY(theta).....provides the rotation about the "y" direction with
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
function [R] = rotY(theta)
R = zeros (3,3);
R(1,:) = [cos(theta) 0 sin(theta)];    %final rotation matrix corresponding to rotation about "y" axis
R(2,:) = [0 1 0];
R(3,:) = [-sin(theta) 0 cos(theta)];
end
