function y = div(x,dim)
% single dim calculate divergence

y = y + circshift(x,-1,dim)-x;
