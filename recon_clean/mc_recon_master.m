%% UTE data_convert
% parameter definition
TR = 3;
nTE = 1;
nbin = 6;
cycle_flag = 0;
motion_flag = 4;
% h5 file name
% file_base = '/working/larson6/xzhu2/UTE_Lung/2018-08-08/';
file_base = '/data/larson2/UTE_Lung2/2020-02-25_pat/tmp/';
file_name = [file_base,'MRI_Raw'];
out_file = file_name;
% data export and sorted by acquisition time
h5_convert_mTE(file_name, out_file, nTE,500,[1.25,1,1]);%keep the same with 
% uwute_shift([file_name,'_data'],250,-160);
% low res recon & smap estimation
% run mc_prep_recon.sh
% motion_resolved(out_file,motion_flag,nbin,TR,cycle_flag);
motion_resolved(out_file,motion_flag,nbin,TR,cycle_flag);
% run mc_mr_recon.sh
bias_correction(file_name);
imoco(out_file,nbin);
%%
addpath(genpath('/home/plarson/matlab/utilities'));
addpath(genpath('/working/larson/xzhu/util'));
file_folder = '/data/larson4/UTE_Lung/2020-02-25_pat/';
Pfile = [file_folder,'pfile/P32768.7_02251533'];
exam_folder = 8735;
write_3dute_dicom(flip(flip(permute(abs(X)/max(abs(X(:))),[2 1 3]),1),2),[],Pfile,exam_folder,...
    200,'2ce42698_S200','3D UTE',file_folder);