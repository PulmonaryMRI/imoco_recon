function x = WGFSM1_H(data,traj,dcf2,reg_field,smap_kb)

Isize = single(size(data));
s_datac = single(size(smap_kb));
x = zeros(s_datac(1:3));
for i = 1:Isize(end)
    datat = data(:,:,:,:,i);
    trajt = traj(:,:,:,:,i);
    dcf2t = dcf2(:,:,:,:,i);
    reg_fieldt = reg_field(:,:,:,:,i) ;
    x = x + WGFSM_H(dcf2t, trajt, s_datac, smap_kb, reg_fieldt, datat);
end
x = x/Isize(end);