clear;
clc;
close all;
N = [10,100,1000,10000,100000,1000000,10000000,100000000];
for i=1:length(N)
    sample1 = rand(N(i),1);
    sample2 = rand(N(i),1);
    sample = ((sample1.^2+sample2.^2)<=1);
    pi_estimate = 4*sum(sample)/N(i)  % printing pi_estimate in the command window
end

