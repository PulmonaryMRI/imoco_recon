FROM centos/python-36-centos7

# install dependencies 
RUN pip install --upgrade pip
RUN pip install numpy matplotlib sigpy==0.1.16 antspyx h5py pydicom

# clone scripts
RUN git clone https://github.com/PulmonaryMRI/imoco_recon.git

# download sample data (optional)
# RUN mkdir sample_data
# RUN pip install zenodo-get
# RUN zenodo_get -d 10.5281/zenodo.3733775 -o ./sample_data/
