function [X] = imoco_cc(fname_base,ref_N, TGV_lambda)
% mc recon script
% Input:
%   fname: data file name base
% Output:
%   X:  is moco recon
% Xucheng Zhu, Jan 2019

addpath(genpath('/working/larson6/xzhu2/tools/pics'));
maxNumCompThreads = 64;
% fname_base = '/working/larson6/xzhu2/tmp/tmp/MRI_Raw_';



data = readcfl_s([fname_base,'_data1m']);
data = single(data/max(abs(data(:))));
dcf = readcfl_s([fname_base,'_dcf2m']);
traj =  readcfl_s([fname_base,'_trajm']);
mr_img = readcfl_s([fname_base,'_mrL']);
smap = readcfl_s([fname_base,'_maps']);

IsizeL = size(mr_img);
m_ph = IsizeL(end);
IsizeL = IsizeL(1:3);
Isize = size(smap);
nCoil = Isize(4);
Isize = Isize(1:3);
s_datac = single(size(smap));

% reference frame
if nargin < 2
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
Ix = zeros(IsizeL(1:3));

for i = 1:m_ph
    [reg_fieldt] = imregdemons(mag_b(:,:,:,i),mag_b(:,:,:,ref_N),'PyramidLevels',4,'AccumulatedFieldSmoothing',2,'DisplayWaitbar',false);
    Ix = Ix + imwarp(mr_img(:,:,:,i),reg_fieldt);

    for j = 1:3
        reg_field(:,:,:,j,i) = imresize3(reg_fieldt(:,:,:,j).*mask*mscale(j),Isize);
    end
end

smap_kb =  smap./kb_scale;

scale = 1;
Afun = @(x)WGFSM1(x,traj,dcf,-inv_field(reg_field),smap_kb)*scale;
ATfun = @(y)WGFSM1_H(y,traj,dcf,reg_field,smap_kb)*scale;
scale = sqrt(1/(eps+abs(mean(vec(ATfun(Afun(ones(size(smap(:,:,:,1))))))))));
Afun = @(x)WGFSM1(x,traj,dcf,-inv_field(reg_field),smap_kb)*scale;
ATfun = @(y)WGFSM1_H(y,traj,dcf,reg_field,smap_kb)*scale;

Y = complex(single(zeros(size(data))));
sigma = .25;
tau = .2;
rho = 5e-1;
datadcf = data.*dcf;
X = ATfun(datadcf);
X_b = X;
% q = zeros(size(smap(:,:,:,1)));
% X = q;
% p = zeros(size(q));

params.lambda = TGV_lambda;% tuning 0.01
params.sigma = .25;% sigma * tau <= .5
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
    %X_1 = X-tau*ATfun(Y);
    X_b = X_1 + theta*(X_1-X);
    X = X_1;
    fprintf('Iter:%d, update_norm:%f.\n',iter_out,norm(X(:)-X_b(:))./norm(X(:)));
    save([fname_base,'moco_pd',num2str(m_ph),'.mat'],'X');
end

mc_time = toc
save([fname_base,'moco_pd',num2str(m_ph),'.mat'],'X','mr_img','Ix');
% I_sg = readcfl_s([fname_base,'_sg']);
% save([fname_base,'moco_pd.mat'],'X','mr_img','Ix','I_sg');%,'I_sg');
end

function iMfield = inv_field(Mfield)
iMfield = -Mfield;
for i = size(Mfield,4)
    iMfield(:,:,:,i,:) = -imwarp4(squeeze(Mfield(:,:,:,i,:)),-Mfield);
end

end
