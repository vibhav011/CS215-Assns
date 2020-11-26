clear;
close all;
rng(190050125);

M = 100;
lambda = 5;                             % true value 
alpha = 5.5;
beta = 1;

A = zeros(100,10);              % To store ML estimate erros
B = zeros(100,10);              % To store MeanPosterior estimate errors
N = [5 10 20 40 60 80 100 500 1000 10000];

for i=1:10
    sample = -(1/lambda) * log(rand(N(i),M));            % generating transformed variable y 
    sample_sum = sum(sample,1);
    
    % using estimate expressions calculated in the report 
    lambda_ML = N(i)./sample_sum;
    lambda_MAP = (N(i)+alpha)./(sample_sum+beta);
    
    A(:,i) = transpose(abs(lambda_ML-lambda)/lambda); % stores the relative errors for ML estimate
    B(:,i) = transpose(abs(lambda_MAP-lambda)/lambda);   %  stores the relative errors for Mean Aposteriori estimate
end


figure;
boxplot(A, 'Labels', {'5','10','20','40','60','80','100','500','1000','10000'});
xlabel("N");
ylabel("Relative error for Maximum Likelihood Estimate");
title("ML Estimate");

pause(1);
figure;
boxplot(B, 'Labels', {'5','10','20','40','60','80','100','500','1000','10000'});
xlabel("N");
ylabel("Relative error for Mean Aposteriori Estimate");
title("Mean Aposteriori Estimate");
