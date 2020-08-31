% truncated NOrmal PDF computation function

function f = truncatedNormal(m,s2,x)
    
    K = sqrt(pi*s2/2)*(1+erf(m/sqrt(2*s2)));
    f = 1/K * exp(-(x-m).^2/(2*s2));
    f(x<0) = 0;
    
    
end