function motion_signal = ute_motion(h5name,motion_flag)
% motion signal extraction
% input:
%   h5name: ute file name
% output:
%   motion_signal: resp. bellow, ksp0 based signal, img base signal

% please set the bart/matlab directory
addpath /working/larson/xzhu/Lung_data/matlab
TR = 5; 
close all;

if(motion_flag==0)
    % bellow gating method
    H5_file = [h5name,'.h5'];
    time = h5read(H5_file,'/Gating/TIME_E0');
    %time = h5read(H5_file,'/Gating/time');
    [~,order] = sort(time);
    t_N = length(order);
    
    resp = h5read(H5_file,'/Gating/RESP_E0');
    %resp = h5read(H5_file,'/Gating/resp');
    resp = resp(order);
    
    motion_signal = resp;
end

if(motion_flag==1)
    f0 = 1; %2s
    img_file = [h5name,'_imgL'];
    I = readcfl(img_file);
    
    rdata_file = [h5name,'_data'];
    ksp = readcfl(rdata_file);
    ksp_c = squeeze(ksp(1,1,:,:));
    ksp_0 = self_nav(ksp_c,TR/1000,f0,I);
    % phase navigator
    motion_signal = (ksp_0-(min(real(ksp_0))+1i*min(imag(ksp_0))));
    figure;plot([real(motion_signal),imag(motion_signal)]);
    motion_signal = real(motion_signal);
    flip_flag = (input('Motion signal flip(>=1):')>=1);
    motion_signal = motion_signal.*(1-2*flip_flag);
end
    
if(motion_flag==2)
    % k0 gating method
    rdata_file = [h5name,'_data'];
    ksp = readcfl(rdata_file);
    ksp_c = squeeze(ksp(1,1,:,:));
    t_N = size(ksp_c,1);
    
    win_len = ceil(100/TR);
    ksp_r = reshape(ksp_c(1:floor(t_N/win_len)*win_len,:),win_len,floor(t_N/win_len),size(ksp_c,2));
    ksp_r = squeeze(sum(ksp_r,1));
    
    [U,S,V ] = svd(ksp_r,'econ');
    eig_num = 4;
    eig_nums = 2;
    a = U(:,eig_nums:eig_num)*diag(S(eig_nums:eig_num,eig_nums:eig_num));
    a = mean(a(:));
    a = a/abs(a);
    motion_signal = real(U(:,1:eig_num)*diag(S(1:eig_num,1:eig_num))*conj(a));
    motion_signal = interp1(motion_signal([1,1:end,end]),(1:t_N)'/win_len+1);
    plot(motion_signal);
    flip_flag = (input('Motion signal flip(>=1):')>=1);
    motion_signal = motion_signal.*(1-2*flip_flag);
end

if (motion_flag==3)
    resp_file = input('RESP file');
    scan_offset = 30e3/40;
    resp = textread(resp_file);
    resp = resp(scan_offset+1:end);
    info = h5info(H5_file,'/Kdata/KX_E0');
    ksize = info.Dataspace.Size;
    t = linspace(1,length(resp),ksize(2));
    motion_signal = interp1(resp,t(:));
end

if (motion_flag==4)
    f0 = 1; %2s
    
    rdata_file = [h5name,'_data'];
    ksp = readcfl_s(rdata_file);
    ksp_c = squeeze(ksp(1,1,:,:));
    
    % phase navigator
    figure;plot(real(ksp_c));
    channel_flag = input('Channel:');
    motion_signal = real(ksp_c(:,channel_flag));
    motion_signal = self_nav(motion_signal,TR/1000,f0);
    plot(motion_signal);
    flip_flag = (input('Motion signal flip(>=1):')>=1);
    motion_signal = motion_signal.*(1-2*flip_flag);
end
