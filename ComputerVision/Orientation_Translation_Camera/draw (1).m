%Scale and transpose
center = [4 4 4];
cubesize = 2;

%Vertices for Line Cube. Order matters
X = [0 0 1 1 0 0 1 1 1 1 1 1 0 0 0 0 0]';
Y = [0 1 1 0 0 0 0 0 0 1 1 1 1 1 1 0 0]';
Z = [0 0 0 0 0 1 1 0 1 1 0 1 1 0 1 1 0]';

X=[6.8158 7.8493 9.9579 8.8219 9.5890 10.8082 13.2690]';
Y=[-35.1954 -36.1723 -25.2799 -38.3767 -28.8402 -48.8146 -58.0988]';
Z=[43.0640 43.7815 40.1151 46.6153 42.2858 56.1475 59.1422]' ;

%Example two cube matrix. Unit cube and one scaled/translated cube
X1 = [X X*cubesize+center(1)];
Y1 = [Y Y*cubesize+center(2)];
Z1 = [Z Z*cubesize+center(3)];

%Single plot command for all 'cube lines'
plot3(X,Y,Z);
