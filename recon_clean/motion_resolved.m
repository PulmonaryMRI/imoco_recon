function motion_resolved(h5name, motion_flag, nbin, TR, cycle_flag)
% weighting data, motion resolved
% input:
%   h5name: h5 name

% please set the bart/matlab directory
addpath /working/larson/xzhu/Lung_data/matlab
addpath(genpath('../imoco'))

motion_signal = ute_motion(h5name,motion_flag);
writecfl([h5name,'_resp'],motion_signal);
[index,weight] = mr_binning(motion_signal,TR,nbin,cycle_flag);

%%
% throw away part of the data
% figure; plot(motion_signal,'LineWidth',1);
% ind_th = input('Start index:\n');
% imask = index>ind_th;
% ind_th = input('End index:\n');
% imask = (imask.*(index<ind_th))>0;
% 
% index = index(imask);
% weight(~imask) = 0;
%%
data = readcfl([h5name,'_data']);
traj = readcfl([h5name,'_traj']);
dcf2 = readcfl([h5name,'_dcf2']);

% weight = permute(repmat(weight,1,size(dcf2,2)),[3 2 1]);
% dcf_sg = dcf2.*weight;
% 
% writecfl([h5name,'_dcf2_sg'],dcf_sg);

nf = size(data,2);
np = floor(length(index)/nbin);
nc = size(data,4);
ne = size(data,6);
datam = permute(reshape(data(:,:,index(1:np*nbin),:,:,:),1,nf,np,nbin,nc,ne),[1 2 3 5 7 4 6]);
trajm = reshape(traj(:,:,index(1:np*nbin),:),3,nf,np,1,1,nbin,ne);
dcf2m = reshape(dcf2(:,:,index(1:np*nbin),:),1,nf,np,1,1,nbin,ne);

writecfl([h5name,'_datam'],datam);
writecfl([h5name,'_trajm'],trajm);
writecfl([h5name,'_dcf2m'],dcf2m);