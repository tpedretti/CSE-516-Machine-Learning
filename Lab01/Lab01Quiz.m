%Taylor Pedretti%
%005488635%
%Lab01%

%### Answer the following Matlab Questions. It is suggested to answer the
%questions via matlab code examples, if applied.%

%1.     How to define a matrix? %
A = [1 2 3; 4 5 6; 7 8 9];

%2.     Given a matrix, how to retrieve the matrix size (number of rows and number of columns)?%
s = size(A);

%3.     How to get the inverse of a matrix? %
i = inv(A);

%4.     How to get the Eigen values and Eign vectors of a square matrix? Show it. %
[V,W] = eig(A);

%5.     Given mXm matrix A and mX1 vector b, how to solve x  in Ax=b? %
C = [1.6 2.8 3.4]';
D = linsolve(A, C);

%6.     How to add comments in Matlab? %
%You can use the % to add comments %

%7.     How to take user’s input in m-file? %
prompt = 'Enter a number:';
P = input(prompt);

%8.     How to set a breakpoint in m-file? For example, set a breakpoint in line 5.   %
%You click the small gray area next to the line count and click the line of
%code you'd like to add the breakpoint%

%9.     How to check intermediate result of a variable (e.g. x) when program runs to line i (e.g. line 10)? %
%add a display(x) right before line 10%
display(A);

%10.    How to plot y=sin(x) for x between 0-2Pi with increment pi/10? %
x = [0:pi/10:2*pi];
y = sin(x);
plot(x,y);

%11.    In above plot, add axis labels in the plot. %
xlabel('x-axis');ylabel('y-axis');title('my plot');

%12.    Change color of line in the plot to red. %
plot(x,y,'r');

%13.    Show the dots in the plot with marker ‘*’. %
plot(x,y,'*');

%14.    Decrease the increment from pi/10 to pi/20 and re-plot.  %
x = [0:pi/20:2*pi];
y = sin(x);
plot(x,y);
hold on;
%15.    Graph cos(x) and sin(x) functions in one figure with different colors and add a legend for the graphs. %
z = cos(x);
plot(x,y, 'r*', x, z, 'b.');

%16.    Split lab1_data.dat into train_x, train_y, test_x, test_y four matrices. %
myFile = load('Lab1_data.dat');

train_x = myFile(:,1);
train_y = myFile(:,2);
test_x = myFile(:,3);
test_y = myFile(:,4);
