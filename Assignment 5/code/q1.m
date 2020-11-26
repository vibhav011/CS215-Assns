clear;
close all;
rng(190050125);

M = 100;
mu = 10;                          % True mean
N = [5 10 20 40 60 80 100 500 1000 10000];
A = zeros(M,10);                  % Stores relative errors for ML estimate
B = zeros(M,10);                  % Stores relative errors for MAP1 estimate
C = zeros(M,10);                  % Stores relative errors for MAP2 estimate
for i=1:10    
    sample = 4*randn(N(i), M) + mu;         % Generating data
    sample_mean = sum(sample,1)/N(i);
    mu_ML = sample_mean;                    % ML estimate of mean for each of M values
    
    mu_MAP_gaussian_prior = (sample_mean*1 + 10.5*16/N(i))/(1 + 16/N(i));
    % Using the formula derived in report. Here mu_0 = 10.5, sigma_true = 4 and sigma_0 = 1
    
    % As derived in report, MAP2 estimate is equal to ML estimate if it
    % lies between 9.5 and 11.5. If greater than 11.5 then set it equal to
    % 11.5. If less than 9.5 then set it equal to 9.5.
    mu_MAP_uniform_prior = sample_mean;
    mu_MAP_uniform_prior (mu_MAP_uniform_prior > 11.5) = 11.5;
    mu_MAP_uniform_prior (mu_MAP_uniform_prior < 9.5) = 9.5;
    
    A(:,i) = transpose(abs(mu_ML - mu)/mu);
    B(:,i) = transpose(abs(mu_MAP_gaussian_prior - mu)/mu);
    C(:,i) = transpose(abs(mu_MAP_uniform_prior - mu)/mu);      
end

figure;
boxplot(A, 'Labels', {'5','10','20','40','60','80','100','500','1000','10000'});
xlabel("N");
ylabel("Relative error for ML Estimate");
title("ML Estimate");

pause(1);
figure;
boxplot(B, 'Labels', {'5','10','20','40','60','80','100','500','1000','10000'});
xlabel("N");
ylabel("Relative error for MAP1 Estimate");
title("MAP1 Estimate");

pause(1);
figure;
boxplot(C, 'Labels', {'5','10','20','40','60','80','100','500','1000','10000'});
xlabel("N");
ylabel("Relative error for MAP2 Estimate");
title("MAP2 Estimate");


