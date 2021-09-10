function header = read_MR_headers( filename, headerID, datatype )
%read_MR_headers - read MR headers from image or raw data files
%
% Read headers from MR image or rawdata files, and return them as structures.
% Supported file formats include Signa rawfiles (rev 7, 8, and 9) and Signa
% images extracted with either the listselect or ximg tools.
%
%  Usage:   header = read_MR_headers( filename )
%           header = read_MR_headers( filename, headerID, datatype )
%
% where filename is the rawdata or image filename.  If headerID is omitted
% or 'all', all headers are read. Image files have suite, exam, series, image,
% and pixel subheaders. Rawdata files have rdb_hdr, and data_acq_table, exam,
% series, image. datatype = 'raw' or 'image'
%
% If headerID is 'qraw' or 'qimg', only the minimum information needed to
% locate data in a raw or image file is returned.  These options make
% execution much faster.
%
% Support for 'per_pass', 'unlock_raw', 'nex_tab', 'nex_abort_tab', and 'tool'
% headers is not implemented yet.
%

% Copyright (c) 2012 by General Electric Company. All rights reserved.

% Revision History
% Rev 3.13  2003-Jun-24  Matthew Eash
% 3.13 2003-Jun-24 MGE  Changed 'read_rdb_hdr_rev9' fread(...'char') to freadc
% Rev 3.14  29 Sept 2003 B.Sivalingam
% Rev 3.15  17 February 2004 S. Huff
% Rev 3.16  2004-March-31 S. Huff - Updated for Rev 10 P file format.
% Rev 3.17  8 April 2004 - B. Sivalingam Updated get_file_formats for Rev 10

% Rev 4     17 Jan 2006  B.Sivalingam   Simplified the structure of this
% code to support auto update feature for IQTOOL. The tool shall evolve on
% its own through perl scripts, everytime rdbm.h/imagedb.h is changed
% This tool assumes that  GENESIS_DATABASE_REVISION is updated everytime
% imagedb.h is updated irrespective of whether the size changed or not.
%------------------------------------------------------------------------------


%%% Notes - headersizes.c needs to include a few more new line characters
%%% and a new perl script that appends to a new file hdr_sizes.txt needs to
%%% be created. If it is convenient move all this to the dir where the
%%% other .m code will be generated. hdr_sizes.txt will from now on contain
%%% info about old pfiles as well.

global isHost;
if exist('/usr/g/mrraw','dir')
    isHost = 1;
else
    isHost = 0;
end
if nargin==1
    headerID = 'all';
    datatype = 'raw';
    display('Datatype not specified assuming that the data is a "raw file" \n');
elseif nargin == 2
    datatype = 'raw';
    display('Datatype not specified assuming that the data is a "raw file" \n');
end
header = [];

% Attempt to auto-recognize the file type.
[ formatID, endianID, header_list, header_lengths, rdbm_rev ] = get_file_format( filename,datatype );
% fprintf('FormatID: %s  EndianID: %s  HeaderID: %s\n', formatID, endianID, headerID );

if strcmp( formatID, '')
    fprintf('READ_MR_HEADERS could not recognize this file format.\n');
    return;
end

if strcmp(formatID, 'DICM')
    header = 'DICM';
    return
end
header.endian = endianID;
header.format = formatID;

fid = fopen( filename, 'r', header.endian );
offset = 0;

