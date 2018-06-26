% FUNCTION NAME : cpMap 
% DESCRIPTION   : Returns the matrix packing of the cross product operator. 
%                 (i.e.,) Given vectors W and V, cpMatrix(W) * V = W x V
%                 Returns cross product matrix for a vector. 
% X = cpMap(w).......produces the cross-product matrix that is obatined
% using the input "w" vector.
%
% OUTPUT        : The output obtained is a cross-product matrix that can be
%                 multiplied directly in places where the vector is to be used.
%
% INPUT         : The input supplied is in the form of a vector represneted
%                 as "w".
%
% NAME          : Akshay Swaminathan
% CWID          : 10832697
% COURSE NO.    : MEGN 544
% DATE          : 10/01/2017
%%
function X = cpMap(w)
X=[0 -w(3) w(2) ;       %final cross-product matrix
   w(3) 0 -w(1) ;
   -w(2) w(1) 0 ];
end
