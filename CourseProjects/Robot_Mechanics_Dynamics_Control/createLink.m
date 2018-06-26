% FUNCTION NAME : createLink 
% DESCRIPTION   : This function creates structure for the inputs
%                 a, d, alpha, theta, centre of mass, mass of the link
%                 and the mass moment of inertia of the link.
%
% OUTPUT        : The output gives a structure containing the given inputs.
%
% INPUT         : The inputs are a, d, alpha, theta, centre of mass, mass of the link
%                 and the mass moment of inertia of the link.
%
% NAME          : Akshay Swaminathan
% CWID          : 10832697
% COURSE NO.    : MEGN 544
% DATE          : 11/19/2017
%%
function L = createLink(a,d,alpha,theta,centOfMass,mass,inertia)
% assigning the isRotary initially to zero
isRotary=0;
L.a=a;
L.d=d;
L.alpha=alpha;
L.theta=theta;
L.com=centOfMass;
L.mass=mass;
L.inertia=inertia;
%% if theta=0 then its prismatic joint else rotary and based upon that pass empty array
if theta==0
    isRotary==0;
    L.d=[];

else
    isRotary==1;
    L.theta=[];
end
