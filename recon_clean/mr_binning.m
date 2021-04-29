function [index, weight] = mr_binning(resp_signal, TR, nbin, cycle_flag)
% motion resolved binning,exhale on top
% input:
%   resp_signal: respiratory signal
%   TR: resp signal resolution
%   nbin: number of bins
%   cycle_flag: motion magnitude based/respiration cycle binning
% output:
%   index: motion index
%   weight: weights for exhale state
T_resp = 2e3;% ms
N_resp = ceil(T_resp/TR);
resp_max = max_filter(resp_signal,N_resp);
resp_min = min_filter(resp_signal,N_resp);
signal_m = mean((resp_max+resp_min)/2);
signal_s = mean(resp_max-resp_min);
index = 1:length(resp_signal);
upper_bound = signal_m + 1.2*signal_s;
lower_bound = signal_m - .8*signal_s;
eff_index = index((resp_signal<upper_bound)&(resp_signal>lower_bound));
figure;
subplot(3,1,1);
plot([resp_signal,resp_max,upper_bound*ones(size(resp_signal)),lower_bound*ones(size(resp_signal))]);
exhale_th = input('Enter the threshold for cycle seperation:');
% [~,inhale_pos] = findpeaks(-resp_signal,'MinPeakDistance',floor(T_resp/TR),'MinPeakHeight',-inhale_th);
[ex_signal,exhale_pos] = findpeaks(resp_signal(eff_index),'MinPeakDistance',floor(T_resp/TR),'MinPeakHeight',exhale_th);
drift = interp1(eff_index(exhale_pos),ex_signal,1:length(resp_signal),'spline');
subplot(3,1,2);plot([resp_signal,drift']);
resp_signal = resp_signal - drift';
[ex_signal,exhale_pos] = findpeaks(resp_signal(eff_index),'MinPeakDistance',floor(T_resp/TR));

ex_mean = mean(ex_signal);
ex_std = std(ex_signal);
sig_std = std(resp_signal(:));

%% iterative calc soft weight
iter = 0;
weight = zeros(size(resp_signal));
mweight = 0;
beta = 1;
while mweight<.6 || mweight>.8 && iter<20
    iter = iter +1;
    weight = min(1,exp((beta*ex_std-abs(resp_signal-ex_mean))/(signal_s/4)));
    mweight = mean(weight);
    if mweight <.6
        beta = beta * 1.1;
    elseif mweight >.8
        beta = beta * .9;
    end
end
iter
subplot(3,1,3);plot([resp_signal,weight*range(resp_signal)+min(resp_signal)]);

if(cycle_flag)
    resp_max = input('Enter the threshold for max resp signal:');
    Hind = 1:length(resp_signal);
    Lind = linspace(1,length(resp_signal), floor(length(resp_signal)*TR/200));
    L_resp = interp1(medfilt1(resp_signal,floor(100/TR)),Lind);
    L_sign = sign(diff(L_resp([1:end,end])));
    H_sign = interp1(Lind,L_sign,Hind);
    
    resp_signal2 = (resp_max - resp_signal).*H_sign';
    plot(resp_signal2);
else
    resp_signal2 = resp_signal;
end
resp_signal2 = resp_signal2(eff_index)+rand(length(eff_index),1)*.01*ex_std;

tmp_ind = 1:nbin*floor(length(resp_signal2)/nbin);
tmp = sortrows(cat(2,resp_signal2(tmp_ind),eff_index(tmp_ind)'),1);
index = tmp(:,2);
