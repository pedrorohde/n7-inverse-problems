% proximal gradient descent for deconvolution

function x = proximalDescent(y,H,lambda,max_iter,pos)

    grad = @(y,H,x) 2*(H'*H*x-H'*y); % gradient of y-Hx

    epsilon = 1e-6;
    x = y;
    last_x = x;
    beta = 0.5;

    k = 1;
    dist = Inf;
    r = y-H*x;
    while dist >= epsilon && k < max_iter % stop criteria : epsilon or number of iterations

        last_r = r;
        r = y-H*x;

        alpha = 0.01; % change alpha at each iteration:
        while norm(r) > norm(last_r)-grad(y,H,x)'*(last_x-x)+1/(2*alpha)*norm(last_x-x)
            alpha = alpha*beta;
        end
        last_x = x;
    
        % update rule :
        x = x - alpha*grad(y,H,x); % gradient descent
        x = prox(lambda,x); % proximal operator
        if pos % if positivity constraint
            x(x<0)=0; % projection onto C = {x : xi >= 0}
        end

        k = k+1;
        dist = abs(norm(y-H*x)^2+lambda*norm(x,1)-norm(y-H*last_x)^2-lambda*norm(last_x,1));

    end
end