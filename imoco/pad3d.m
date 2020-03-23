function out = pad3d( in, osize)
osize = max(osize,1);
isize = size(in);
assert(sum(isize<=osize)==3,'output size should larger than input size');

out = zeros(osize);
pl = floor(osize/2) - floor(isize/2);
pr = ceil(osize/2) - ceil(isize/2);
out(pl(1)+1:end-pr(1),pl(2)+1:end-pr(2),pl(3)+1:end-pr(3)) = in;

end