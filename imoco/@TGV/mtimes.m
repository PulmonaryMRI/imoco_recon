function res = mtimes(a,b)
% TGV prox operator

if a.params.nflag
    b_n = b./max(abs(b(:))+eps);
    b_scale = max(abs(b(:))+eps);
else
    b_n = b;
    b_scale = 1;
end

u = b_n;
u_b = u;
v = pgradient(b_n,4);
v_b = v;
lambda = a.params.lambda;%0.02
sigma = a.params.sigma;%.05
tau = a.params.tau;%.1
alpha0 = a.params.alpha0;%.1
alpha1 = a.params.alpha1;%.05
p = zeros([size(b_n),3]);
q = zeros([size(v),3]);
% interation??
Iter = 15;
for i = 1:Iter
    % dual update
    p = prox_linf2(p+sigma*(pgradient(u_b,4)-v_b),alpha0,4);
    q = prox_linf2(q+sigma*(pgradient(v_b,5)),alpha1,[4,5]);
    % primal update
    u_o = u;
    u = (lambda*(u_o + tau*div4(p)) + tau*b_n)/(lambda+tau);
    u_b = u + (u - u_o);
    v_o = v;
    v = v + tau*(p + div5(q));
    v_b = v + (v - v_o);
end

res = u_b * b_scale;

