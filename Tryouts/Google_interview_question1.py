"""
Given a string A consisting of n characters and a string B 
consisting of m characters, write a function that will return 
the number of times A must be stated such that B is a substring 
of the repeated A. If B can never be a substring, return -1.
"""
#@author - Akshay Swaminathan


import math
def solution(A, B):
    
    repetition =  math.ceil(len(B)/len(A))
    if B in (A * (repetition)):
        return (repetition)
    elif B in (A * (repetition + 1)):
        return (repetition + 1)
    return -1

print (solution("abcd" , "cdabcdab"))