%% UTE data_convert
% parameter definition
TR = 3;
nTE = 1;
nbin = 6;
cycle_flag = 0;
motion_flag = 4;
% h5 file name
file_base = '/data/larson4/UTE_Lung/2021-04-19_ped_patient/';
file_name = [file_base,'cfl/P00512/MRI_Raw'];
out_file = file_name;
% data export and sorted by acquisition time
h5_convert_mTE(file_name, out_file, nTE,500,[1.25,1,1]);%keep the same with 
% uwute_shift([file_name,'_data'],250,-160);
% low res recon & smap estimation
% run mc_prep_recon.sh
%system(['bash mc_prep_recon.sh ' file_name ' 240 192 192'])
system(['bash mc_prep_recon_cc.sh ' file_name ' 240 192 192 16'])
addpath(genpath('../imoco'))
motion_resolved(out_file,motion_flag,nbin,TR,cycle_flag);
%%
% run mc_mr_recon.sh
%system(['bash mc_mr_recon.sh ' file_name ' 0.001'])
system(['bash mc_mr_recon_cc.sh ' file_name ' 0.001'])
%bias_correction(file_name);
%X = imoco(out_file,nbin);
X = imoco_cc(out_file,nbin);
%%
%addpath(genpath('/home/plarson/matlab/utilities'));
addpath(genpath('/working/larson/xzhu/util'));
%file_folder = '/data/larson4/UTE_Lung/2021-04-12_ped_patient/';
Pfile = [file_base,'pfile/P00512.7'];
exam_folder = 6167;
write_3dute_dicom(flip(flip(permute(abs(X)/max(abs(X(:))),[2 1 3]),1),2),[],Pfile,exam_folder,...
    200,'592ebbb0_S200','3D UTE',file_base);