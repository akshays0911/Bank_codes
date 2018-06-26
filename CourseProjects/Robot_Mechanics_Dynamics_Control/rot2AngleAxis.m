% FUNCTION NAME : rot2AngleAxis(R) 
% DESCRIPTION   : This function returns the axis "k" and angle "theta"
%                 about which the rotation occured givent the rotation matrix "R".
% [k, theta] = rot2AngleAxis(R).........provides the axis and angle of
% rotation givne the final rotation matrix.
%
% OUTPUT 1      : This ouput maps to the axis "k" about which the rotation
%                 occured.
% OUTPUT 2      : This output maps to the angle "theta" about which the rotation
%                 occured. 
%
% INPUT         : This input is the final rotation matrix that is provided.
%
% NAME          : Akshay Swaminathan
% CWID          : 10832697
% COURSE NO.    : MEGN 544
% DATE          : 10/01/2017
%%
function [k, theta] = rot2AngleAxis(R) 
Trace = R(1,1)+R(2,2)+R(3,3);   %summation of leading diagonal
theta = acos((Trace-1)/2);      %angle of rotation

if(theta==pi)   %special case of rotation of pi
    k1 = sqrt((R(1,1)+1)/2);
    k2 = sqrt((R(2,2)+1)/2);
    k3 = sqrt((R(3,3)+1)/2);
    k = [k1;
         k2;
         k3]
else      %general case of rotation
X = 1/(2*sin(theta));
Y = [R(3,2)-R(2,3);R(1,3)-R(3,1);R(2,1)-R(1,2)];
k = X*Y    %axis of rotation 
end
end
