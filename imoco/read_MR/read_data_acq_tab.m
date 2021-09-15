function a = read_data_acq_tab( my_file, rdbm_rev)
%read_data_acq_tab - Read GE data acquisition table
%
%  a = read_data_acq_tab( my_file, rdbm_rev );
%    my_file - string indicating file name to read
%    rdbm_rev - raw header (RDBM) revision number
%    a - structure with header values
%

% Copyright (c) 2012 by General Electric Company. All rights reserved.

if rdbm_rev < 10
        a.pass_number    = fread( my_file, 1, 'int16');
        a.slice_in_pass  = fread( my_file, 1, 'int16');
        a.gw_point1_x    = fread( my_file, 1, 'float32');
        a.gw_point1_y    = fread( my_file, 1, 'float32');
        a.gw_point1_z    = fread( my_file, 1, 'float32');
        a.gw_point2_x    = fread( my_file, 1, 'float32');
        a.gw_point2_y    = fread( my_file, 1, 'float32');
        a.gw_point2_z    = fread( my_file, 1, 'float32');
        a.gw_point3_x    = fread( my_file, 1, 'float32');
        a.gw_point3_y    = fread( my_file, 1, 'float32');
        a.gw_point3_z    = fread( my_file, 1, 'float32');
end

if (rdbm_rev > 10)&(rdbm_rev < 14)
        a.pass_number    = fread( my_file, 1, 'int16');
        a.slice_in_pass  = fread( my_file, 1, 'int16');
        a.gw_point1_x    = fread( my_file, 1, 'float32');
        a.gw_point1_y    = fread( my_file, 1, 'float32');
        a.gw_point1_z    = fread( my_file, 1, 'float32');
        a.gw_point2_x    = fread( my_file, 1, 'float32');
        a.gw_point2_y    = fread( my_file, 1, 'float32');
        a.gw_point2_z    = fread( my_file, 1, 'float32');
        a.gw_point3_x    = fread( my_file, 1, 'float32');
        a.gw_point3_y    = fread( my_file, 1, 'float32');
        a.gw_point3_z    = fread( my_file, 1, 'float32');
        a.transpose      = fread( my_file, 1, 'int16');
        a.rotate         = fread( my_file, 1, 'int16');
end

if rdbm_rev == 14
        a.pass_number    = fread( my_file, 1, 'int16');
        a.slice_in_pass  = fread( my_file, 1, 'int16');
        a.gw_point1_x    = fread( my_file, 1, 'float32');
        a.gw_point1_y    = fread( my_file, 1, 'float32');
        a.gw_point1_z    = fread( my_file, 1, 'float32');
        a.gw_point2_x    = fread( my_file, 1, 'float32');
        a.gw_point2_y    = fread( my_file, 1, 'float32');
        a.gw_point2_z    = fread( my_file, 1, 'float32');
        a.gw_point3_x    = fread( my_file, 1, 'float32');
        a.gw_point3_y    = fread( my_file, 1, 'float32');
        a.gw_point3_z    = fread( my_file, 1, 'float32');
        a.transpose      = fread( my_file, 1, 'int16');
        a.rotate         = fread( my_file, 1, 'int16');
        a.swiftcoilno    = fread( my_file, 1, 'uint32');
end

if rdbm_rev == 14.1
        a.pass_number    = fread( my_file, 1, 'int16');
        a.slice_in_pass  = fread( my_file, 1, 'int16');
        a.gw_point1_x    = fread( my_file, 1, 'float32');
        a.gw_point1_y    = fread( my_file, 1, 'float32');
        a.gw_point1_z    = fread( my_file, 1, 'float32');
        a.gw_point2_x    = fread( my_file, 1, 'float32');
        a.gw_point2_y    = fread( my_file, 1, 'float32');
        a.gw_point2_z    = fread( my_file, 1, 'float32');
        a.gw_point3_x    = fread( my_file, 1, 'float32');
        a.gw_point3_y    = fread( my_file, 1, 'float32');
        a.gw_point3_z    = fread( my_file, 1, 'float32');
        a.transpose      = fread( my_file, 1, 'int16');
        a.rotate         = fread( my_file, 1, 'int16');
        a.swiftcoilno    = fread( my_file, 1, 'uint32');
end


