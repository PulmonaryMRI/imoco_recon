function img = ifft3c(ksp)
% fourier transform

msize = size(ksp);
ksp_t = ksp(:,:,:,:);
img = zeros(size(ksp_t));
for i = 1: size(ksp_t,4)
    img(:,:,:,i) = fftshift(ifftn(ifftshift(ksp(:,:,:,i))));
end

img = reshape(img,msize);