clear;
close all;

rng(190050125);

N = 10 .^ (1:8);                            % Array for differnt values of N
for i=1:length(N)
    batch_size = min(10^5, N(i));           % Restricting batch size to 10^5
    num_batches = floor(N(i)/batch_size);
    total = 0;
    
    for j = 1:num_batches
        sample1 = rand(batch_size,1);         % Generating X1
        sample2 = rand(batch_size,1);         % Generating X2
        total = total + sum((sample1.^2+sample2.^2)<=1);
    end
    
    rem = mod(N(i), batch_size);            % Remaining points (if N is not a power of 10)
    
    if rem > 0
        sample1 = rand(rem, 1);
        sample2 = rand(rem, 1);
        total = total + sum((sample1.^2+sample2.^2)<=1);
    end
    
    pi_estimate = 4*total/N(i);
    fprintf("Pi estimate for N = %d is %f\n", N(i), pi_estimate);
end
