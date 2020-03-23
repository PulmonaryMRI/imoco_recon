function [X] = imoco(fname_base,ref_N, TGV_lambda)
% mc recon script
% Input:
%   fname: data file name base
% Output:
%   X:  imoco recon
% Xucheng Zhu, August 2019

addpath(genpath('../../pics'));
maxNumCompThreads = 64;

% motion resolved data shape[1,readout,spokes,sens,1,motion phase]
data = readcfl_s([fname_base,'_datam']);
data = single(data/max(abs(data(:))));
% motion resolved dcf shape[3,readout,spokes,1,1,motion phase]
dcf = readcfl_s([fname_base,'_dcf2m']);
% motion resolved traj shape[3,readout,spokes,1,1,motion phase]
traj =  readcfl_s([fname_base,'_trajm']);
% motion resolved recon shape[Xm,Ym,Zm,1,1,motion phase]
mr_img = readcfl_s([fname_base,'_mrL']);
% motion resolved recon sensitivity[X,Y,Z,sens,1,1]
smap = readcfl_s([fname_base,'_maps']);

IsizeL = size(mr_img);
m_ph = IsizeL(end);
IsizeL = IsizeL(1:3);
Isize = size(smap);
nCoil = Isize(4);
Isize = Isize(1:3);
s_datan = single(size(data(:,:,:,:,1)));
s_datac = single(size(smap));

% reference frame
if nargin < 2
    % the last frame
    ref_N = m_ph;
end

if nargin < 3
    TGV_lambda = .01;
end

%%%%%%%%%%
mask = ones(IsizeL);

width = 3;
kb_1d = kaiser(2*width+1,13.9086);
[kb_x,kb_y,kb_z] = meshgrid(kb_1d,kb_1d,kb_1d);
kb_ksp = pad3d(kb_x.*kb_y.*kb_z,s_datac(1:3));
kb_scale = (numel(kb_ksp)/((2*width)^3))*ifft3c(kb_ksp);

% estimate motion state
mr_img = squeeze(mr_img)./max(abs(mr_img(:)));
mag_b = abs(imgauss4d(mr_img,.5));
% motion field interpolation
mscale = Isize./IsizeL;
%mscale = permute(mscale,[1 3 4 5 2]);
reg_field = zeros([Isize(1:3),3,m_ph]);
% reg_field update
reg_field2 = reg_field;
Ix = zeros(IsizeL(1:3));

for i = 1:m_ph
    [reg_fieldt] = imregdemons(mag_b(:,:,:,i),mag_b(:,:,:,ref_N),'PyramidLevels',4,'DisplayWaitbar',false);
    Ix = Ix + imwarp(mr_img(:,:,:,i),reg_fieldt);
    for k = 1:3
       reg_fieldt2(:,:,:,k) = imwarp(reg_fieldt(:,:,:,k),reg_fieldt); 
    end
    for j = 1:3
        reg_field(:,:,:,j,i) = imresize3(reg_fieldt(:,:,:,j).*mask*mscale(j),Isize);
        reg_field2(:,:,:,j,i) = imresize3(reg_fieldt2(:,:,:,j).*mask*mscale(j),Isize);
    end
end

smap_kb =  smap./kb_scale;

scale = 1;
Afun = @(x)WGFSM1(x,traj,dcf,reg_field,smap_kb)*scale;
ATfun = @(y)WGFSM1_H(y,traj,dcf,reg_field,smap_kb)*scale;
scale = sqrt(1/(eps+abs(mean(vec(ATfun(Afun(ones(size(smap(:,:,:,1))))))))));
Afun = @(x)WGFSM1(x,traj,dcf,reg_field,smap_kb)*scale;
ATfun = @(y)WGFSM1_H(y,traj,dcf,reg_field,smap_kb)*scale;

Y = complex(single(zeros(size(data))));
Y_b = Y;
sigma = .25;
tau = .2;
rho = 5e-1;
datadcf = data.*dcf;
X = ATfun(datadcf);
X_b = X;

% TGV parameters
params.lambda = TGV_lambda;
params.sigma = .25;
params.tau = .25;
params.alpha0 = .01;
params.alpha1 = .01;
params.nflag = 1;
TGV_prox = TGV(params);
tic;
theta = 1;
for iter_out = 1:20
    Y = (Y+sigma*(Afun(X_b)-datadcf))/(sigma + 1);
    X_1 = TGV_prox*(X-tau*ATfun(Y));
    X_b = X_1 + theta*(X_1-X);
    X = X_1;
    fprintf('Iter:%d, update_norm:%f.\n',iter_out,norm(X(:)-X_b(:))./norm(X(:)));
end

I_imoco = X;
I_moco = Ix;
mc_time = toc
save([fname_base,'_imoco_pd',num2str(m_ph),'.mat'],'I_imoco','I_moco');
% I_sg = readcfl_s([fname_base,'_sg']);
% save([fname_base,'moco_pd.mat'],'X','mr_img','Ix','I_sg');%,'I_sg');



