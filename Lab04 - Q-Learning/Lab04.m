%Taylor Pedretti
%005488635
clear;
%Size of our world
%n is our width
prompt = 'Enter n for size of grid world: ';
n = input(prompt);
Goal=n*n;

%Create our world
maze = -1*ones(1,(n*n));

%Generate random -10 for bad points we can't pass at a 20% chance
for i=1:(length(maze))
    if randi([1 10],1,1) > 8
        maze(i) = -10;
    end
end

%Start and end locations
maze(1) = -1;
maze(Goal) = 10;

%Used if have a maze saved good for testing!
%maze = load('-ascii', 'maze11.mat');

%Display my Grid World
for i=0:(n-1)
  for j=1:n
      world = maze(n * i + j);
      fprintf('%+12.2f', world);
    end
    fprintf(1, '\n');
end


fprintf('Goal State is: %d',Goal)
%Create a reward matrix that is used as transtion table
reward = zeros(1, (n*n));

for i=1:(Goal-1)
  reward(end+1,:) = reshape(maze, 1, Goal);
end
%All movements that can be done in each square up, down, left, right
for i=1:Goal
    for j=1:Goal
        if j~=i-n  && j~=i+n  && j~=i-1 && j~=i+1
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

%%%%%%%%%%%%%%%%%Q-LEARNING MATH%%%%%%%%%%%%%%%%%%%%%%
q = randn(size(reward));
gamma = 0.9;
alpha = 0.2;
maxItr = 50;

for i=1:maxItr
    
    % Starting from start position    
    cs = 1;
    
    % Repeat until Goal state is reached
    while(1)
        
      % possible actions for the chosen state
      n_actions = find(reward(cs,:) >= -2);
      % choose an action at random and set it as the next state
      ns = n_actions(randi([1 length(n_actions)],1,1));
      % find all the possible actions for the selected state
      n_actions = find(reward(ns,:) >= -2);
      % find the maximum q-value i.e, next state with best action
      max_q = 0;
      for j=1:length(n_actions)
        max_q = max(max_q,q(ns,n_actions(j)));
      end
      % Update q-values as per Bellman's equation
      q(cs,ns)=reward(cs,ns)+gamma*max_q;

      if(cs == Goal)
        break;
      end
      % Set current state as next state
      cs = ns;
    end
end

%Going though the paths to find the shortest and final path
start = 1;
move = 0;
path = start;

while(move ~= Goal)
    [~,move] = max(q(start,:));
    path = [path,move];
    start = move;
end

fprintf('\nFinal path: %s \n',num2str(path))
fprintf('Total steps: %d \n',length(path))