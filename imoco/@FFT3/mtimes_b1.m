function res = mtimes(a,b)

s_b = reshape(b,a.size);
if a.adjoint
    % inverse
    s_b = ifftshift(s_b);
    for dim = 1:3
        s_b = ifft(s_b,[],dim);
    end
    res = fftshift(s_b);
else
    % inverse
    s_b = ifftshift(s_b);
    for dim = 1:3
        s_b = fft(s_b,[],dim);
    end
    res = fftshift(s_b);
end
res = res(:);
