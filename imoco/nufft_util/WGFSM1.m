function y = WGFSM1(x,traj,dcf2,reg_field,smap_kb)

s_datac = size(smap_kb);
s_datan = size(traj);
s_datan(1) = 1;
s_datan(4) = size(smap_kb,4);
s_datan = single(s_datan);
y = zeros(s_datan);
for i = 1:s_datan(end)
    trajt = traj(:,:,:,:,i);
    dcf2t = dcf2(:,:,:,:,i);
    reg_fieldt = reg_field(:,:,:,:,i) ;
    y(:,:,:,:,i) = WGFSM(dcf2t, trajt, s_datac, smap_kb, reg_fieldt, x);
end
