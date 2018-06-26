% FUNCTION NAME : dhFwdKine 
% DESCRIPTION   : This function returns forward kinematics of a manipulator 
%                 with the provided DH parameter set. 
%
% OUTPUT        : The output gives a homogenous transform for the manipulator.
%
% INPUT         : The inputs are an array of links, each created by createLink
%                 and an array containing the current state of their joint variables.
%
% NAME          : Akshay Swaminathan
% CWID          : 10832697
% COURSE NO.    : MEGN 544
% DATE          : 11/19/2017
%%
function H = dhFwdKine(linkList, paramList)
