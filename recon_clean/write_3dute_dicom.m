function series_write = write_3dute_dicom(im, sc, pfilename, exam, series_mimic, series_mimic_dir, description, dicompath)
% write_3dute_dicom(im, sc, rhuser, exam, series_mimic, description, dicompath)

if isempty(sc)
  sc = max(abs(im(:)));
end

if nargin < 7
    description = '3D UTE';
end

if nargin < 8 || isempty(dicompath)
    dicompath = '.';
end

header = read_MR_headers(pfilename);
% [header, rhuser] = rawheadX(pfilename);

exam_dir = sprintf('E%d', exam);
%series_mimic_dir = int2str(series_mimic);  % may need to modify
series_write = header.series.se_no;

%info = dicominfo(sprintf('%s/%s/%s/Exam%dSeries%dImage1.dcm', dicompath, exam_dir, series_mimic_dir, ...
%			 exam, series_mimic));
info = dicominfo(sprintf('%s/%s/%s/E%dS%dI1.DCM', dicompath, exam_dir, series_mimic_dir, ...
			 exam, series_mimic));

modtime = fix(clock);
info.FileModDate = sprintf('%s %2d:%2d:%2d', date, modtime(4), modtime(5), modtime(6));

%FileSize: 142934

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


%nfo.AcquisitionNumber = number of times scan is pressed

zstart = header.image.ctr_S;

% WL, don't think it matters
%nfo.SmallestImagePixelValue,nfo.LargestImagePixelValue,nfo.WindowCenter,nfo.WindowWidth

eval(['!mkdir ' dicompath '/' exam_dir '/' int2str(series_write)])

im = double( abs(im)  / sc );

for z = 1:size(im,3)
    info.InstanceNumber = z;
    info.Filename = sprintf('%s/%s/%d/E%dS%dI%d.DCM', dicompath, exam_dir, series_write, ...
			    exam, series_write, z);
    info.SliceLocation = (size(im,3) - z)*spatial_resolution + zstart;
    info.ImagePositionPatient = [info.ImagePositionPatient(1:2); info.SliceLocation];
    dicomwrite(im(:,:,z), info.Filename, info)
end