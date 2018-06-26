'''puzzle = [
[4 ,2 ,-2, 4, 4, -3, 4, -3],
[3, 5, 3 ,4 ,2 ,3 ,5, -2],
[4, 3, 2, -5, 2, 2, 5, 2],
[7 ,1 ,4, 4, 4, 2 ,2, 3],
[-3, 2 ,2, 4 ,2, 5 ,2, 5],
[2 ,-3, 2 ,4, 4 ,2, 5 ,-1],
[6 ,2 ,2 ,-3, 2 ,5 ,6, 3],
[1 ,-2, 5, 4 ,4 ,2, -1 ,0]
] '''

#Input the values from a file into a  2-D matrix array
file_read = open('input_file.txt')

puzzle = []
temp = file_read.readline()
while temp != "":
    #print (temp)
    puzzle.append(temp.split())
    puzzle[-1] = [int(i) for i in puzzle[-1]]
    temp = file_read.readline()


# Checking conditions
def satisfy(x,y,R,C):
    if x<R and y<C and x>=0 and y>=0:
        return True
    else:
        return False

 # Getting all the Neighbors of a particular Node by checking the toggle.
 # Toggle checks if the algorithm is traversing Diagnolly or Horizontal/Vertical     
def getNeighbors(puzzle, x,y, Toggle):
    arr = []
    if (puzzle[x][y] > 0 and Toggle == False) or (puzzle[x][y] < 0 and Toggle == True):
        
        arr.append((x - abs(puzzle[x][y]) , y))
        arr.append((x + abs(puzzle[x][y]) , y))
        arr.append((x, y + abs(puzzle[x][y])))
        arr.append((x, y - abs(puzzle[x][y])))
           
        
    if (puzzle[x][y] < 0 and Toggle == False) or (puzzle[x][y] > 0 and Toggle == True):

        arr.append((x + abs(puzzle[x][y]),  y - abs(puzzle[x][y])))
        arr.append((x - abs(puzzle[x][y]) , y - abs(puzzle[x][y])))      
        arr.append((x + abs(puzzle[x][y]) , y + abs(puzzle[x][y])))
        arr.append((x - abs(puzzle[x][y]),  y + abs(puzzle[x][y])))
        
        
    if puzzle[x][y] <0:
        Toggle = not Toggle

    return (arr,Toggle)

arr = []

# BFS is a novel search algorithm which returns all possible traversal routes(paths) from starting till the end
def BFS(puzzle , R, C, x ,y , path , Toggle):
    prev_toggle = Toggle
    
    temp = getNeighbors(puzzle, x,y,Toggle)
    Toggle = temp[1]
    neighbors = temp[0]

    if puzzle[x][y] == 0:
        arr.append (path)
        pass  

    for x1,y1 in neighbors:
        
        if satisfy(x1,y1,R,C)  and ((Toggle,x1,y1,puzzle[x1][y1]) not in path)  :
              
              BFS(puzzle,R,C,x1,y1, path + [((Toggle,x1,y1, puzzle[x1][y1]))], Toggle)


    
                
            
# This return only the shortest path out of all possible paths.      
path = [(False,0,0,puzzle[0][0])]
pa = (BFS(puzzle,8,8,0,0, path ,False))
for i in (arr[0]):
    print (i[1]+1,i[2]+1)

#for k,i in enumerate(arr):
file_name = "output_bfs.txt"
file = open(file_name , 'w+')
string = ""
for j in arr[0]:
    string += (str("(") + str(j[1]+1) + "," + str(j[2]+1) + ")" + "\n")
file.write(string)
file.close()




    
            
