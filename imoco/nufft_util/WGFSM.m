function y = WGFSM(dcf2, traj, s_datac, smap, motion, x)
% forward function y = WGFSM
if isempty(motion) 
    x_m = x;
else
    x_m = imwarp(x,-motion);% put back
end
x_m = x_m .* smap;
FT = FFT3(s_datac,0);
x_m = FT*x_m;
%s_datac = single(size(smap));
s_datan = single([size(traj),size(smap,4)]);
s_datan(1) = 1;
y = gridH3(single(traj),complex(single(x_m)),single(s_datan),single(s_datac));
y = y.*dcf2;

