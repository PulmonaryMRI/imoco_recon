function y = div6(x)
% calculate divergence

y = 0;
for i = 1:3
    % y = y + (circshift(x(:,:,:,:,:,i),1,i) - circshift(x(:,:,:,:,:,i),-1,i))/2;
    y = y + (circshift(x(:,:,:,:,:,i),-1,i)-x(:,:,:,:,:,i));
end 

