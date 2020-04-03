# Copyright 2013-2015. The Regents of the University of California.
# All rights reserved. Use of this source code is governed by 
# a BSD-style license which can be found in the LICENSE file.
#
# Authors: 
# 2013 Martin Uecker <uecker@eecs.berkeley.edu>
# 2015 Jonathan Tamir <jtamir@eecs.berkeley.edu>
# 2018 Frank Ong <frankong@berkeley.edu>


import numpy as np

def read_cfl_header(name):
    # get shape from .hdr
    with open(name + ".hdr", "r") as h:
        h.readline()  # skip
        l = h.readline()

    shape = [int(i) for i in l.split()[::-1]]

    return shape


def read_cfl(name):
    shape = read_cfl_header(name)
    n = np.prod(shape, dtype=np.int)

    # load data and reshape into shape
    with open(name + ".cfl", "r") as d:
        a = np.fromfile(d, dtype=np.complex64, count=n)

    return a.reshape(shape)  # row-major


def write_cfl(name, array):
    with open(name + ".hdr", "w") as h:
        h.write('# Dimensions\n')
        for i in array.shape[::-1]:
            h.write("%d " % i)
        h.write('\n')

    with open(name + ".cfl", "w") as d:
        array.astype(np.complex64).tofile(d)
