% pick a random non-zero element from a vector 
% return that element and its index

function [idx, val] = random_choice(v)
  m = length(v);
  while true
    idx = randi([1 m],1);
    val = v(idx);
    if val ~= 0
      break; 
    end;
  end
end