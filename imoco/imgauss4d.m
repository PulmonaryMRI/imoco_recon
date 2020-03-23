function If = imgauss4d(Iin,sigma)
% imgaussfilt3 extension
I_size = size(Iin);

Iin = Iin(:,:,:,:);
np = size(Iin,4);
If = zeros(size(Iin));
for i = 1:np
    If(:,:,:,i) = imgaussfilt3(real(Iin(:,:,:,i)),sigma) + ...
        1j * imgaussfilt3(imag(Iin(:,:,:,i)),sigma);
end

If = reshape(If,I_size);