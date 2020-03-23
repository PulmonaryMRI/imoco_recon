function res = FFT3(size,vec_flag)

% Multi3D FFT
% Inputs:
%  size: img size
if nargin<2
    vec_flag = 1;
end
res.vec_flag = vec_flag;
res.adjoint = 0;
res.size = size;
res = class(res,'FFT3');