switch headerID

    case 'all'
        % Step through all the headers present in the file, reading them in order
        for i = 1:length(header_list)
            fseek( fid, offset, 'bof');
            % fprintf('  Header: %3d  Offset: %6d\n', header_list(i), offset);
            switch header_list(i)
                case 1 % rdb_hdr
                    header.rdb_hdr = read_rdb_hdr( fid, rdbm_rev );
                case  2 %  2 per_pass (not implemented)
                case  3 %  3 unlock_raw (not implemented)
                case  4 %  4 data_acq_tab
                    %                    header.data_acq_tab = read_data_acq_tab( fid, header.rdb_hdr.nslices);
                    tmp_struct.remove_me = 1;
                    for slicenum = 1:header.rdb_hdr.nslices
                        my_struct = read_data_acq_tab(fid, rdbm_rev);
                        fnames = fieldnames(my_struct);
                        %Assume 2D array at most
                        for fdnum = 1:length(fnames)
                            xnum = size(getfield(my_struct,fnames{fdnum}),1);
                            ynum = size(getfield(my_struct,fnames{fdnum}),2);
                            for xvar = 1:xnum
                                for yvar = 1:ynum
                                    tmp_struct = setfield(tmp_struct,fnames{fdnum},{slicenum,xvar,yvar},getfield(my_struct,fnames{fdnum},{xvar,yvar}));
                                end
                            end
                        end
                    end
                    tmp_struct = rmfield(tmp_struct,'remove_me');
                    header.data_acq_tab = tmp_struct;
                    clear xnum ynum xvar yvar slicenum tmp_struct my_struct

                case  5 %  5 nex_tab (not implemented)
                case  6 %  6 nex_abort_tab (not implemented)
                case  7 %  7 tool (not implemented)
                case  8 %  8 prescan 
                    header.psc  = read_psc_header(fid, rdbm_rev); 
                case  9 %  9 exam
                    header.exam  = read_exam_header( fid, rdbm_rev );
                case 10 % 10 series
                    header.series  = read_series_header( fid, rdbm_rev );
                case 11 % 11 image
                    header.image  = read_image_header( fid, rdbm_rev );
                case 12 % 12 grad_data
                    header.grad_data = read_grad_header( fid, rdbm_rev );
                case 13 % 13 cttentry
                    header.cttentry = read_ctt_header( fid, rdbm_rev );
            end
            offset = offset + header_lengths(header_list(i));
        end
        header.total_length = offset;

    case 'qraw'
        % Read only the minimum info needed to locate the data --  specific parts
        % of the rdb and data_acq headers (works for pfile7, pfile8, pfile9)
        errordlg('quick read mode is not supported');
        %       header.rdb_hdr = quick_read_rdb_hdr( fid );
        %       header.image = read_image_header( fid );
        %       offset = sum( header_lengths( 1:3 ));
        %       fseek( fid, offset, 'bof');
        %       header.data_acq_tab = read_data_acq_tab( fid, header.rdb_hdr.nslices);
        %       header.total_length = sum( header_lengths );

    case 'qimg'
        % Read only the necessary parts of the pixel header
        %errordlg('quick read mode is not supported');
               for i = 1:length(header_list)
                 if header_list(i)==12		% PIXEL header
                   fseek( fid, offset, 'bof');
                   header.pixel = quick_read_pixel_header( fid );
                   pixel_header_offset = offset;
                 end
                 offset = offset + header_lengths(header_list(i));
               end
               header.total_length = pixel_header_offset + header.pixel.hdr_length;

    otherwise
        fprintf('Unrecognized headerID string.\n');
        header.total_length = -1;

end

fclose(fid);

