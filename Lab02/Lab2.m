OrigData = load('Orig_Data.dat');

%Part 1 for Figure 3.1 of Lab02%

orig_x = OrigData(:,1);
orig_y = OrigData(:,2);

origXmean = mean(orig_x);
origYmean = mean(orig_y);

adjDataX = orig_x - origXmean;
adjDataY = orig_y - origYmean;

plot(orig_x, orig_y, '+');
title('Original data');
axis([-1 4 -1 4]);

%Part 2 for Figure 3.2 of Lab02%
cov_mtax = cov(adjDataX, adjDataY);
[eigenvectors, eigenvalues] = eig(cov_mtax);

plot(adjDataX, adjDataY, '+');
title('Normalized data with primary components');
hold on;
plot(eigenvalues(:), eigenvalues(:));
plot(-eigenvalues(:), -eigenvalues(:));
plot(eigenvalues(:), -eigenvalues(:));
plot(-eigenvalues(:), eigenvalues(:));
axis([-2 2 -2 2]);
hold off;

%Part 3 for Figure 3.3 of Lab02%
daXY = [adjDataX,adjDataY];
FinalData = daXY * eigenvectors;

FinalData = fliplr(FinalData);
FinalData(:,1) = -FinalData(:,1);

plot(FinalData(:,1), FinalData(:,2), '+');
title('Data in new space');
axis([-2 2 -2 2]);

%Part 4 for Figure 3.4 of Lab02%
FinalVector = eigenvectors(:,2);
fVTrans = transpose(FinalVector);
daA = transpose(daXY);

Final_data_2 = fVTrans * daA;
rowDATAdj = FinalVector * Final_data_2;

rDAdjX = rowDATAdj(1,:);
rDAdjY = rowDATAdj(2,:);

plot(orig_x, orig_y, '+');
hold on;

plot(rDAdjX, rDAdjY, '.');
hold off;

title('Data with reduced dimension');
title('Data with reduced dimension w/ Legend');
legend('3.1 Original Data', '3.4 Reduced Dim');
axis([-2 5 -2 5]);


