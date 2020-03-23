function resp_signal = self_nav(k0,TR,f0,I)
% 1d low pass filter
% Inputs:
%   k0: signal(multi-channel) [N,nCoil]
%   TR: repetition time(s)
%   f0: motion freq(Hz)
%   I:  for adaptive navigator
% Outputs:
%   k0f:filtered k0
% Xucheng Zhu, Jan 2019
if nargin<4
    a = ones(size(k0,2),1);
else
    a = adaptive_weighting(I,[20,20,10]);
end

k0s = k0*a;
N = 100;
resp_signal =  filt1d(k0s,TR,f0,N);

end

function k0f = filt1d(k0,TR,f0,N)
% 1d low pass filter
% Inputs:
%   k0: signal
%   TR: repetition time(s)
%   f0: motion freq(Hz)
%   N:  filter length
% Outputs:
%   k0f:filtered k0

if nargin<3
    f0 = 1;
end
if nargin<4
    N = 100;
end
N = ceil(max(2/(f0*TR),N)/2)*2;
win = fir1(N,2*f0*TR,'low');
k0e = zeros(length(k0(:))+N+1,1);
k0e(N/2+2:end-N/2) = k0(:);
k0e(1:N/2+1)=k0(1);
k0e(end-N/2+1:end)=k0(end);
k0f = conv(k0e(:),win,'same');
k0f = k0f(N/2+2:end-N/2);
end
