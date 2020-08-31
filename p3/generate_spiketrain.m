function [x,y,y_noisy,sigma2] = generate_spiketrain(N,NSP,SNRdB,wav,n_wav,POSITIVITY);

x = zeros(1,N); id=ceil(rand(1,NSP)*N); x(id)=randn(1,NSP); x=x(:);
if POSITIVITY;x=abs(x);end
    % convolution
    y = conv(wav,x); y = y(n_wav/2:(end-n_wav/2));
    % add noise
    Px = 1/N*norm(x)^2;sigma2 = 10^(-SNRdB/10)*Px;n = sqrt(sigma2)*randn(N,1);y_noisy=y+n;