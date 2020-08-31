%% main_deconvolution_OMP.m
%

% /!\ code takes a while to run with MC = 100 independent realizations

%% forward model:
% y = H*x + e
%   H - convolution matrix
%   x - sparse vector of coefficients
%   e - i.i.d Gaussian noise


clear all


% 1D signal
N = 2^8;    % signal length
NSP=10;     % number of spikes

% wavelet
n_wav = 32; [wav,supp_wave] = morlet(-3,3,n_wav);

% simulation setup
SNRdB = 10; % signal to noise ratio
POSITIVITY=1; % constrain coefficients x to be positive
MC=1;     % number of independent realizations

nit=100;    % maximum number of iterations

% matrix formulation
H =  convmtx(wav',N); H_trunc = H(n_wav/2:(end-n_wav/2),:);

tic
for i=1:MC
    % generate spike train and add noise
    [x,y,y_noisy,sigma2] = generate_spiketrain(N,NSP,SNRdB,wav,n_wav,POSITIVITY);
    
    % orthogonal matching pursuit
    tic;
    x_omp   =orthogonalmatchingpursuit(y_noisy,H_trunc,sqrt(sigma2*N),nit);
    t_omp(i) = toc;
    
    % proximal descent 
    lambda = 1e-2;
    tic;
    x_prox = proximalDescent(y_noisy,H_trunc,lambda,1e3,POSITIVITY);
    t_prox(i) = toc;
    % ...
    
    % MCMC
    lambda = 100;
    tic;
    x_mcmc = MCMC(y_noisy,H_trunc,lambda,lambda,sigma2);
    t_mcmc(i) = toc;
    
    % performance analysis
    NZMP_OMP(i)=length(find(abs(x_omp)>1e-8));              % number of non-zero elements
    MRESMP_OMP(i)=sum((x(:)-x_omp(:)).^2)/sum(x(:).^2);     % relative mean squared error
    NZMP_prox(i)=length(find(abs(x_prox)>1e-8));              % number of non-zero elements
    MRESMP_prox(i)=sum((x(:)-x_prox(:)).^2)/sum(x(:).^2);     % relative mean squared error
    NZMP_MCMC(i)=length(find(abs(x_mcmc)>1e-8));              % number of non-zero elements
    MRESMP_MCMC(i)=sum((x(:)-x_mcmc(:)).^2)/sum(x(:).^2);     % relative mean squared error
end
toc
disp(['OMP               - relative MSE=',num2str(mean(MRESMP_OMP)),' (',num2str(mean(NZMP_OMP)),' average non-zero coefficients)']);
disp(['proximal gradient - relative MSE=',num2str(mean(MRESMP_prox)),' (',num2str(mean(NZMP_prox)),' average non-zero coefficients)']);
disp(['Gibbs sampler     - relative MSE=',num2str(mean(MRESMP_MCMC)),' (',num2str(mean(NZMP_MCMC)),' average non-zero coefficients)']);


figure
subplot(311),plot(y_noisy),hold on,plot(x);
title('x and y = Hx+n');
legend('y', 'x');
subplot(312),plot(x),hold on,plot(x_prox);
title('Proximal gradient method');
legend('original x', 'approximation');
subplot(313),plot(x),hold on,plot(x_mcmc);
title('Gibbs sampling algorithm');
legend('original x', 'approximation');