if rdbm_rev == 14.2
        a.pass_number    = fread( my_file, 1, 'int16');
        a.slice_in_pass  = fread( my_file, 1, 'int16');
        a.gw_point1_x    = fread( my_file, 1, 'float32');
        a.gw_point1_y    = fread( my_file, 1, 'float32');
        a.gw_point1_z    = fread( my_file, 1, 'float32');
        a.gw_point2_x    = fread( my_file, 1, 'float32');
        a.gw_point2_y    = fread( my_file, 1, 'float32');
        a.gw_point2_z    = fread( my_file, 1, 'float32');
        a.gw_point3_x    = fread( my_file, 1, 'float32');
        a.gw_point3_y    = fread( my_file, 1, 'float32');
        a.gw_point3_z    = fread( my_file, 1, 'float32');
        a.transpose      = fread( my_file, 1, 'int16');
        a.rotate         = fread( my_file, 1, 'int16');
        a.swiftcoilno    = fread( my_file, 1, 'uint32');
end

%if rdbm_rev == 14.3
%        a.pass_number    = fread( my_file, 1, 'int16');
%        a.slice_in_pass  = fread( my_file, 1, 'int16');
%        a.gw_point1_x    = fread( my_file, 1, 'float32');
%        a.gw_point1_y    = fread( my_file, 1, 'float32');
%        a.gw_point1_z    = fread( my_file, 1, 'float32');
%        a.gw_point2_x    = fread( my_file, 1, 'float32');
%        a.gw_point2_y    = fread( my_file, 1, 'float32');
%        a.gw_point2_z    = fread( my_file, 1, 'float32');
%        a.gw_point3_x    = fread( my_file, 1, 'float32');
%        a.gw_point3_y    = fread( my_file, 1, 'float32');
%        a.gw_point3_z    = fread( my_file, 1, 'float32');
%        a.transpose      = fread( my_file, 1, 'int16');
%        a.rotate         = fread( my_file, 1, 'int16');
%        a.swiftcoilno    = fread( my_file, 1, 'uint32');
%end

