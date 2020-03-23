function  res = TGV(params)
% 3D TGV proximal operator
% Formulation:
%  argmin_x ||y-x||_2^2+alpha1*TGV(x)
%  TGV(x) = min_u,v ||Gx-u||_1 +alpha2*||Gu-v||_1

res.params = params;
res.adjoint = 0;
res = class(res,'TGV');

