% CSE 516 Machine Learning
% Q - learning coding example
% by YZ
% Consider the following gridworld:
% + - - - - + - - - - + - - - - + - - - - +
% |  START  |         |         |         |
% |    1    |    2    |    3    |    4    |
% |         |         |         |         |
% + - - - - + - - - - + - - - - + - - - - +
% |         |         |         |         |
% |    5    |    6    |    7    |    8    |
% |         |         |         |         |
% + - - - - + - - - - + - - - - + - - - - +
% |         |         |         |         |
% |    9    |   10    |    11   |    12   |
% |         |         |         |         |
% + - - - - + - - - - + - - - - + - - - - +
% |         |         |         |   GOAL  |
% |    13   |    14   |    15   |    16   |
% |         |         |         |         |
% + - - - - + - - - - + - - - - + - - - - +

% transitions. 0 means invalid transition.
%   up,down,left,right
%	Starts 1 to row N
T = [ 0 5 0 2 ; %1 
      0 6 1 3 ; %2
      0 7 2 0 ; %3
      0 8 0 0 ; %4
      1 9 0 6 ; %5
	  2 10 5 7 ; %6
	  3 11 6 8 ; %7
	  4 12 7 0 ; %8
	  5 13 0 10 ; %9
	  6 14 9 11 ; %10
	  7 15 10 12 ; %11
	  8 16 11 0 ; %12
	  9 0 0 14 ; %13
	  10 0 13 15 ; %14
	  11 0 14 16 ; %15
      12 0 15 0 ];%16

% reward in single vector since we have the transition matrix defined separatly
% and R(s'|s,a) is equivalent to R(s')
%R = [-1,-1,-1,-1,-10,10]; 
%R = [-1,-1,-1,-1,-1,-1,-1,-1,-10,-10,-10,-1,-10,-10,-1,100];
R = [   -1,   -1,   -1,  -10,   -1,   -1,   -1,   -1,  -10,  -10,  -10,   -1,  -10,  -10,   -1,  100 ];
% Q matrix
Q = zeros(16,4);
% discount rate : gamma 
gamma = 0.8;
for i=1:10
  ss = 1 ; % start from the start state
  curr = ss; % current state
  path = [];
  path = ss;
  while curr ~= 16
    % pick a random action, and end up in a random valid state.
    possibiles = T(curr,:);
    [action, nxt_state] = random_choice(possibiles);
    % immediate reward:
    imm_r = R(nxt_state);
    
    % this block is to calculate gamma*max(Q'(s',a'))
    future_rewards = [];
    future_states = T(nxt_state,:);
    for a = 1:length(future_states)
      expected_future_state = future_states(a);
      if expected_future_state ~= 0
        future_rewards = [future_rewards Q(nxt_state, a)];
      end
    end
    discounted_max_future_reward = gamma*max(future_rewards);
    % end of block
    
    % update Q value:   
    q_value = imm_r + discounted_max_future_reward;
    Q(curr,action) = q_value;
    
    
    
    curr = nxt_state;
    path(end+1,:) = nxt_state;
  end
  
  display(Q);
  pause(1);
  

end

% pick a random non-zero element from a vector 
% return that element and its index

function [idx, val] = random_choice(v)
  m = length(v);
  while true
    idx = randi([1 m],1);
    val = v(idx);
    if val ~= 0
      break; end;
  end
end
   
    
    
    
    
    
    
    

     