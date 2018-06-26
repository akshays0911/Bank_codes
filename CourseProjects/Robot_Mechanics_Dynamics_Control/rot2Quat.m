% FUNCTION NAME : rot2Quat(R) 
% DESCRIPTION   : This function returns the quaternion vector that is
%                 rotated about the respective axes.
% Q = rot2Quat(R).....provides the quaternion vector corresponding to the
% rotation matrix given
%
% OUPUT         : The output "Q" is the vector that has the axes "x,y and
%                 z" about whic the rotation has occurred.
%
% INPUT         : The input is the final rotation matrix "R".
%
% NAME          : Akshay Swaminathan
% CWID          : 10832697
% COURSE NO.    : MEGN 544
% DATE          : 10/01/2017
%%
function Q = rot2Quat(R)
Q_0=sqrt(R(1,1)+R(2,2)+R(3,3)+1)/(2);  %vector format providing rotation info in "x,y&z" axes
q1=sqrt(1+R(1,1)-R(2,2)-R(3,3))/(2);
q2=sqrt(1-R(1,1)+R(2,2)-R(3,3))/(2);
q3=sqrt(1-R(1,1)-R(2,2)+R(3,3))/(2);

if Q_0==0      %special case 1
    if q1>q2 & q1>q3
     Q_0 = sqrt(R(1,1)+R(2,2)+R(3,3)+1)/(2);
     q1 = sqrt(1+R(1,1)-R(2,2)-R(3,3))/(2);
     q2 = (R(1,2)+R(2,1))/(4*q1);
     q3 = (R(1,3)-R(3,1))/(4*q1);
     Q_1 = [q1,q2,q3];
     Q = [Q_0,Q_1];
     Q = Q(:)
    elseif q2>q3    %special case 2
    Q_0 = sqrt(R(1,1)+R(2,2)+R(3,3)+1)/(2);
    q2 = sqrt(1-R(1,1)+R(2,2)-R(3,3))/(2);
    q1 = (R(1,2)+R(2,1))/(4*q2);
    q3 = (R(2,3)+R(3,2))/(4*q2);
    Q_1 = [q1,q2,q3];
    Q = [Q_0,Q_1];
    Q = Q(:)
    else   %special case 3
    Q_0 = sqrt(R(1,1)+R(2,2)+R(3,3)+1)/(2); 
    q3 = sqrt(1-R(1,1)-R(2,2)+R(3,3))/(2);
    q1 = (R(1,3)+R(3,1))/(4*q3);
    q2 = (R(2,3)+R(3,2))/(4*q3);
    Q_1 = [q1,q2,q3];
    Q = [Q_0,Q_1];
    Q = Q(:)
    end
    
else     %general case of rotation
Q_0 = sqrt(R(1,1)+R(2,2)+R(3,3)+1)/(2);
q1 = (R(3,2)-R(2,3))/(4*Q_0);
q2 = (R(1,3)-R(3,1))/(4*Q_0);
q3 = (R(2,1)-R(1,2))/(4*Q_0);
Q_1 = [q1,q2,q3];
Q = [Q_0,Q_1];
Q = Q(:)
end
