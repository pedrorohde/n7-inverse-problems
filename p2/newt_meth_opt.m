% Newton method with optimal step size


function [x, num_iter, time, f_min] = newt_meth_opt(x_init, max_iter, epsilon, a, b, c, d)


timerVal = tic;

x = x_init;

k = 1;
dist = Inf;
    while dist >= epsilon && k < max_iter % stop criteria : epsilon or iteration number
        last_x = x;

        g = gradf0(x,a,b,c,d);
        h = hessf0(x,a,b,c,d);
        
        alpha = logspace(-3,1,1000);
        [~,idx] = min(f0(x - (h\g)*alpha,a,b,c,d)); % choose alpha with the best descent
    
        x = x - alpha(idx)*h\g; % update rule
        
        k = k+1;
        dist = abs(f0(x,a,b,c,d)-f0(last_x,a,b,c,d));
    end  
    
time = toc(timerVal);
num_iter = k;
f_min = f0(x,a,b,c,d);

end