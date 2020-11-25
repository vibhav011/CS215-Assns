clear;
clc;
close all;
M = 100;
lambda = 5;
alpha = 5.5;
beta = 1;
for N = [5 10 20 40 60 80 100 500 1000 10000]
    sample = -0.2*log(rand(N,M));
    sample_sum = sum(sample,1);
    lambda_ML = N./sample_sum;
    lambda_MAP = (N+alpha-1)./(sample_sum+beta);
    A = transpose(abs(lambda_ML-lambda)/lambda);
    B = transpose(abs(lambda_MAP-lambda)/lambda);
    group = [ones(size(A));
         2 * ones(size(A))];
    figure
    boxplot([A; B],group)
    title(N+" sample points");
    set(gca,'XTickLabel',{'lambda_ML','lambda_MAP'})
end









