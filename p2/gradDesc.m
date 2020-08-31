% gradient descent with fixed step size

function [x, num_iter, time, f_x] = gradDesc(x_init, max_iter, epsilon, alpha, a, b, c, d)
timerVal = tic;

x = x_init;

k = 1;
dist = Inf;

    while dist >= epsilon && k < max_iter % stop criteria : epsilon or iteration number

        last_x = x;

        g = gradf0(x,a, b, c, d);

        x = x - alpha*g; % update rule

        k = k+1;
        dist = abs(f0(x,a,b,c,d)-f0(last_x,a,b,c,d));

    end
    
time = toc(timerVal);
num_iter = k;
f_x = f0(x,a,b,c,d);

end

