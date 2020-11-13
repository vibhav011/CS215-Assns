clear;
close all;

rng(190050128);

mu = [1; 2];
C = [1.6250, -1.9486; -1.9486, 3.8750];          % Given covariance matrix
[U, D2] = eig(C);
A = U*sqrt(D2);

samples = [10 100 1000 10000 100000];
mean_error = zeros(100, 5);         % For boxplot of error in ML mean
cov_error = zeros(100, 5);          % For boxplot of error in ML cov

for i = 1:5
    N = samples(i);
    
    % Part (b) and (c)
    
    for trial = 1:100
        W = randn([2 N]);
        X = A*W + mu;                  % Generated sample with required mean and covariance matrix
        
        mu_ = sum(X, 2)/N;              % ML estimate of mean
        mu_error = sqrt((mu - mu_)' * (mu - mu_) / (mu' * mu));
        mean_error(trial, i) = mu_error;
        
        C_ = (X - mu_) * (X - mu_)' / N;              % ML estimate of covariance matrix
        C_error = sqrt(sum((C - C_) .^2, 'all') / sum(C .^2, 'all'));
        cov_error(trial, i) = C_error;
    end
    
    % Part (d)
    [U_, D_] = eig(C_);
    l = diag(sqrt(D_));                 % 2x1 vector containing eigenvalues
    
    figure;
    scatter(X(1, :), X(2, :));
    axis equal;
    hold on;
    X1 = [mu_(1) mu_(1)];
    Y1 = [mu_(2) mu_(2)];
    X2 = X1 + [l(1)*U_(1, 1) l(2)*U_(1, 2)];
    Y2 = Y1 + [l(1)*U_(2, 1) l(2)*U_(2, 2)];
    plot([X1; X2], [Y1; Y2], 'r');
    hold off;
    title(['Scatter plot and principal modes when N = ', num2str(N)]);
    pause(2);
end

figure;
boxplot(mean_error);
title('Error between true mean and ML estimate of mean');
xlabel('log_{10}(N)');
pause(2);
figure;
boxplot(cov_error);
title('Error between true cov and ML estimate of cov matrix');
xlabel('log_{10}(N)');