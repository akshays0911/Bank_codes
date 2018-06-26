% FUNCTION NAME : quat2Rot(Q) 
% DESCRIPTION   : This function returns a rotation matrix, which returns the 
%                 quaternion [qo;q_vec] that corresponds to the rotation matrix.
% R = quat2Rot(Q)........provides the roation matrix obtained with respect
% to the quaternion considered.
%
% OUTPUT        : The output is a 3*3 rotation matrix.
%
% INPUT         : The input has components that describe the roation of the
%                 vector about the "x,y and z" directions.
%
% NAME          : Akshay Swaminathan
% CWID          : 10832697
% COURSE NO.    : MEGN 544
% DATE          : 10/01/2017
%%
function R = quat2Rot(Q)
R = [1-2*Q(3)^2-2*Q(4)^2        2*Q(2)*Q(3)-2*Q(1)*Q(4)    2 *Q(2)*Q(4)+2*Q(1)*Q(3);     %rotation matrix corresponding to given quaternion vector
     2*Q(2)*Q(3)+2*Q(1)*Q(4)    1-2*Q(2)^2-2*Q(4)^2        2*Q(3)*Q(4)-2*Q(1)*Q(2);
     2*Q(2)*Q(4)-2*Q(1)*Q(3)    2*Q(3)*Q(4)+2*Q(1)*Q(2)    1-2*Q(2)^2-2*Q(3)^2]
end
