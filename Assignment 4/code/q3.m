clear;
clc;
close all;
S = load('points2D_Set1.mat'); % reading the data from the given file

x = S.x;
y = S.y;
n = length(x);
sum_x = sum(x);
sum_y = sum(y);
mean_x = sum_x/n;
mean_y = sum_y/n;
xf = x-mean_x; % mean shifted data 
yf = y-mean_y;  % mean shifted data 


% calculating all the entries of the covariance matrix
c12 = transpose(xf)*yf/n; 
c21 = c12;
c11 = transpose(xf)*xf/n;
c22 = transpose(yf)*yf/n;
c = zeros(2,2);
c(1,1)=c11;
c(1,2)=c12;
c(2,1)=c21;
c(2,2)=c22;
% V is  a matrix having eigen vectors of c (covariance matrix) as columns 
% D is a diagonal matrix containing the corresponding eigen values 
[V,D] = eig(c); 
% sorting the diagonal entries in descening order and arranging the eigen
% vectors accordingly 
[d,ind] = sort(diag(D),"descend");
Ds = D(ind,ind);
Vs = V(:,ind);

% dir is the principal direction obtained by pca
dir = Vs(:,1);
% rhs is the constant term in the linear representation of y as a function of x
rhs = dir(1)*mean_y-dir(2)*mean_x;
figure;
plot1 = gscatter(x,y);
hold on;
xg = (-0.5:0.01:1.5);
yg = (rhs/dir(1))+(dir(2)/dir(1))*xg; % linear realtionship between x and y obtained by pca 
plot2 = plot(xg,yg,'b','LineWidth',1.2,'DisplayName','-0.8513x+0.5247y=1.411');
legend()
hold off



S2 = load('points2D_Set2.mat');
fieldnames(S2);
x2 = S2.x;
y2 = S2.y;
n2 = length(x2);
sum_x2 = sum(x2);
sum_y2 = sum(y2);
mean_x2 = sum_x2/n2;
mean_y2 = sum_y2/n2;
xf2 = x2-mean_x2;
yf2 = y2-mean_y2;

cc12 = transpose(xf2)*yf2/n2;
cc21 = cc12;
cc11 = transpose(xf2)*xf2/n2;
cc22 = transpose(yf2)*yf2/n2;
cc = zeros(2,2);
cc(1,1)=cc11;
cc(1,2)=cc12;
cc(2,1)=cc21;
cc(2,2)=cc22;
[VV,DD] = eig(cc);
[dd,ind2] = sort(diag(DD),"descend");
Ds2 = DD(ind2,ind2);
Vs2 = VV(:,ind2);

dir2 = Vs2(:,1);
rhs2 = -dir2(2)*mean_x2+dir2(1)*mean_y2;
figure;
plot3 = gscatter(x2,y2);
hold on;
xg2 = (-2:0.01:2);
yg2 = (rhs2/dir2(1))+(dir2(2)/dir2(1))*xg2;
plot4 = plot(xg2,yg2,'b','LineWidth',1.2,'DisplayName','-0.0162x+0.9999y=+0.6532');
legend();
hold off;









