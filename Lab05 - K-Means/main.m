X = load('s1.dat');

K = 7;
epoch = 20;
centroids = initCentroids(X, K);

for i=1:epoch
  indices = reassignPoints(X, centroids);
  centroids = updateCentroids(X, indices, K);
end

scatter(X(:,1), X(:,2), 32, indices, 'filled')


%%%%%Functions%%%%%
function centroids = initCentroids(X, K)
    centroids = zeros(K,size(X,2)); 
    
    % Randomly reorder the indices of examples
    randidx = randperm(size(X,1));
    % Take the first K examples as centroids
    centroids = X(randidx(1:K), :);
 
  end
  
function indices = reassignPoints(X, centroids)
	% you code here
    K = size(centroids, 1);
    indices = zeros(size(X,1), 1);
    m = size(X,1);

    for i=1:m
        k = 1;
        min_dist = sum((X(i, :) - centroids(1, :)) .^ 2);
        
        for j = 2:K
            dist = sum((X(i, :) - centroids(j, :)) .^ 2);
            if(dist < min_dist)
                min_dist = dist;
                k = j;
            end
        end
        
        indices(i) = k;
    end
end

function centroids = updateCentroids(X, idx, K)

  [m n] = size(X);
  centroids = zeros(K, n);
  
  for i=1:K
    % you code here
	xi = X(idx == i, :);
	ck = size(xi, i);
	
	centroids(i, :) = (1/ck) * [sum(xi(:, 1)) sum(xi(:, 2))];
  end
end
