n = 3;

maze = -50*ones(n,n);
for i=1:(n-3)*n
    maze(randi([1,n]),randi([1,n]))=1;
end

maze(1,1) = 1;

maze(n,n) = 10;

%maze = load('-ascii', 'maze0.mat');
%% 
% Display maze in matrix form is:

disp(maze)
%% Visualizing the MAZE
% * Check for atleast one path between Start & Goal
% * Dimension of maze 12x12 i.e., n=12
% * Starting Position is (1,1)
% * Goal is to reach (12,12)
%%
n=length(maze);
Goal=n*n;
fprintf('Goal State is: %d',Goal)
%% Creating Reward Matrix for the Maze
% Possible actions are:
% 
% * Up      :  (i-n)
% * Down :  (i+n)
% * Left    :  (i-1)
% * Right  :  (i+1)
% * Diagonally SE  :  (i+n+1)
% * Diagonally SW :  (i+n-1)
% * Diagonally NE  :  (i-n+1)
% * Diagonally NW :  (i-n-1)
% 
% Reward  is - $\infty$ (i.e. No reward) for any other actions. Thus any 
% other action other then above action will not occur.
%%
reward=zeros(n*n);

for i=1:Goal
    reward(i,:)=reshape(maze',1,Goal);
end

for i=1:Goal
    for j=1:Goal
        if j~=i-n  && j~=i+n  && j~=i-1 && j~=i+1 && j~=i+n+1 && j~=i+n-1 && j~=i-n+1 && j~=i-n-1
            reward(i,j)=-Inf;
        end    
    end
end

for i=1:n:Goal
    for j=1:i+n
        if j==i+n-1 || j==i-1 || j==i-n-1
            reward(i,j)=-Inf;
            reward(j,i)=-Inf;
        end
    end
end
