




clear;
clc;
close all;
M = 100;
lambda = 5;
alpha = 5.5;
beta = 1;
A = zeros(100,10);
B = zeros(100,10);
N = [5 10 20 40 60 80 100 500 1000 10000];
for i=1:10
    sample = -0.2*log(rand(N(i),M));
    sample_sum = sum(sample,1);
    lambda_ML = N(i)./sample_sum;
    lambda_MAP = (N(i)+alpha)./(sample_sum+beta);
    A(:,i) = transpose(abs(lambda_ML-lambda)/lambda);
    B(:,i) = transpose(abs(lambda_MAP-lambda)/lambda);   
end
figure;
boxplot(B,'Color',"r");
hold on;
boxplot(A,'Color',"b");
ylabel('Relative errors for estimates of lambda');
xlabel('N')
set(gca,'XTickLabel',{'5','10','20','40','60','80','100','500',' 1000 ','   10000'});


hold off;






