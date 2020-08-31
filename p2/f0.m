% computation of f0(x)

function f = f0(x,a,b,c,d)

f = a*atan(d*x(1,:).^2+x(2,:).^2) + b*(x(1,:)-0.5).^2 + c*(x(2,:)-1).^2;


end