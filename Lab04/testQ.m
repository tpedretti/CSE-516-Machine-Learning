n = 6;
%% 
% * Randomly Generating Path/Links
%maze = -50*ones(n,n);

%for i=1:(n-3)*n
%    maze(randi([1,n]),randi([1,n]))=1;
%end

%maze(1,1) = 1;
%maze(n,n) = 10;
maze = load('-ascii', 'maze8.mat');

% Display maze in matrix form is:
disp(maze)
n=length(maze);
Goal=n*n;
fprintf('Goal State is: %d',Goal)

%% Creating Reward Matrix for the Maze
reward=zeros(n*n);

for i=1:Goal
    reward(i,:)=reshape(maze',1,Goal);
end

for i=1:Goal
    for j=1:Goal
        if j~=i-n  && j~=i+n  && j~=i-1 && j~=i+1 %n_actions = find(reward(ns,:)>=0);&& j~=i+n+1 && j~=i+n-1 && j~=i-n+1 && j~=i-n-1
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
    cs=1;
    
    % Repeat until Goal state is reached
    while(1)
        
    % possible actions for the chosen state
    n_actions = find(reward(cs,:)>-2);

    % choose an action at random and set it as the next state
    ns = n_actions(randi([1 length(n_actions)],1,1));
       
            % find all the possible actions for the selected state
            n_actions = find(reward(ns,:)>=-2);
            
            % find the maximum q-value i.e, next state with best action
            max_q = 0;
            for j=1:length(n_actions)
                max_q = max(max_q,q(ns,n_actions(j)));
            end
            
            % Update q-values as per Bellman's equation
            q(cs,ns)=reward(cs,ns)+gamma*max_q;
            
            % Check whether the episode has completed i.e Goal has been reached
            if(cs == Goal)
                break;
            end
            
            % Set current state as next state
            cs=ns;
    end
end

%% Solving the maze
% * Starting from the first postion
%%
start = 1;
move = 0;
path = start;
%% 
% * Iterating until Goal-State is reached

while(move~=Goal)
    [~,move]=max(q(start,:));
    
    % Deleting chances of getting stuck in small loops  (upto order of 4)  
    if ismember(move,path)
        [~,x]=sort(q(start,:),'descend');
        move=x(2); 
        if ismember(move,path)
            [~,x]=sort(q(start,:),'descend');
            move=x(3);
            if ismember(move,path)
                [~,x]=sort(q(start,:),'descend');
                move=x(4);
                if ismember(move,path)
                    [~,x]=sort(q(start,:),'descend');
                    move=x(5);
                end
            end
        end
    end
    
    % Appending next action/move to the path
    path=[path,move];
    start=move;
end
%% Solution of maze 
% i.e, Optimal Path between START to GOAL
%%
fprintf('\n\nFinal path: %s',num2str(path))
fprintf('\n\nTotal steps: %d',length(path))