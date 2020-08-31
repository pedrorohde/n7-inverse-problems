% script to analytically calculate hessian and gradient of f0

x = sym('x',[2,1]);
syms a b c d x10 x20;

f0(x) = a*atan(d*x(1)^2+x(2)^2) + b*(x(1)-x10)^2 + c*(x(2)-x20)^2;

gradient(f0)
hessian(f0)