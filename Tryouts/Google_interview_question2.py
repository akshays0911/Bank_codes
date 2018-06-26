"""
 Consider an undirected tree with N nodes, numbered from 1 to N. 
 Each node has a label associated with it, which is an integer 
 value. Different nodes can have the same label. 
 Write a function that, given a zero indexed array A of length N, 
 where A[j] is the label value of the (j + 1)-th node in the tree 
 and a zero-indexed array E of length K = (N – 1) * 2 in which the 
 edges of the tree are described, returns the length of the longest 
 path such that all the nodes on that path have the same label. 
 The length is the number of edges in that path.
 """

 #@author- Akshay Swaminathan

 """
 A = [1,1,1,2,2]


E = [1,2,1,3,2,4,2,5]


def solution(A,E):

    

    path = [1]
    for i in range(len(A)):

        if  (2*i) < len(A) and  (A[i]) == A[2*i]:
            path[-1] += 1


        elif (2 * (i+1)<len(A)) and (A[i]) == A[2*i+1]:
            path[-1] += 1

    return(path[0])

print (sol(A))


"""

def solution(A,E):

    

    path = [1]
    for i in range(len(A)):

        if  (2*i) < len(A) and  (A[i]) == A[2*i]:
            path[-1] += 1


        elif (2 * (i+1)<len(A)) and (A[i]) == A[2*i+1]:
            path[-1] += 1

    return(path[0])

print (solution(A,E))
