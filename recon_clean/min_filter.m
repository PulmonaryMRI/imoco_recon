function s_filt = min_filter(s,N)
% max filter
% xucheng zhu Oct. 2018

N2 = ceil(N/2);
L = length(s);
s_filt = s;

for n = 2:L-1
    inds = max(1,n-N2);
    inde = min(L,n+N2);
    s_filt(n) = min(s(inds:inde));
end