%===============================================================================
function [ formatID, endianID, header_list, header_lengths, rdbm_rev ] = get_file_format( filename,datatype );
% Attempt to auto-identify the file format.
% formatID is 'pfile7, 'pfiel8, 'pfile9', 'ximg', or 'listsel'.
% endianID = 'ieee-be' or 'ieee-le'.
% header_list is a int array indicating the order of the subheaders in the file:
%   1=rdb_rec, 2=per_pass, 3=unlock_raw, 4=data_acq_tab, 5=nex_tab, 6=nex_abort_tab,
%   7=tool, 8=exam, 9=series, 10=image, 11=suite, 12=pixel.
% header_lengths is the length of the headers.
global isHost;
formatID = '';
endianID = '';
header_list = [];
header_lengths = [];
if strcmp(datatype,'image') == 1
    % Test for XIMG and LISTSELECT formats.  Look for 'IMGF/DICM' strings
    % Otherwise assume default as ximg with '-a' option
    fid = fopen(filename,'r','b');
    test = char( fread( fid, [1, 3352], 'uchar'));
    test_110 = findstr( test,'DICM');
    test =  findstr( test, 'IMGF')-1 ;
    fclose( fid );
    if test == 0
        formatID = 'ximg';
        endianID = 'ieee-be';
        header_list = [ 12 11 8 9 10 ];
        header_lengths = get_header_lengths( 1 );
    elseif  test == 3228
        formatID = 'listsel';
        endianID = 'ieee-be';
        header_list = [ 11 8 9 10 12 ];
        header_lengths = get_header_lengths( 2 );
    elseif (test_110 < 3552)
        formatID = 'DICM';
        endianID = ' ';
        header_list = ' ';
        header_lengths = ' ';
    else %check for all options then default to ximg -a option in 11.0
        formatID = 'ximg';
        endianID = 'ieee-le';
        header_list = [ 12 11 8 9 10 ];
        header_lengths = get_header_lengths( 1 );
    end
    rdbm_rev = 'image';
    return;
end
if strcmp(datatype,'raw') == 1
    %%% First try opening file as a Little Endian file, if there is no match in the header
    %%% definition file, try Big Endian, if there is still no match,
    %%% display error dialog
    hdr_sizes_file = 0;  %header sizes file not found by default
    if(isHost)
        if( exist('/export/home/signa/tools/hdr_sizes.txt') ~= 0 )
            hdr_sizes_file = 1;
        end
    else
        if exist('hdr_sizes.txt')
            hdr_sizes_file = 1;
        end
    end
    if (hdr_sizes_file)
        fid = fopen(filename,'r','l');
        rdbm_rev = fread(fid, 1, 'float32');
        rdbm_rev = round(rdbm_rev*1000)/1000;
        fclose(fid);
        if (isHost)
            hdr_szs = read_headerinfo('/export/home/signa/tools/hdr_sizes.txt',rdbm_rev);
        else
            hdr_szs = read_headerinfo(fullfile(fileparts(mfilename('fullpath')), 'hdr_sizes.txt'), rdbm_rev);
        end
        if hdr_szs(1) ~= -1
            formatID = ['pfile',num2str(hdr_szs(1))];
            endianID = 'ieee-le';
            header_lengths = hdr_szs(3:max(size(hdr_szs)))';
            header_list = 1:length(header_lengths);
        else
            fid = fopen(filename,'r','b');
            rdbm_rev = fread(fid, 1, 'float32');
            fclose(fid);
            if (isHost)
                hdr_szs = read_headerinfo('/export/home/signa/tools/hdr_sizes.txt',rdbm_rev);
            else
                hdr_szs = read_headerinfo('hdr_sizes.txt',rdbm_rev);
            end
            if hdr_szs(1) ~= -1
                formatID = ['pfile',num2str(hdr_szs(1))];
                endianID = 'ieee-be';
                header_lengths = hdr_szs(3:max(size(hdr_szs)))';
                header_list = 1:length(header_lengths);
            else
                errordlg('The pfile revision was not found in the header definition file "hdr_sizes.txt"');
            end
        end
    else
        errordlg('hdr_sizes.txt file not found. This file is needed to relate the pfile rev to header offsets');
    end
end
return;
%---------------------------------------------------------------------
function header_lengths = get_header_lengths( format_num )
% Define the lengths for the individual headers present in each file format;
% zero lengths mean the header is not in the file.
%       XIMG   LIST

a  = [     0      0   %  1 rdb_rec
    0      0   %  2 per_pass
    0      0   %  3 unlock_raw
    0      0   %  4 data_acq_tab
    0      0   %  5 nex_tab
    0      0   %  6 nex_abort_tab
    0      0   %  7 tool
    1040   1040   %  8 exam
    1028   1028   %  9 series
    1044   1044   % 10 image
    116    116   % 11 suite
    124    124   ] ;   % 12 pixel

header_lengths = a(:, format_num);

%-------------------------------------------------------------------------
