clear;
clc;
close all;
M = 100;
mu = 10.5;
for N = [5 10 20 40 60 80 100 500 1000 10000]
    sample = 4*randn(N,M)+10.5;
    sample_mean = sum(sample,1)/N;
    mu_ML = sample_mean;
    mu_MAP_gaussian_prior = (sample_mean+16*10.5)/17;
    mu_MAP_uniform_prior = sample_mean;
    A = transpose(abs(mu_ML-mu)/mu);
    B = transpose(abs(mu_MAP_gaussian_prior-mu)/mu);
    C = transpose(abs(mu_MAP_uniform_prior-mu)/mu);
    group = [    ones(size(A));
         2 * ones(size(A));
         3 * ones(size(A))];
    figure
    boxplot([A; B; C],group)
    title(N+" sample points");
    set(gca,'XTickLabel',{'mu_ML','mu_MAP1','mu_MAP2'})
end









