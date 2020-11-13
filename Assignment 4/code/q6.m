clear;
close all;
rng(1000);

D = '../data/data_fruit';
img = zeros(19200, 16);
S = dir(fullfile(D,'*.png'));       % pattern to match filenames.
N = length(S);                      % Number of images = 16
for k = 1:N
    F = fullfile(D,S(k).name);
    I = imread(F);
    img(:, k) = reshape(I,[19200,1]); % initialising a matrix containing images as 19200x1 column vectors
end

mean = sum(img,2)/N;                    % mean of 16 images 
imgs = img-mean;
cv = imgs * imgs' / max(1, N-1);        % covariance of 16 images 
[U, S] = eigs(cv,4);                    % eigenvectors and eigenvalues 

t = tiledlayout(1, 5);
title(t, 'First four images are the eigenvectors and rightmost is the mean');
for i=1:4
    % plotting the first 4 eigenvectors with the one with the highest
    % eigenvalue on the left (in the same subplot)
    show_im = reshape(U(:,i) * sqrt(S(i,i)) + mean,[80,80,3]);
    nexttile;
    imshow(double(show_im)/255.0);
    axis equal;
end
% displaying the mean image in the rightmost position in the figure
% containing the eigenvector subplots 
nexttile;
imshow(reshape(double(mean)/255.0,[80,80,3]));
axis equal;
pause(1);

% finding and plotting the first 10 eigen vectors
ten_eigen = eigs(cv,10);
figure;
plot(ten_eigen,'o-');
title('First 10 eigenvalues');
ylabel('Eigenvalues');
pause(3);

% represeinting each image as a combination of first four eigenvectors and
% mean
for i=1:16
    figure;
    t = tiledlayout(1, 2);
    title(t, ['Image ', num2str(i)]);
    
    nexttile;
    imshow(reshape(double(img(:, i))/255.0,[80,80,3]));         % Oirginal image
    title('Original image');
    
    nexttile;
    new_image = U * (U' * imgs(:, i)) + mean;
    imshow(reshape(double(new_image)/255.0, [80,80,3]));
    title('Closest representation');
    
    pause(2);
end

% Generating new images
figure;
t = tiledlayout(1, 3);
title(t, 'Randomly generated images');
for i=1:3
    nexttile;
    coeffs = sqrt(S) * randn(4, 1);
    generated_image = U * coeffs + mean; 
    imshow(reshape(double(generated_image)/255.0,[80,80,3]));
end


