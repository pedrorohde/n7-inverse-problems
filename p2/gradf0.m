% gradient of 0

function g = gradf0(x,a,b,c,d)

    g = [b*(2*x(1) - 1) + (2*a*d*x(1))/((d*x(1)^2 + x(2)^2)^2 + 1);
         c*(2*x(2) - 2) + (2*a*x(2))/((d*x(1)^2 + x(2)^2)^2 + 1)
         ];


end