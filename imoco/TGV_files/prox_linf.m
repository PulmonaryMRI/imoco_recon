function y = prox_linf(x,lambda)
% prox function for Linf norm
%   argmin_y 1/2*||y-x||^2_2 + lambda*||y||_inf
% input:
%   x       : input array
%   lambda  : regularization para

y = x./abs(x+eps).*min(abs(x),lambda);