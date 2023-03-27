import numpy as np
from sigpy import backend, util, thresh, linop
from sigpy import prox

def GLRA(shape,lamda,A = None,sind_1 = 1):
    
    u_len = 1
    for i in range(sind_1):
        u_len = u_len * shape[i]
        
    v_len = 1
    for i in range(len(list(shape))-sind_1):
        v_len = v_len * shape[-i-1]    
    
    ishape = (u_len,v_len)
    
    GPR_prox = GLR(ishape, lamda)
    R = linop.Reshape(oshape=ishape,ishape=shape)
    if A is None:
        RA = R
    else:
        RA = R*A
    GLRA_prox = prox.UnitaryTransform(GPR_prox,RA)
    return GLRA_prox

class GLR(prox.Prox):
    def __init__(self, shape, lamda):
        self.lamda = lamda
        super().__init__(shape)

    def _prox(self, alpha, input):
        u,s,vh = np.linalg.svd(input,full_matrices=False)
        s_max = np.max(s)
        #print('Eigen Value:{}'.format(np.diag(s)))
        s_t = thresh.soft_thresh(self.lamda * alpha*s_max, s)
        return np.matmul(u, s_t[...,None]*vh)
    