% RDBM revision 14.3
if rdbm_rev == 14.3 
  a.pass_number = fread(my_file, 1, 'int16');
  a.slice_in_pass = fread(my_file, 1, 'int16');
  for id = 1 : 3
    a.gw_point1(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point2(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point3(id) = fread(my_file, 1, 'float32');
  end
  a.transpose = fread(my_file, 1, 'int16');
  a.rotate = fread(my_file, 1, 'int16');
  a.swiftcoilno = fread(my_file, 1, 'uint32');


end

% RDBM revision 15.000
if rdbm_rev == 15.000 
  a.pass_number = fread(my_file, 1, 'int16');
  a.slice_in_pass = fread(my_file, 1, 'int16');
  for id = 1 : 3
    a.gw_point1(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point2(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point3(id) = fread(my_file, 1, 'float32');
  end
  a.transpose = fread(my_file, 1, 'int16');
  a.rotate = fread(my_file, 1, 'int16');
  a.swiftcoilno = fread(my_file, 1, 'uint32');


end

% RDBM revision 15.001
if rdbm_rev == 15.001 
  a.pass_number = fread(my_file, 1, 'int16');
  a.slice_in_pass = fread(my_file, 1, 'int16');
  for id = 1 : 3
    a.gw_point1(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point2(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point3(id) = fread(my_file, 1, 'float32');
  end
  a.transpose = fread(my_file, 1, 'int16');
  a.rotate = fread(my_file, 1, 'int16');
  a.swiftcoilno = fread(my_file, 1, 'uint32');


end

% RDBM revision 16.000
if rdbm_rev == 16.000
  a.pass_number = fread(my_file, 1, 'int16');
  a.slice_in_pass = fread(my_file, 1, 'int16');
  for id = 1 : 3
    a.gw_point1(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point2(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point3(id) = fread(my_file, 1, 'float32');
  end
  a.transpose = fread(my_file, 1, 'int16');
  a.rotate = fread(my_file, 1, 'int16');
  a.swiftcoilno = fread(my_file, 1, 'uint32');


end

% RDBM revision 20.001
if rdbm_rev == 20.001 
  a.pass_number = fread(my_file, 1, 'int16');
  a.slice_in_pass = fread(my_file, 1, 'int16');
  for id = 1 : 3
    a.gw_point1(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point2(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point3(id) = fread(my_file, 1, 'float32');
  end
  a.transpose = fread(my_file, 1, 'int16');
  a.rotate = fread(my_file, 1, 'int16');
  a.swiftcoilno = fread(my_file, 1, 'uint32');


end

% RDBM revision 20.002
if rdbm_rev == 20.002 
  a.pass_number = fread(my_file, 1, 'int16');
  a.slice_in_pass = fread(my_file, 1, 'int16');
  for id = 1 : 3
    a.gw_point1(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point2(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point3(id) = fread(my_file, 1, 'float32');
  end
  a.transpose = fread(my_file, 1, 'int16');
  a.rotate = fread(my_file, 1, 'int16');
  a.swiftcoilno = fread(my_file, 1, 'uint32');


end

% RDBM revision 20.003
if rdbm_rev == 20.003 
  a.pass_number = fread(my_file, 1, 'int16');
  a.slice_in_pass = fread(my_file, 1, 'int16');
  for id = 1 : 3
    a.gw_point1(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point2(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point3(id) = fread(my_file, 1, 'float32');
  end
  a.transpose = fread(my_file, 1, 'int16');
  a.rotate = fread(my_file, 1, 'int16');
  a.swiftcoilno = fread(my_file, 1, 'uint32');


end

% RDBM revision 20.004
if rdbm_rev == 20.004 
  a.pass_number = fread(my_file, 1, 'int16');
  a.slice_in_pass = fread(my_file, 1, 'int16');
  for id = 1 : 3
    a.gw_point1(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point2(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point3(id) = fread(my_file, 1, 'float32');
  end
  a.transpose = fread(my_file, 1, 'int16');
  a.rotate = fread(my_file, 1, 'int16');
  a.coilConfigUID = fread(my_file, 1, 'uint32');


end

% RDBM revision 20.005
if rdbm_rev == 20.005 
  a.pass_number = fread(my_file, 1, 'int16');
  a.slice_in_pass = fread(my_file, 1, 'int16');
  for id = 1 : 3
    a.gw_point1(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point2(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point3(id) = fread(my_file, 1, 'float32');
  end
  a.transpose = fread(my_file, 1, 'int16');
  a.rotate = fread(my_file, 1, 'int16');
  a.coilConfigUID = fread(my_file, 1, 'uint32');


end
% RDBM revision 20.006
if rdbm_rev == 20.006 
  a.pass_number = fread(my_file, 1, 'int16');
  a.slice_in_pass = fread(my_file, 1, 'int16');
  for id = 1 : 3
    a.gw_point1(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point2(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point3(id) = fread(my_file, 1, 'float32');
  end
  a.transpose = fread(my_file, 1, 'int16');
  a.rotate = fread(my_file, 1, 'int16');
  a.coilConfigUID = fread(my_file, 1, 'uint32');


end

% RDBM revision 20.007
if rdbm_rev == 20.007 
  a.pass_number = fread(my_file, 1, 'int16');
  a.slice_in_pass = fread(my_file, 1, 'int16');
  for id = 1 : 3
    a.gw_point1(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point2(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point3(id) = fread(my_file, 1, 'float32');
  end
  a.transpose = fread(my_file, 1, 'int16');
  a.rotate = fread(my_file, 1, 'int16');
  a.coilConfigUID = fread(my_file, 1, 'uint32');


end

% RDBM revision 23.001
if rdbm_rev == 23.001
  a.pass_number = fread(my_file, 1, 'int16');
  a.slice_in_pass = fread(my_file, 1, 'int16');
  for id = 1 : 3
    a.gw_point1(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point2(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point3(id) = fread(my_file, 1, 'float32');
  end
  a.transpose = fread(my_file, 1, 'int16');
  a.rotate = fread(my_file, 1, 'int16');
  a.coilConfigUID = fread(my_file, 1, 'uint32');


end

% RDBM revision 24.000
if rdbm_rev == 24.000 
  a.pass_number = fread(my_file, 1, 'int16');
  a.slice_in_pass = fread(my_file, 1, 'int16');
  for id = 1 : 3
    a.gw_point1(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point2(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point3(id) = fread(my_file, 1, 'float32');
  end
  a.transpose = fread(my_file, 1, 'int16');
  a.rotate = fread(my_file, 1, 'int16');
  a.coilConfigUID = fread(my_file, 1, 'uint32');


end

% RDBM revision 25.001
if rdbm_rev == 25.001 
  a.pass_number = fread(my_file, 1, 'int16');
  a.slice_in_pass = fread(my_file, 1, 'int16');
  for id = 1 : 3
    a.gw_point1(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point2(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point3(id) = fread(my_file, 1, 'float32');
  end
  a.transpose = fread(my_file, 1, 'int16');
  a.rotate = fread(my_file, 1, 'int16');
  a.coilConfigUID = fread(my_file, 1, 'uint32');


end

% RDBM revision 25.002
if rdbm_rev == 25.002 
  a.pass_number = fread(my_file, 1, 'int16');
  a.slice_in_pass = fread(my_file, 1, 'int16');
  for id = 1 : 3
    a.gw_point1(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point2(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point3(id) = fread(my_file, 1, 'float32');
  end
  a.transpose = fread(my_file, 1, 'int16');
  a.rotate = fread(my_file, 1, 'int16');
  a.coilConfigUID = fread(my_file, 1, 'uint32');


end

% RDBM revision 25.003
if rdbm_rev == 25.003 
  a.pass_number = fread(my_file, 1, 'int16');
  a.slice_in_pass = fread(my_file, 1, 'int16');
  for id = 1 : 3
    a.gw_point1(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point2(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point3(id) = fread(my_file, 1, 'float32');
  end
  a.transpose = fread(my_file, 1, 'int16');
  a.rotate = fread(my_file, 1, 'int16');
  a.coilConfigUID = fread(my_file, 1, 'uint32');


end

% RDBM revision 25.004
if rdbm_rev == 25.004
  a.pass_number = fread(my_file, 1, 'int16');
  a.slice_in_pass = fread(my_file, 1, 'int16');
  for id = 1 : 3
    a.gw_point1(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point2(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point3(id) = fread(my_file, 1, 'float32');
  end
  a.transpose = fread(my_file, 1, 'int16');
  a.rotate = fread(my_file, 1, 'int16');
  a.coilConfigUID = fread(my_file, 1, 'uint32');
  a.fov_freq_scale = fread(my_file, 1, 'float32');
  a.fov_phase_scale = fread(my_file, 1, 'float32');
  a.slthick_scale = fread(my_file, 1, 'float32');
  a.freq_loc_shift = fread(my_file, 1, 'float32');
  a.phase_loc_shift = fread(my_file, 1, 'float32');
  a.slice_loc_shift = fread(my_file, 1, 'float32');


end

% RDBM revision 26.000
if rdbm_rev == 26.000
  a.pass_number = fread(my_file, 1, 'int16');
  a.slice_in_pass = fread(my_file, 1, 'int16');
  for id = 1 : 3
    a.gw_point1(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point2(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point3(id) = fread(my_file, 1, 'float32');
  end
  a.transpose = fread(my_file, 1, 'int16');
  a.rotate = fread(my_file, 1, 'int16');
  a.coilConfigUID = fread(my_file, 1, 'uint32');


end

% RDBM revision 26.001
if rdbm_rev == 26.001 
  a.pass_number = fread(my_file, 1, 'int16');
  a.slice_in_pass = fread(my_file, 1, 'int16');
  for id = 1 : 3
    a.gw_point1(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point2(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point3(id) = fread(my_file, 1, 'float32');
  end
  a.transpose = fread(my_file, 1, 'int16');
  a.rotate = fread(my_file, 1, 'int16');
  a.coilConfigUID = fread(my_file, 1, 'uint32');


end

% RDBM revision 26.002
if rdbm_rev == 26.002 
  a.pass_number = fread(my_file, 1, 'int16');
  a.slice_in_pass = fread(my_file, 1, 'int16');
  for id = 1 : 3
    a.gw_point1(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point2(id) = fread(my_file, 1, 'float32');
  end
  for id = 1 : 3
    a.gw_point3(id) = fread(my_file, 1, 'float32');
  end
  a.transpose = fread(my_file, 1, 'int16');
  a.rotate = fread(my_file, 1, 'int16');
  a.coilConfigUID = fread(my_file, 1, 'uint32');
  a.fov_freq_scale = fread(my_file, 1, 'float32');
  a.fov_phase_scale = fread(my_file, 1, 'float32');
  a.slthick_scale = fread(my_file, 1, 'float32');
  a.freq_loc_shift = fread(my_file, 1, 'float32');
  a.phase_loc_shift = fread(my_file, 1, 'float32');
  a.slice_loc_shift = fread(my_file, 1, 'float32');


end

