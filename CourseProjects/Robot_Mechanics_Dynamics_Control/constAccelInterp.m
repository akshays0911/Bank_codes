% FUNCTION NAME : constAccelInterp 
% DESCRIPTION   : This function provides the position(p), velocity (v), and acceleration (a) 
%                 at time t for a trajectory interpolated using the constant acceleration approach.
%
% OUTPUT        : The output gives the position, velocity and acceleration
%                 at the given time t.
%
% INPUT         : The inputs are time t, trajectory provided and the percentage of the trajectory time. 
%
% NAME          : Akshay Swaminathan
% CWID          : 10832697
% COURSE NO.    : MEGN 544
% DATE          : 11/19/2017
%%
function [p,v,a]= constAccelInterp(t,trajectory,transPercent)
[m,n]=size(trajectory);
t_traj=trajectory(:,1);
%%
for i=1:(length(t_traj)-1)           %cutting the trajectory for the time required
    tau(i)=transPercent*(t_traj(i+1)-t_traj(i));
end
%%
for i=2:n                            %extracting the x-coordinates of the trajectory
    x(:,i-1)=trajectory(:,i);
end
%%
%computing for constant acceleration 
for i=1:n-1
    for j=1:m-2

        delta_p1=x(j+1,i)-x(j,i);
        delta_p2=x(j+2,i)-x(j+1,i);
        if t_traj(j)<= t && (t_traj(j+1)-tau(j))>=t
            p(i)=x(j+1,i)-(((t_traj(j+1)-t)/t_traj(j+1))*delta_p1);
            a(i)=0;
            v(i)=delta_p1/t_traj(j+1);
        elseif (t_traj(j+1)-tau(j))<=t && (t_traj(j+1)+tau(j))>=t
            p(i)=(x(j+1,i))-(delta_p1/(4*tau(j)*t_traj(j+1)))*(t-t_traj(j+1)-tau(j))^2+(delta_p2/(4*tau(j)*t_traj(2+1)))*(t-t_traj(j+1)+tau(j))^2;
            a(i)=(0.5/tau(j))*((delta_p2/t_traj(j+2))-(delta_p1/t_traj(j+1)));
            v(i)=(delta_p1/x(j+1))+a(i)*(t-(0.5*tau(j)));
            break;
        elseif (t_traj(j+1)+tau(j))<=t && (t_traj(j+1)+t_traj(j+2))>=t
            p(i)=x(j+1,i)+(((t-t_traj(j+1))/t_traj(j+2))*delta_p2);
            a(i)=0;
            v(i)=delta_p2/t_traj(j+2);
        end

     end
end

end
