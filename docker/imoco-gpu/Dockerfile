FROM nvidia/cuda:11.4.0-cudnn8-devel-centos7

# setup environment
RUN yum -y install python3 epel-release python-pip git
RUN pip3 install --no-cache-dir -U install setuptools pip
RUN pip3 install --no-cache-dir "cupy-cuda114[all]==9.3.0"

# install imoco dependencies
RUN pip3 install numpy matplotlib sigpy==0.1.16 antspyx h5py pydicom

# clone scripts
RUN git clone https://github.com/PulmonaryMRI/imoco_recon.git

# download sample data (optional)
# RUN mkdir sample_data
# RUN pip install zenodo-get
# RUN zenodo_get -d 10.5281/zenodo.3733775 -o ./sample_data/
