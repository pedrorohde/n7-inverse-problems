
function [x Tab_a Tab_k Tab_r] = matchingpursuit(y,H,thres,T)

[N M] = size(H);

t = 1;
r = y;

x = zeros(1,M);

Htilde = H./sqrt(ones(N,1)*sum(H.^2));

while (norm(r)>thres && t<T)
    proj = (Htilde'*r);
    [maxVal ind] = max(abs(proj));
    ind = ind(1);
    Tab_k(t) = ind;
    hk = H(:,ind);
  

    %%%%% OMP
    a = (H(:,Tab_k))\y;
    r = y-H(:,Tab_k)*a;
    x(Tab_k) = a;
    %%%%% FIN OMP

    Tab_r(t) = norm(r);
    Tab_a(t) = a(1);

    t=t+1;
%     
%     keyboard
end
    
