function y = prox_linf2(x,lambda, dim)
% prox function for Linf with l2 norm
%   argmin_y 1/2*||y-x||^2_2 + lambda*||y||_inf
% input:
%   x       : input array
%   lambda  : regularization para

x_norm = abs(x.^2);
for idim = 1:length(dim)
    x_norm = sum(x_norm,dim(idim));
end
x_norm = sqrt(x_norm);
rsize = size(x);
nsize = rsize;
nsize(dim) = 1;
x_norm = repmat(x_norm,rsize./nsize);
y = lambda * x./max(abs(x_norm),lambda+eps);