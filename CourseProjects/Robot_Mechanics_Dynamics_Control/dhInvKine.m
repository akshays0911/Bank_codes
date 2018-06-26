% FUNCTION NAME : dhInvKine 
% DESCRIPTION   : This function returns the parameter list necessary to achieve
%                 a desired homogenous transform and the residual error in that transform. 
%
% OUTPUT        : The output gives the parametrs that produce the desired homogenous transform
%                 and the errors in the transform.
%
% INPUT         : The inputs are a list of joint parameters created
%                 with createLink,the desired homogenous transform and
%                 an initial guess at the parameters.
%
% NAME          : Akshay Swaminathan
% CWID          : 10832697
% COURSE NO.    : MEGN 544
% DATE          : 11/19/2017
%%
function [paramList,error] = dhInvKine(linkList,desTransform,paramListGuess) 
%%
% Argument management:
if nargin < 4
    error_des=0.001*ones(7,1);
else
    error_des=error_des*ones(7,1);
end
    paramListGuess=reshape(paramListGuess,[length(paramListGuess),1]);
    
    T_q_des=Homo2Quat(desTransform);
    T_q_cur=Homo2Quat(dhFwdKine(linkList,paramListGuess));
    
    error=T_q_des-T_q_cur;
    i=0;
    iter_num=1000;
    while (norm(error)>norm(error_des)) && (i<iter_num) ,
        q=T_q_cur(5:end);              % q_vectors
        q_o=T_q_cur(4);                % q_knot
        c=(1/2)*[-q';...
            q_o*eye(3)-cpMap(q)];
        Jv_c =velocityJacobian(linkList,paramListGuess);
        J_g=[eye(3),zeros(3);...
            zeros(4,3),c]*Jv_c;
     
        d_q=pinv(J_g)*error;            % make it positive and without gian now working in 4 itr
       
        paramListGuess=paramListGuess+[d_q];
        T_q_cur=Homo2Quat(dhFwdKine(linkList,paramListGuess));
        error = (T_q_des-T_q_cur)
        i=i+1;
    end
%%
% paramListGuess
% dhFwdKine(linkList,paramListGuess)
    if i >=  iter_num,
        paramList=NaN;
        error=inf;
        error('Solution is not aviable with this method'); 
    else
        paramList=paramListGuess;
        error=norm(error);
    end
end
