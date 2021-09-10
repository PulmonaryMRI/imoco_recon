function h5_convert_mTE(H5fname, outfname, nTE, Nx, FOV_scale)
% load raw data
% please set the bart/matlab directory
%addpath /working/larson/xzhu/Lung_data/matlab
H5fname = [H5fname , '.h5'];

%% Get data, traj and dcf
if nargin<3
    nTE = 1;
    Nx = 1000;
elseif nargin<4
    Nx = 1000;
end
if nargin < 5
    FOV_scale = [1.3,0.8,1];
end

% nf calc
ttrajz = h5read(H5fname,'/Kdata/KZ_E0') ;
ttrajz = ttrajz(:,1);
ttrajy = h5read(H5fname,'/Kdata/KY_E0') ;
ttrajy = ttrajy(:,1);
ttrajx = h5read(H5fname,'/Kdata/KX_E0') ;
ttrajx = ttrajx(:,1);
ttraj = sqrt(ttrajx.^2+ttrajy.^2+ttrajz.^2);
nf = sum(ttraj<abs(Nx/2));

tmp = h5read(H5fname, '/Kdata/Noise');
ncoils = size(tmp.real,2);
 
info = h5info(H5fname,'/Kdata/KData_E0_C0');
ksize = info.Dataspace.Size;
% [X, Y, Z, nCoil, 1, nTE]
%data = zeros(1,ksize(1),ksize(2),ncoils,1,nTE);
%traj = zeros(3,ksize(1),ksize(2),1,1,nTE);
%dcf = zeros(1,ksize(1),ksize(2),1,1,nTE);
data = zeros(1,nf,ksize(2),ncoils,1,nTE);
traj = zeros(3,nf,ksize(2),1,1,nTE);
dcf = zeros(1,nf,ksize(2),1,1,nTE);

for nte = 1:nTE
    for i = 1:ncoils
        % time = h5read(H5fname,sprintf('/Gating/time'));
        time = h5read(H5fname,sprintf('/Gating/TIME_E%d',nte-1));
        [~,order] = sort(time);
        kstruct = h5read(H5fname,sprintf('/Kdata/KData_E%d_C%d',nte-1,i-1));
        tdata = kstruct.real +kstruct.imag*1j;
        data(1,:,:,i,1,nte) = tdata(1:nf,order);
        ttraj = h5read(H5fname,sprintf('/Kdata/KX_E%d',nte-1)) ;
        traj(1,:,:,:,:,nte) = ttraj(1:nf,order)*FOV_scale(1);
        ttraj = h5read(H5fname,sprintf('/Kdata/KY_E%d',nte-1)) ;
        traj(2,:,:,:,:,nte) = ttraj(1:nf,order)*FOV_scale(2);
        ttraj = h5read(H5fname,sprintf('/Kdata/KZ_E%d',nte-1)) ;
        traj(3,:,:,:,:,nte) = ttraj(1:nf,order)*FOV_scale(3);
        tdcf = h5read(H5fname,sprintf('/Kdata/KW_E%d',nte-1));
        dcf(1,:,:,:,:,nte) = tdcf(1:nf,order);
    end
    
end
    




BW = 250e3;%Hz
r_B0 = 127;%MHz
delay = 80e-6;%s

cs_shift = linspace(-4,4,16)';%ppm
cs_phase = exp(-1i*2*pi*cs_shift*r_B0*(delay+1/BW*(0:ksize(1)-1)));
%% Save to cfl files
% writecfl([outfname,'_cs'],permute(cs_phase,[3 2 4 1]));

writecfl([outfname,'_traj'],traj);
writecfl([outfname,'_dcf'],dcf);
writecfl([outfname,'_data'],data);
writecfl([outfname,'_dcf2'],sqrt(dcf));