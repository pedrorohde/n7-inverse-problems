clear;
close all;

% setting of parameters :

a = 0.5;
b = 8;
c = 0.55;
d = 2;

x_0 = [0.5 1]';

x_init = [-0.8 -2.2]'; % initial solution

epsilon = 1e-6; % choose epsilon according to table II.1 from the report
max_iter = 1e3;
alpha_gradient = 0.1; % choose gradient step size according to table II.1 from the report
alpha_newton = 1; % choose Newton step size according to table II.1 from the report

% gradient descent with fixed step size
[x_gradDesc, niter_gradDesc, t_gradDesc, f_min_gradDesc_fixed] = gradDesc(x_init, max_iter, epsilon, alpha_gradient, a, b, c, d);

% gradient descent with optimal step size
[x_gd_opt_alpha, niter_gd_opt_alpha, t_gd_opt_alpha, f_min_gd_opt] = gradDescOpt_alpha(x_init, max_iter, epsilon, a, b, c, d);

% Newton method with fixed step size
[x_newt, niter_newt, t_newt, f_min_newton_fixed] = newt_meth(x_init, max_iter, epsilon,alpha_newton, a, b, c, d);

% Newton method with optimal step size
[x_nopt, niter_nopt, t_nopt, f_min_newton_opt] = newt_meth_opt(x_init, max_iter, epsilon, a, b, c, d);


disp(['gradient descent (fixed step size):   x=(',num2str(x_gradDesc(1)),',',num2str(x_gradDesc(2)),') => f0(x) = ',num2str(f_min_gradDesc_fixed)]);
disp(['gradient descent (optimal step size): x=(',num2str(x_gd_opt_alpha(1)),',',num2str(x_gd_opt_alpha(2)),') => f0(x) = ',num2str(f_min_gd_opt)]);
disp(['Newton method (fixed step size):      x=(',num2str(x_newt(1)),',',num2str(x_newt(2)),') => f0(x) = ',num2str(f_min_newton_fixed)]);
disp(['Newton method (optimal step size):    x=(',num2str(x_nopt(1)),',',num2str(x_nopt(2)),') => f0(x) = ',num2str(f_min_newton_opt)]);


