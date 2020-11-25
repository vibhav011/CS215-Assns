clear;
clc;
close all;
M = 100;
mu = 10.5;
N = [5 10 20 40 60 80 100 500 1000 10000];
A = zeros(100,10);
B = zeros(100,10);
C = zeros(100,10);
for i=1:10    
    sample = 4*randn(N(i),M)+10.5;
    sample_mean = sum(sample,1)/N(i);
    mu_ML = sample_mean;
    mu_MAP_gaussian_prior = (sample_mean*1+10.5*16/N(i))/(1+16/N(i));
    mu_MAP_uniform_prior = sample_mean;
    mu_MAP_uniform_prior( mu_MAP_uniform_prior>11.5) = 11.5;
    mu_MAP_uniform_prior( mu_MAP_uniform_prior<9.5) = 9.5;
    A(:,i) = transpose(abs(mu_ML-mu)/mu);
    B(:,i) = transpose(abs(mu_MAP_gaussian_prior-mu)/mu);
    C(:,i) = transpose(abs(mu_MAP_uniform_prior-mu)/mu);      
end

figure;
boxplot(B,"Color","b");

%h = findobj(gca,'Tag','Box');
%for j=1:length(h)
%    patch(get(h(j),'XData'),get(h(j),'YData'));
%end
hold on;
boxplot(C,"Color","g");

%h2 = findobj(gca,'Tag','Box');
%for j=1:length(h2)
%    patch(get(h2(j),'XData'),get(h2(j),'YData'));
%end
hold on;
boxplot(A,"Color","r");
ylabel('Relative errors for estimates of lambda');
xlabel('N')
set(gca,'XTickLabel',{'5','10','20','40','60','80','100','500',' 1000 ','   10000'});

hold off;







