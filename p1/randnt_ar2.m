% generate truncated Normal with accept-reject and exponential candidate


function [X, ratio] = randnt_ar2(m,sigma2,N)

    lambda =  (sqrt(m^2+4*sigma2)-m)/(2*sigma2);
    K = sqrt(pi*sigma2/2)*(1+erf(m/sqrt(2*sigma2)));
    % M that maximizes the acceptance ratio:
    M = 1/(lambda*K)*exp((lambda^2*sigma2+2*m*lambda)/2);
    
    X = [ ];
    tot = 0;
    accept = 0;
    % accept-reject:
    while length(X) < N

        u = rand;
        x = -1;
        while x < 0
            x = exprnd(1/lambda);
        end
        if u <= truncatedNormal(m,sigma2,x)/(M*exppdf(x,1/lambda))
            X = [X, x];
            accept = accept + 1;
        end
        tot = tot + 1;
    end
    
    ratio = accept/tot;

end