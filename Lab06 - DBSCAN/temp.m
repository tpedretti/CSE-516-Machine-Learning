%main_dbscan.m
% Load data.
X = load('s2.dat');
X = X(:,[1 2]);
% DBSCAN
% initialize parameters ( you can change them to see the difference)
eps = 0.5
minPts = 5
% initialize indices that contains the label/cluster info of every datapoint.
labels = zeros(size(X,1), 1);
% 0 - the datapoint hasn't been touched
% -1 - the datapoint is considered as noise
% any positive integer (e.g 1,2,3,4,...) cluster label
C = 1 % current cluster label starts with 1 

% walk through all data points:
[m, n] = size(X);
for i = 1:m
  if labels(i)  ~= 0
    continue
  end 
  
  nn  = findNeighbors(X,i,eps);
  if length(nn) < minPts
    labels(i) = -1;
  else 
    extendCluster(X,labels,i,nn ,C, eps, minPts); % This is the other line it refers to for the error 
    C = C +1;
    end
 
end
% Plot
scatter(X(:,1),X(:,2),32,indices,'filled')

%extendCluster.m
function extendCluster(X, labels, p, neighbors, C, eps, minPts)
    labels(p) = C;
    i =1;
    while i <  length(neighbors)
      pnext = neighbors (i);
      if labels(pnext) == -1 % This is the line its referring to for the error
        labels(pnext) = C;
      else
        labels(pnext) =0;
       end
       pnextneighbors  = findNeighbors(pnext,p,eps);
       if length( pnextneighbors > minPts)
         neighbors = neighbors + pnextneighbors;
      end
       i = i + 1; 
    end
end
    
%findNeighbors.m
function neighbors = findNeighbors(X, p, eps)
    % find all data points in X within eps of the current cendroid point p
    % attention p is a number/ the index of the pth data point
    [m, n] = size(X); % m is the number of data points, n is the number of features
    neighbors = []; % initialize empty matrix
    for i = 1:m
      if norm(X(p,:)-X(i,:)) < eps
        neighbors = [neighbors; X(i,:)]; % append datapoint to the matrix
      end
    end
  end