%% UTE data_convert
% parameter definition
TR = 3;
nTE = 1;
nbin = 6;
cycle_flag = 0;
motion_flag = 2;
addpath(genpath('../imoco'))
% h5 file name ## input ##
file_base = '/data/larson4/UTE_Lung/2021-04-27_ped/';
file_name = [file_base,'cfl/P36352/MRI_Raw'];
out_file = file_name;
% data export and sorted by acquisition time
h5_convert_mTE(file_name, out_file, nTE,500,[1.25,1,1]);%keep the same with 
% uwute_shift([file_name,'_data'],250,-160);

%% low res Motion Resolved Recon & smap estimation
motion_resolved(file_name,motion_flag,nbin,TR,cycle_flag);
% run mc_prep_recon.sh
% if coil>16, use coil compression (cc)
%system(['bash mc_prep_recon.sh ' file_name ' 240 192 192'])
system(['bash mc_prep_recon_cc.sh ' file_name ' 240 192 192 16'])
% run mc_mr_recon.sh
%system(['bash mc_mr_recon.sh ' file_name ' 0.001'])
system(['bash mc_mr_recon_cc.sh ' file_name ' 0.001'])
%bias_correction(file_name);

%% imoco recon
%X = imoco(out_file,nbin);
X = imoco_cc(out_file,nbin);

%% dicom conversion ##input##
%addpath(genpath('/home/plarson/matlab/utilities'));
%addpath(genpath('/working/larson/xzhu/util'));
Pfile = [file_base,'pfile/P36352.7'];
dcmfile = [file_base, 'imoco_dicom'];
%exam_folder = 6167;
%write_3dute_dicom(flip(flip(permute(abs(X)/max(abs(X(:))),[2 1 3]),1),2),[],Pfile,exam_folder,...
%    200,'592ebbb0_S200','3D UTE',file_base);

write_3dute_dicom_pcvipr(file_name, Pfile, '3D UTE iMoCo', dcmfile)