%clear all;
close all;
%% 
% see also acceptanceRatioStudy for a study on the acceptance ratio of the
% Accept-Reject methods


% PART 1 SIMULATION OF A GAUSSIAN LAW TRUNCATED TO POSITIVE VALUES

m = 0;
sigma2 = 1;
N = 1000;

x = linspace(max(0,m-3.5*sqrt(sigma2)),m+3.5*sqrt(sigma2),N);
PDF_TN = truncatedNormal(m, sigma2,x'); % truncated normal PDF

%% Inversion of CDF method

x_inversion = randnt_inversion(m, sigma2, N);


figure;

hinv = histogram(x_inversion,15);
points_inv = (hinv.BinEdges(2:15+1)+hinv.BinEdges(1:15))./2;
hist_norm_inv = hinv.BinCounts/(N*hinv.BinWidth);

bar(points_inv,hist_norm_inv)
hold on
plot(x,PDF_TN)
hold off
legend('CDF Inversion Histogram', 'Theoretical Distribution')
title({'Simulation using the CDF Inversion method'; ['m = ',num2str(m),' \sigma^2 = ',num2str(sigma2)]})


%% Accept Reject 1 : Normal candidate


[x_ar1, ar1_ratio] = randnt_ar1(m,sigma2,N);

figure;

har1 = histogram(x_ar1,15);
points_ar1 = (har1.BinEdges(2:15+1)+har1.BinEdges(1:15))./2;
hist_norm_ar1 = har1.BinCounts/(N*har1.BinWidth);


bar(points_ar1,hist_norm_ar1)
hold on
plot(x,PDF_TN)
hold off
legend('Accept/Reject Histogram', 'Theoretical Distribution')
title({'\fontsize{10}Simulation using the Accept/Reject method with Normal law as a candidate'; ['m = ',num2str(m),' \sigma^2 = ',num2str(sigma2)]})

%% Accept Reject 2 : exponential candidate


[x_ar2, ar2_ratio] = randnt_ar2(m,sigma2,N);

figure;

har2 = histogram(x_ar2,15);
points_ar2 = (har2.BinEdges(2:15+1)+har2.BinEdges(1:15))./2;
hist_norm_ar2 = har2.BinCounts/(N*har2.BinWidth);

bar(points_ar2,hist_norm_ar2)
hold on
plot(x,PDF_TN)
hold off
legend('Accept/Reject Histogram', 'Theoretical Distribution')
title({'\fontsize{9}Simulation using the Accept/Reject method with exponential distribution as a candidate'; ['m = ',num2str(m),' \sigma^2 = ',num2str(sigma2)]})

%%

%%


