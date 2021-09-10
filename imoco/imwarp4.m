function Im = imwarp4(I,T,exp_flag)
if nargin < 3
    exp_flag = false;
end

assert(size(T,4)==3,'Expected 3D(4th dim) motion field');
assert(size(T,5)==size(I(:,:,:,:),4),'Expected same size of motion field');
Im = I;
for i = 1:size(T,5)
    if exp_flag
        Im(:,:,:,i) = imwarp_exp(I(:,:,:,i),T(:,:,:,:,i));        
    else
        Im(:,:,:,i) = imwarp(I(:,:,:,i),T(:,:,:,:,i),'interp','cubic','SmoothEdges', false);
    end
end

end