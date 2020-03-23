function res = mtimes(a,b)

s_b = reshape(b,a.size);
s_b = s_b(:,:,:,:);
nP = size(s_b,4);
if a.adjoint
    % inverse
    s_b = ifftshift(s_b);
    for np = 1:nP
        s_b(:,:,:,np) = ifftn(s_b(:,:,:,np));
    end
    res = fftshift(s_b);
else
    % forward
    s_b = ifftshift(s_b);
    for np = 1:nP
        s_b(:,:,:,np) = fftn(s_b(:,:,:,np));
    end
    res = fftshift(s_b);
end
if a.vec_flag
    res = res(:);
end
