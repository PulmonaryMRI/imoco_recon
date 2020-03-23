function x = WGFSM_H(dcf2, traj, s_datac, smap, motion, y)
% forward function y = WGFSM

s_datan = [size(traj),size(smap,4)];
y_1 = grid3(single(traj),complex(single(y.*dcf2)),single(s_datan),single(s_datac));
FT = FFT3(s_datac,0);
y_1 = FT'*y_1;
y_1 = sum(y_1 .* conj(smap),4);
%y_1 = sqrt(sum(abs(y_1),4));

if isempty(motion) 
    x = y_1;
else
    x = imwarp(y_1,motion);
end



