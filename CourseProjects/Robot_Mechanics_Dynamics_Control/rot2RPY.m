% FUNCTION NAME : [roll,pitch,yaw] = rot2RPY(R) 
% DESCRIPTION   : This function returns the "roll, pitch and yaw"
%                 corresponding to the rotation matrix.
% [roll,pitch,yaw] = rot2RPY(R)......provides the angle through which the
% bot is rotated in the three axes from the provided rotation matrix "R".
%
% OUTPUT 1      : It rpovides the angle through which rotated about the "z-axis".
% OUTPUT 2      : It rpovides the angle through which rotated about the "y-axis".
% OUTPUT 3      : It rpovides the angle through which rotated about the "x-axis".
%
% INPUT         : It provides the final rotation matrix.
%
% NAME          : Akshay Swaminathan
% CWID          : 10832697
% COURSE NO.    : MEGN 544
% DATE          : 10/01/2017
%%
function [roll,pitch,yaw] = rot2RPY(R)
pitch1 = atan2(-R(3,1),sqrt(R(1,1)^2+R(2,1)^2));    %first possibility of the angle
pitch2 = atan2(-R(3,1),-sqrt(R(1,1)^2+R(2,1)^2));   % second possibility of the angle

if(pitch1==pi/2||pitch2==pi/2)  %special case of degeneracy
    yaw1 = 0;
    yaw2 = 0;
    roll1 = -atan2(R(1,2),R(2,2));
    roll2 = roll1;
else        %general case of rotation
yaw1   = atan2(R(3,2)/cos(pitch1),R(3,3)/cos(pitch1));
yaw2   = atan2(R(3,2)/cos(pitch2),R(3,3)/cos(pitch2));
roll1  = atan2(R(2,1)/cos(pitch1),R(1,1)/cos(pitch1));
roll2  = atan2(R(2,1)/cos(pitch2),R(1,1)/cos(pitch2));
end

pitch = [pitch1;        %rotation about "y"
         pitch2]
     
yaw = [yaw1;           %rotation about "x"
       yaw2]
   
roll = [roll1;         %rotation about "z"
        roll2]
end
