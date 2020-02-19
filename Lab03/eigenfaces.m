% Eignefaces
% data used from http://conradsanderson.id.au/lfwcrop/
% For cse516 machine learning exercise only
% by Yz

% read 64X64 pixel images and unroll to 4096 * 1 vector
filenames = dir('*.pgm');
m = numel(filenames);

for k=1:m
  im = imread(filenames(k).name); %read image
  im=double(im);
  [r,c] = size(im); % get number of rows and columns in image
  I(:,k) = im(:); % convert image to vector and store as column in matrix I
end

% if you are more familiar with row-instances, columns-features, use:
I = I';

% show a face:
for i = 1:5
  imshow(reshape(I(i,:),[r,c]),[]);
end

% show a "mean" face :0
mean_I = mean(I);
imshow(reshape(mean_I,[r,c]),[]);

% Q1. perform PCA, keep 50 principle components.
% you code here
I = I - mean_I;
cov = 1/m*I'*I;
[V L W] = svd(cov);
V_reduced = V(:,1:50);
Z = mean_I*V_reduced;
I_appr = Z*V_reduced;  
% end of code

% Q2. draw eigenfaces ?!
for i = 1:5
   % you code here
  imshow(reshape(V_reduced(:,i),[r,c]),[]);
  % end of code
end


% Q3. show reconstructed faces
for i = 1:5
  % you code here
  imshow(reshape(I_appr(i,:),[r,c]),[]);
  % end of code
end
