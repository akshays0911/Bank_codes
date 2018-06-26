% FUNCTION NAME : rotZ(theta) 
% DESCRIPTION   : This function returns a rotation matrix, which describes
%                 the rotation about Z-AXIS.
% R = rotZ(theta).....provides the rotation about the "z" direction with
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
function [R] = rotZ(theta)
R = zeros (3,3);
R(1,:) = [cos(theta) -sin(theta) 0];    %final rotation matrix corresponding to rotation about "z" axis
R(2,:) = [sin(theta) cos(theta) 0];
R(3,:) = [0 0 1];
end
