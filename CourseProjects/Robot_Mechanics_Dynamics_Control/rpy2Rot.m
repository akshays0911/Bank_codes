% FUNCTION NAME : rpy2Rot(roll,pitch,yaw) 
% DESCRIPTION   : This function returns a rotation matrix, which describes
%                 the rotation about Z-AXIS,Y-AXIS and X-AXIS.
% R = rpy2Rot(roll,pitch,yaw)........provides the final rotationmatrix
% corresponding to the rotation about the axes z,y and x.
%
% OUTPUT        : The output corresponds to the rotation matrix "R".
%
% INPUT 1       : This maps to the angle of rotation about the "z-axis".
% INPUT 2       : This maps to the angle of rotation about the "y-axis".
% INPUT 3       : This maps to the angle of rotation about the "x-axis".
%
% NAME          : Akshay Swaminathan
% CWID          : 10832697
% COURSE NO.    : MEGN 544
% DATE          : 10/01/2017
%%
function R = rpy2Rot(roll,pitch,yaw)
R = rotZ(roll)*rotY(pitch)*rotX(yaw);   %final rotation matrix corresponding to rotation about "z,y and x " axes
end
