% generate truncated Normal with CDF inversion method

function X = randnt_inversion(m,sigma2)


    X = m + sqrt(2*sigma2)*erfinv(rand*(1+erf(m/sqrt(2*sigma2)))-erf(m/sqrt(2*sigma2)));


end