%% Study of the acceptance ratio of AR methods
% figures for the report
% /!\ code takes a while to run

%% Plotting of 1/M

figure

% fixed variance
sigma2 = 1;
m = linspace(0,3,1000);
for i=1:1000
    mMnormal(i) = 2/(1+erf(m(i)/sqrt(2*sigma2)));
    lambda =  (sqrt(m(i)^2+4*sigma2)-m(i))/(2*sigma2);
    K = sqrt(pi*sigma2/2)*(1+erf(m(i)/sqrt(2*sigma2)));
    mMexp(i) = 1/(lambda*K)*exp((lambda^2*sigma2+2*m(i)*lambda)/2);
end

subplot(211)
plot(m,1./mMnormal,m,1./mMexp);
title('1/M comparison for fixed variance \sigma^2 = 1')
legend('Normal candidate law','exponential candidate law','Location','southwest');
xlabel('m'); ylabel('1/M')

% fixed mean
m = 1;
sigma2 = logspace(-2,1,1000);
for i = 1:1000
    sMnormal(i) = 2/(1+erf(m/sqrt(2*sigma2(i))));
    lambda =  (sqrt(m^2+4*sigma2(i))-m)/(2*sigma2(i));
    K = sqrt(pi*sigma2(i)/2)*(1+erf(m/sqrt(2*sigma2(i))));
    sMexp(i) = 1/(lambda*K)*exp((lambda^2*sigma2(i)+2*m*lambda)/2);
end

subplot(212)
semilogx(sigma2,1./sMnormal,sigma2,1./sMexp);
title('1/M comparison for fixed mean m = 1')
legend('Normal candidate law','exponential candidate law','Location','southeast');
xlabel('\sigma^2'); ylabel('1/M')


%% Testing acceptance ratio for several mu and sigma

mu = linspace(0,5,100);
sigma2 = [0.01, 0.1, 1]; 

ratio_norm = zeros(3,100);
ratio_exp = zeros(3,100);

for j = 1:1:3
    for i=1:1:100
        [~, ratio_norm(j,i)] = randnt_ar1(mu(i),sigma2(j),N);
        [~, ratio_exp(j,i)] = randnt_ar2(mu(i),sigma2(j),N);
    end
end

figure()
s(1) = subplot(2,1,1);
plot(mu,ratio_norm(1,:))
hold on
plot(mu,ratio_norm(2,:))
plot(mu,ratio_norm(3,:))
hold off
legend('\sigma^2 = 0.01','\sigma^2 = 0.1','\sigma^2 = 1')
xlabel('\mu')
ylabel('acceptance ratio')
s(2) = subplot(2,1,2);
plot(mu,ratio_exp(1,:))
hold on
plot(mu,ratio_exp(2,:))
plot(mu,ratio_exp(3,:))
hold off
legend('\sigma^2 = 0.01','\sigma^2 = 0.1','\sigma^2 = 1')
xlabel('\mu')
ylabel('acceptance ratio')
title(s(1),'Acceptance ratio for Normal Law Candidate')
title(s(2),'Acceptance ratio for Exponential Law Candidate')