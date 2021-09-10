function write_3dute_dicom_pcvipr(im_dir, pfilename, description, dicompath)

files = dir([im_dir, 'moco_pd*.mat']);
im_str = load([files(1).folder, '/', files(1).name]);
im = im_str.X;
sc = max(abs(im(:)));

header = read_MR_headers(pfilename);

exam = header.exam.ex_no; 

series_mimic = header.series.se_no * 100;
series_write = series_mimic + 20;
info = dicominfo(sprintf('%s/Exam%dSeries%dImage1.dcm', dicompath, exam, series_mimic));
%info = dicominfo(sprintf('%s/E%dS%dI1.DCM', dicompath, exam, series_mimic));

modtime = fix(clock);
info.FileModDate = sprintf('%s %2d:%2d:%2d', date, modtime(4), modtime(5), modtime(6));

info.SeriesDescription = description;

info.Width = size(im,2);
info.Height = size(im,1);
info.ImagesInAcquisition = size(im,3);
info.Rows  = size(im,1);
info.Columns = size(im,2);

spatial_resolution = header.image.pixsize_X;%   header.image.dfov / header.image.dim_X;

info.PixelSpacing = [spatial_resolution, spatial_resolution];
info.SliceThickness = spatial_resolution;
info.RepetitionTime = header.image.tr/1e3;
info.EchoTime = header.image.te/1e3;
info.FlipAngle = header.image.mr_flip;
info.ReconstructionDiameter = spatial_resolution*size(im,1);

series_write_uid = dicomuid; % header.image.image_uid
info.SeriesInstanceUID = series_write_uid;
info.SeriesNumber = series_write;

info.NumberOfAverages = 1;
info.EchoTrainLength = 1;
info.SpacingBetweenSlices = 0;
%info.AcquisitionMatrix = fov / spres
%info.PixelBandwidth

zstart = header.image.ctr_S;

im = double( abs(im)  / sc );

for z = 1:size(im,3)
    info.InstanceNumber = z;
    info.Filename = sprintf('%s/E%dS%dI%d.DCM', dicompath, exam, series_write, z);
    info.SliceLocation = (size(im,3) - z)*spatial_resolution + zstart;
    info.ImagePositionPatient = [info.ImagePositionPatient(1:2); info.SliceLocation];
    dicomwrite(im(:,:,z), info.Filename, info)
end