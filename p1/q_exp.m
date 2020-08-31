function q = q_exp(m,s2,x)

    lambda =  (sqrt(m^2+4*s2)-m)/(2*s2);
    q = lambda*exp(-lambda*x);
    q(x<0) = 0;

end