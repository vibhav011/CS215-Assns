clear;
close all;
files = ['../data/points2D_Set1.mat'; '../data/points2D_Set2.mat'];

for fi = 1:2
    S = load(files(fi, :));                   % reading the data from the given file

    x = S.x;
    y = S.y;
    n = length(x);
    points = [x'; y'];                      % 2xn matrix
    mean = sum(points, 2)/n;
    pf = points - mean;                     % mean shifted points

    % covariance matrix
    C = pf * pf' / (n-1);

    % V is  a matrix having eigenvectors of C (covariance matrix) as columns 
    % D is a diagonal matrix containing the corresponding eigenvalues 
    [V,D] = eig(C); 
    % sorting the diagonal entries in descening order and arranging the eigenvectors accordingly 
    [d,ind] = sort(diag(D),"descend");
    Ds = D(ind,ind);
    Vs = V(:,ind);

    % dir is the principal direction obtained by pca
    dir = Vs(:,1);

    figure;
    plot1 = gscatter(x,y);
    hold on;
    xg = x;
    % linear realtionship between x and y obtained by pca 
    yg = (dir(2)/dir(1)) * (xg - mean(1)) + mean(2);
    eqn = ['y = ', num2str(dir(2)/dir(1)), 'x + ', num2str(mean(2) - dir(2)/dir(1) * mean(1))];
    plot2 = plot(xg,yg,'b','LineWidth',1.2,'DisplayName', eqn);
    title(['Dataset', num2str(fi), ' points & estimated linear relationship between x & y']);
    legend()
    hold off
end


