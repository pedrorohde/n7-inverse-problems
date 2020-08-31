% generate truncated Normal with accept-reject and Normal candidate

function [X, ratio] = randnt_ar1(m,sigma2,N)
    
    % M that maximizes the acceptance ratio:
    M = 2/(1+erf(m/sqrt(2*sigma2)));

    X = [ ];
    tot = 0;
    accept = 0;
    
    % accept-reject:
    while length(X) < N

        u = rand;
        x = normrnd(m,sqrt(sigma2));
        if u <= truncatedNormal(m,sigma2,x)/(M*normpdf(x,m,sqrt(sigma2)))
            X = [X, x];
            accept = accept + 1;
        end
        tot = tot + 1;
    end
    
    ratio = accept/tot;
    
end