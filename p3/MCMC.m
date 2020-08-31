% Gibbs sampling algorithm for deconvolution

function x = MCMC(y,H,lambda,niter,sigma2)

    x = y;
    N = length(y);
    for t = 1:niter
        for i = 1:N
            A = norm(H(:,i));
            B = (H(:,i)'*(y-H(:,[1:i-1,i+1:N])*x([1:i-1,i+1:N]))-2*sigma2*lambda)/A;
            m = B/A; % mean of xi|x\xi,y
            s2 = sigma2/A^2; % variance of xi|x\xi,y
            if m < 0
                x(i) = 0;
            else
                x(i) = randnt_inversion(m,s2); % generate xi following f(xi|x\xi,y) (see report)
            end
        end
        
    end

end