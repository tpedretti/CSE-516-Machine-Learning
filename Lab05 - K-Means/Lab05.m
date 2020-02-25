X = load('s1.dat');

K = 2;
epoch = 20;
centroids = initCentroids(X, K);

for i=1:epoch
  indices = reassignPoints(X, centroids);
  %centroids = updateCentroids(X, indices, K);
end

scatter(X(:,1), X(:,2), 32, indices, 'filled')


%%%%%Functions%%%%%
function centroids = initCentroids(X, K)
    centroids = X(randperm(length(X), K), :);
end

function indices = reassignPoints(X, centroids)
    K = size(centroids, 1);
    indices = zeros(size(X, 1), 1);
    
    
    for i = 1:size(X, 1)       
        for j = 2:K
            indices(i,j) = norm(X(i,:) - centroids(j,:)); 
        end
        
        [Distance CN] = min(indices(i,1:K));
        indices(i, K+1) = CN;
        indices(i, K+2) = Distance;  
    end    
end