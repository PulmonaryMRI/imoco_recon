function grad = pgradient(I, grad_dim)

grad = [];
for i = 1:3
    % tgrad = (circshift(I,1,i) - circshift(I,-1,i))/2;
    tgrad = circshift(I,1,i) - I;
    grad = cat(grad_dim,grad,tgrad);
end