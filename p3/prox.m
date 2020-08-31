% proximal gradient for L1-norm (g(x) = |x|_1)

function y = prox(lambda,x)
    
    y = zeros(size(x));
    y(x>=lambda) = x(x>=lambda) - lambda;
    y(x<=-lambda) = x(x<=-lambda) + lambda;

end