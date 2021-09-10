function a = read_exam_header( my_file,rdbm_rev )
%read_exam_header - Read GE exam header
%
%  a = read_exam_header( my_file, rdbm_rev );
%    my_file - string indicating file name to read
%    rdbm_rev - raw header (RDBM) revision number
%    a - structure with header values
%

% Copyright (c) 2012 by General Electric Company. All rights reserved.

if rdbm_rev < 11.0
  a.ex_suid       = freadc( my_file,  4 );
  a.ex_uniq       =  fread( my_file,  1, 'int16' );
  a.ex_diskid     = freadc( my_file,  1 );
  fseek(my_file, 1, 'cof');
  a.ex_no         =  fread( my_file,  1, 'uint16' );
  a.hospname      = freadc( my_file, 33 );
  fseek(my_file, 1, 'cof');
  a.detect        =  fread( my_file,  1, 'int16' );
  fseek(my_file, 2, 'cof');
  a.numcells      =  fread( my_file,  1, 'int32' );
  a.zerocell      =  fread( my_file,  1, 'float32' );
  a.cellspace     =  fread( my_file,  1, 'float32' );
  a.srctodet      =  fread( my_file,  1, 'float32' );
  a.srctoiso      =  fread( my_file,  1, 'float32' );
  a.tubetyp       =  fread( my_file,  1, 'int16' );
  a.dastyp        =  fread( my_file,  1, 'int16' );
  a.num_dcnk      =  fread( my_file,  1, 'int16' );
  a.dcn_len       =  fread( my_file,  1, 'int16' );
  a.dcn_density   =  fread( my_file,  1, 'int16' );
  a.dcn_stepsize  =  fread( my_file,  1, 'int16' );
  a.dcn_shiftcnt  =  fread( my_file,  1, 'int16' );
  fseek(my_file, 2, 'cof');
  a.magstrength   =  fread( my_file,  1, 'int32' );
  a.patid         = freadc( my_file, 13  );
  a.patname       = freadc( my_file, 25  );
  a.patage        =  fread( my_file,  1, 'int16' );
  a.patian        =  fread( my_file,  1, 'int16' );
  a.patsex        =  fread( my_file,  1, 'int16' );
  a.patweight     =  fread( my_file,  1, 'int32' );
  a.trauma        =  fread( my_file,  1, 'int16' );
  a.hist          = freadc( my_file, 61  );
  a.reqnum        = freadc( my_file, 13  );
  a.ex_datetime   =  fread( my_file,  1, 'int32' );
  a.refphy        = freadc( my_file, 33  );
  a.diagrad       = freadc( my_file, 33  );
  a.op            = freadc( my_file,  4  );
  a.ex_desc       = freadc( my_file, 23  );
  a.ex_typ        = freadc( my_file,  3  );
  a.ex_format     =  fread( my_file,  1, 'int16' );
  a.padding1      = freadc( my_file,  4  );
  fseek(my_file, 2, 'cof');

  a.firstaxtime   =  fread( my_file,  1, 'double' );
  a.ex_sysid      = freadc( my_file,  9  );
  fseek(my_file, 3, 'cof');
  a.ex_lastmod    =  fread( my_file,  1, 'int32' );
  a.protocolflag  =  fread( my_file,  1, 'int16' );
  a.ex_alloc_key  = freadc( my_file, 13  );
  fseek(my_file, 1, 'cof');
  a.ex_delta_cnt  =  fread( my_file,  1, 'int32' );
  a.ex_verscre    = freadc( my_file,  2  );
  a.ex_verscur    = freadc( my_file,  2  );
  a.ex_checksum   =  fread( my_file,  1, 'uint32' );
  a.ex_complete   =  fread( my_file,  1, 'int32' );
  a.ex_seriesct   =  fread( my_file,  1, 'int32' );
  a.ex_numarch    =  fread( my_file,  1, 'int32' );
  a.ex_numseries  =  fread( my_file,  1, 'int32' );
  a.ex_series     =  fread_vartype( my_file );
  a.ex_numunser   =  fread( my_file,  1, 'int32' );
  a.ex_unseries   =  fread_vartype( my_file );
  a.ex_toarchcnt  =  fread( my_file,  1, 'int32' );
  a.ex_toarchive  =  fread_vartype( my_file );
  a.ex_prospcnt   =  fread( my_file,  1, 'int32' );
  a.ex_prosp      =  fread_vartype( my_file );
  a.ex_modelnum   =  fread( my_file,  1, 'int32' );
  a.ex_modelcnt   =  fread( my_file,  1, 'int32' );
  a.ex_models     =  fread_vartype( my_file );
  a.ex_stat       =  fread( my_file,  1, 'int16' );
  a.uniq_sys_id   = freadc( my_file, 16  );
  a.service_id    = freadc( my_file, 16  );
  a.mobile_loc    = freadc( my_file,  4  );
  a.study_uid     = freadc( my_file, 32  );
  a.study_status  =  fread( my_file,  1, 'int16' );
  a.refsopcuid    = freadc( my_file, 32  );
  a.refsopiuid    = freadc( my_file, 32  );

  a.patnameff     = freadc( my_file, 65  );
  a.patidff       = freadc( my_file, 65  );
  a.reqnumff      = freadc( my_file, 17  );
  a.dateofbirth   = freadc( my_file,  9  );
  a.mwlstudyuid   = freadc( my_file, 32  );
  a.mwlstudyid    = freadc( my_file, 16  );
% a.ex_padding    = freadc( my_file,248  );
end


if rdbm_rev <= 14.0
      a.firstaxtime = fread(my_file, 1, 'float');
  a.ex_series = fread_vartype( my_file );
  a.ex_unseries = fread_vartype( my_file );
  a.ex_toarchive = fread_vartype( my_file );
  a.ex_prosp = fread_vartype( my_file );
  a.ex_models = fread_vartype( my_file );
  a.zerocell = fread(my_file, 1, 'float32');
  a.cellspace = fread(my_file, 1, 'float32');
  a.srctodet = fread(my_file, 1, 'float32');
  a.srctoiso = fread(my_file, 1, 'float32');
  a.ex_delta_cnt = fread(my_file, 1, 'int32');
  a.ex_complete = fread(my_file, 1, 'int32');
  a.ex_seriesct = fread(my_file, 1, 'int32');
  a.ex_numarch = fread(my_file, 1, 'int32');
  a.ex_numseries = fread(my_file, 1, 'int32');
  a.ex_numunser = fread(my_file, 1, 'int32');
  a.ex_toarchcnt = fread(my_file, 1, 'int32');
  a.ex_prospcnt = fread(my_file, 1, 'int32');
  a.ex_modelnum = fread(my_file, 1, 'int32');
  a.ex_modelcnt = fread(my_file, 1, 'int32');
  a.ex_checksum = fread(my_file, 1, 'uint32');
  a.numcells = fread(my_file, 1, 'int32');
  a.magstrength = fread(my_file, 1, 'int32');
  a.patweight = fread(my_file, 1, 'int32');
  a.ex_datetime = fread(my_file, 1, 'int32');
  a.ex_lastmod = fread(my_file, 1, 'int32');
  a.ex_no = fread(my_file, 1, 'uint16');
  a.ex_uniq = fread(my_file, 1, 'int16');
  a.detect = fread(my_file, 1, 'int16');
  a.tubetyp = fread(my_file, 1, 'int16');
  a.dastyp = fread(my_file, 1, 'int16');
  a.num_dcnk = fread(my_file, 1, 'int16');
  a.dcn_len = fread(my_file, 1, 'int16');
  a.dcn_density = fread(my_file, 1, 'int16');
  a.dcn_stepsize = fread(my_file, 1, 'int16');
  a.dcn_shiftcnt = fread(my_file, 1, 'int16');
  a.patage = fread(my_file, 1, 'int16');
  a.patian = fread(my_file, 1, 'int16');
  a.patsex = fread(my_file, 1, 'int16');
  a.ex_format = fread(my_file, 1, 'int16');
  a.trauma = fread(my_file, 1, 'int16');
  a.protocolflag = fread(my_file, 1, 'int16');
  a.study_status = fread(my_file, 1, 'int16');
  a.padding = fread(my_file, 3, 'int16');
  a.hist = freadc(my_file, 61);
  a.reqnum = freadc(my_file, 13);
  a.refphy = freadc(my_file, 33);
  a.diagrad = freadc(my_file, 33);
  a.op = freadc(my_file, 4);
  a.ex_desc = freadc(my_file, 65);
  a.ex_typ = freadc(my_file, 3);
  a.ex_sysid = freadc(my_file, 9);
  a.ex_alloc_key = freadc(my_file, 13);
  a.ex_diskid = fread(my_file, 1, 'char');
  a.hospname = freadc(my_file, 33);
  a.patid = freadc(my_file, 13);
  a.patname = freadc(my_file, 25);
  a.ex_suid = freadc(my_file, 4);
  a.ex_verscre = freadc(my_file, 2);
  a.ex_verscur = freadc(my_file, 2);
  a.uniq_sys_id = freadc(my_file, 16);
  a.service_id = freadc(my_file, 16);
  a.mobile_loc = freadc(my_file, 4);
  a.study_uid = freadc(my_file, 32);
  a.refsopcuid = freadc(my_file, 32);
  a.refsopiuid = freadc(my_file, 32);
  a.patnameff = freadc(my_file, 65);
  a.patidff = freadc(my_file, 65);
  a.reqnumff = freadc(my_file, 17);
  a.dateofbirth = freadc(my_file, 9);
  a.mwlstudyuid = freadc(my_file, 32);
  a.mwlstudyid = freadc(my_file, 16);
  a.ex_padding = freadc(my_file, 222);
end


if rdbm_rev == 14.1
      a.firstaxtime = fread(my_file, 1, 'float32');
  a.ex_series.length = fread(my_file, 1, 'int32');
  a.ex_series.data = fread(my_file, 1, 'int32');
  a.ex_unseries.length = fread(my_file, 1, 'int32');
  a.ex_unseries.data = fread(my_file, 1, 'int32');
  a.ex_toarchive.length = fread(my_file, 1, 'int32');
  a.ex_toarchive.data = fread(my_file, 1, 'int32');
  a.ex_prosp.length = fread(my_file, 1, 'int32');
  a.ex_prosp.data = fread(my_file, 1, 'int32');
  a.ex_models.length = fread(my_file, 1, 'int32');
  a.ex_models.data = fread(my_file, 1, 'int32');
  a.zerocell = fread(my_file, 1, 'float32');
  a.cellspace = fread(my_file, 1, 'float32');
  a.srctodet = fread(my_file, 1, 'float32');
  a.srctoiso = fread(my_file, 1, 'float32');
  a.ex_delta_cnt = fread(my_file, 1, 'int32');
  a.ex_complete = fread(my_file, 1, 'int32');
  a.ex_seriesct = fread(my_file, 1, 'int32');
  a.ex_numarch = fread(my_file, 1, 'int32');
  a.ex_numseries = fread(my_file, 1, 'int32');
  a.ex_numunser = fread(my_file, 1, 'int32');
  a.ex_toarchcnt = fread(my_file, 1, 'int32');
  a.ex_prospcnt = fread(my_file, 1, 'int32');
  a.ex_modelnum = fread(my_file, 1, 'int32');
  a.ex_modelcnt = fread(my_file, 1, 'int32');
  a.ex_checksum = fread(my_file, 1, 'uint32');
  a.numcells = fread(my_file, 1, 'int32');
  a.magstrength = fread(my_file, 1, 'int32');
  a.patweight = fread(my_file, 1, 'int32');
  a.ex_datetime = fread(my_file, 1, 'int32');
  a.ex_lastmod = fread(my_file, 1, 'int32');
  a.ex_no = fread(my_file, 1, 'uint16');
  a.ex_uniq = fread(my_file, 1, 'int16');
  a.detect = fread(my_file, 1, 'int16');
  a.tubetyp = fread(my_file, 1, 'int16');
  a.dastyp = fread(my_file, 1, 'int16');
  a.num_dcnk = fread(my_file, 1, 'int16');
  a.dcn_len = fread(my_file, 1, 'int16');
  a.dcn_density = fread(my_file, 1, 'int16');
  a.dcn_stepsize = fread(my_file, 1, 'int16');
  a.dcn_shiftcnt = fread(my_file, 1, 'int16');
  a.patage = fread(my_file, 1, 'int16');
  a.patian = fread(my_file, 1, 'int16');
  a.patsex = fread(my_file, 1, 'int16');
  a.ex_format = fread(my_file, 1, 'int16');
  a.trauma = fread(my_file, 1, 'int16');
  a.protocolflag = fread(my_file, 1, 'int16');
  a.study_status = fread(my_file, 1, 'int16');
  for id = 1 : 3
    a.padding(id) = fread(my_file, 1, 'int16');
  end
  a.hist = freadc(my_file, 61);
  a.reqnum = freadc(my_file, 13);
  a.refphy = freadc(my_file, 33);
  a.diagrad = freadc(my_file, 33);
  a.op = freadc(my_file, 4);
  a.ex_desc = freadc(my_file, 65);
  a.ex_typ = freadc(my_file, 3);
  a.ex_sysid = freadc(my_file, 9);
  a.ex_alloc_key = freadc(my_file, 13);
  a.ex_diskid = fread(my_file, 1, 'char');
  a.hospname = freadc(my_file, 33);
  a.patid = freadc(my_file, 13);
  a.patname = freadc(my_file, 25);
  for id = 1 : 4
    a.ex_suid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.uniq_sys_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.service_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.mobile_loc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.study_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patnameff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patidff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 17
    a.reqnumff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 9
    a.dateofbirth(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.mwlstudyuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.mwlstudyid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 222
    a.ex_padding(id) = fread(my_file, 1, 'char');
  end
end


if rdbm_rev == 14.2
      a.firstaxtime = fread(my_file, 1, 'double');
  for id = 1 : 9
    a.double_padding(id) = fread(my_file, 1, 'double');
  end
  a.zerocell = fread(my_file, 1, 'float32');
  a.cellspace = fread(my_file, 1, 'float32');
  a.srctodet = fread(my_file, 1, 'float32');
  a.srctoiso = fread(my_file, 1, 'float32');
  for id = 1 : 8
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.ex_delta_cnt = fread(my_file, 1, 'int32');
  a.ex_complete = fread(my_file, 1, 'int32');
  a.ex_seriesct = fread(my_file, 1, 'int32');
  a.ex_numarch = fread(my_file, 1, 'int32');
  a.ex_numseries = fread(my_file, 1, 'int32');
  a.ex_numunser = fread(my_file, 1, 'int32');
  a.ex_toarchcnt = fread(my_file, 1, 'int32');
  a.ex_prospcnt = fread(my_file, 1, 'int32');
  a.ex_modelnum = fread(my_file, 1, 'int32');
  a.ex_modelcnt = fread(my_file, 1, 'int32');
  a.ex_checksum = fread(my_file, 1, 'uint32');
  for id = 1 : 8
    a.long_padding(id) = fread(my_file, 1, 'int32');
  end
  a.numcells = fread(my_file, 1, 'int32');
  a.magstrength = fread(my_file, 1, 'int32');
  a.patweight = fread(my_file, 1, 'int32');
  a.ex_datetime = fread(my_file, 1, 'int32');
  a.ex_lastmod = fread(my_file, 1, 'int32');
  for id = 1 : 12
    a.int_padding(id) = fread(my_file, 1, 'int32');
  end
  a.ex_no = fread(my_file, 1, 'uint16');
  a.ex_uniq = fread(my_file, 1, 'int16');
  a.detect = fread(my_file, 1, 'int16');
  a.tubetyp = fread(my_file, 1, 'int16');
  a.dastyp = fread(my_file, 1, 'int16');
  a.num_dcnk = fread(my_file, 1, 'int16');
  a.dcn_len = fread(my_file, 1, 'int16');
  a.dcn_density = fread(my_file, 1, 'int16');
  a.dcn_stepsize = fread(my_file, 1, 'int16');
  a.dcn_shiftcnt = fread(my_file, 1, 'int16');
  a.patage = fread(my_file, 1, 'int16');
  a.patian = fread(my_file, 1, 'int16');
  a.patsex = fread(my_file, 1, 'int16');
  a.ex_format = fread(my_file, 1, 'int16');
  a.trauma = fread(my_file, 1, 'int16');
  a.protocolflag = fread(my_file, 1, 'int16');
  a.study_status = fread(my_file, 1, 'int16');
  for id = 1 : 11
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  a.hist = freadc(my_file, 61);
  a.reqnum = freadc(my_file, 13);
  a.refphy = freadc(my_file, 33);
  a.diagrad = freadc(my_file, 33);
  a.op = freadc(my_file, 4);
  a.ex_desc = freadc(my_file, 65);
  a.ex_typ = freadc(my_file, 3);
  a.ex_sysid = freadc(my_file, 9);
  a.ex_alloc_key = freadc(my_file, 13);
  a.ex_diskid = fread(my_file, 1, 'char');
  a.hospname = freadc(my_file, 33);
  a.patid = freadc(my_file, 13);
  a.patname = freadc(my_file, 25);
  for id = 1 : 4
    a.ex_suid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.uniq_sys_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.service_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.mobile_loc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.study_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patnameff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patidff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 17
    a.reqnumff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 9
    a.dateofbirth(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.mwlstudyuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.mwlstudyid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 62
    a.ex_padding(id) = fread(my_file, 1, 'char');
  end
end


    
% RDBM revision 14.3
if rdbm_rev == 14.3 
  fseek(my_file, 40, 'cof'); 
  a.firstaxtime = fread(my_file, 1, 'float32');
  for id = 1 : 9
    a.double_padding(id) = fread(my_file, 1, 'float32');
  end
  a.zerocell = fread(my_file, 1, 'float32');
  a.cellspace = fread(my_file, 1, 'float32');
  a.srctodet = fread(my_file, 1, 'float32');
  a.srctoiso = fread(my_file, 1, 'float32');
  for id = 1 : 8
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.ex_delta_cnt = fread(my_file, 1, 'int32');
  a.ex_complete = fread(my_file, 1, 'int32');
  a.ex_seriesct = fread(my_file, 1, 'int32');
  a.ex_numarch = fread(my_file, 1, 'int32');
  a.ex_numseries = fread(my_file, 1, 'int32');
  a.ex_numunser = fread(my_file, 1, 'int32');
  a.ex_toarchcnt = fread(my_file, 1, 'int32');
  a.ex_prospcnt = fread(my_file, 1, 'int32');
  a.ex_modelnum = fread(my_file, 1, 'int32');
  a.ex_modelcnt = fread(my_file, 1, 'int32');
  a.ex_checksum = fread(my_file, 1, 'uint32');
  for id = 1 : 8
    a.long_padding(id) = fread(my_file, 1, 'int32');
  end
  a.numcells = fread(my_file, 1, 'int32');
  a.magstrength = fread(my_file, 1, 'int32');
  a.patweight = fread(my_file, 1, 'int32');
  a.ex_datetime = fread(my_file, 1, 'int32');
  a.ex_lastmod = fread(my_file, 1, 'int32');
  for id = 1 : 12
    a.int_padding(id) = fread(my_file, 1, 'int32');
  end
  a.ex_no = fread(my_file, 1, 'uint16');
  a.ex_uniq = fread(my_file, 1, 'int16');
  a.detect = fread(my_file, 1, 'int16');
  a.tubetyp = fread(my_file, 1, 'int16');
  a.dastyp = fread(my_file, 1, 'int16');
  a.num_dcnk = fread(my_file, 1, 'int16');
  a.dcn_len = fread(my_file, 1, 'int16');
  a.dcn_density = fread(my_file, 1, 'int16');
  a.dcn_stepsize = fread(my_file, 1, 'int16');
  a.dcn_shiftcnt = fread(my_file, 1, 'int16');
  a.patage = fread(my_file, 1, 'int16');
  a.patian = fread(my_file, 1, 'int16');
  a.patsex = fread(my_file, 1, 'int16');
  a.ex_format = fread(my_file, 1, 'int16');
  a.trauma = fread(my_file, 1, 'int16');
  a.protocolflag = fread(my_file, 1, 'int16');
  a.study_status = fread(my_file, 1, 'int16');
  for id = 1 : 11
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  a.hist = freadc(my_file, 61);
  a.reqnum = freadc(my_file, 13);
  a.refphy = freadc(my_file, 33);
  a.diagrad = freadc(my_file, 33);
  a.op = freadc(my_file, 4);
  a.ex_desc = freadc(my_file, 65);
  a.ex_typ = freadc(my_file, 3);
  a.ex_sysid = freadc(my_file, 9);
  a.ex_alloc_key = freadc(my_file, 13);
  a.ex_diskid = fread(my_file, 1, 'char');
  a.hospname = freadc(my_file, 33);
  a.patid = freadc(my_file, 13);
  a.patname = freadc(my_file, 25);
  for id = 1 : 4
    a.ex_suid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.uniq_sys_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.service_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.mobile_loc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.study_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patnameff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patidff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 17
    a.reqnumff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 9
    a.dateofbirth(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.mwlstudyuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.mwlstudyid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 62
    a.ex_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 15.000
if rdbm_rev == 15.000 
  a.firstaxtime = fread(my_file, 1, 'float64');
  for id = 1 : 9
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.zerocell = fread(my_file, 1, 'float32');
  a.cellspace = fread(my_file, 1, 'float32');
  a.srctodet = fread(my_file, 1, 'float32');
  a.srctoiso = fread(my_file, 1, 'float32');
  for id = 1 : 8
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.ex_delta_cnt = fread(my_file, 1, 'int32');
  a.ex_complete = fread(my_file, 1, 'int32');
  a.ex_seriesct = fread(my_file, 1, 'int32');
  a.ex_numarch = fread(my_file, 1, 'int32');
  a.ex_numseries = fread(my_file, 1, 'int32');
  a.ex_numunser = fread(my_file, 1, 'int32');
  a.ex_toarchcnt = fread(my_file, 1, 'int32');
  a.ex_prospcnt = fread(my_file, 1, 'int32');
  a.ex_modelnum = fread(my_file, 1, 'int32');
  a.ex_modelcnt = fread(my_file, 1, 'int32');
  a.ex_checksum = fread(my_file, 1, 'uint32');
  for id = 1 : 8
    a.long_padding(id) = fread(my_file, 1, 'int32');
  end
  a.numcells = fread(my_file, 1, 'int32');
  a.magstrength = fread(my_file, 1, 'int32');
  a.patweight = fread(my_file, 1, 'int32');
  a.ex_datetime = fread(my_file, 1, 'int32');
  a.ex_lastmod = fread(my_file, 1, 'int32');
  for id = 1 : 12
    a.int_padding(id) = fread(my_file, 1, 'int32');
  end
  a.ex_no = fread(my_file, 1, 'uint16');
  a.ex_uniq = fread(my_file, 1, 'int16');
  a.detect = fread(my_file, 1, 'int16');
  a.tubetyp = fread(my_file, 1, 'int16');
  a.dastyp = fread(my_file, 1, 'int16');
  a.num_dcnk = fread(my_file, 1, 'int16');
  a.dcn_len = fread(my_file, 1, 'int16');
  a.dcn_density = fread(my_file, 1, 'int16');
  a.dcn_stepsize = fread(my_file, 1, 'int16');
  a.dcn_shiftcnt = fread(my_file, 1, 'int16');
  a.patage = fread(my_file, 1, 'int16');
  a.patian = fread(my_file, 1, 'int16');
  a.patsex = fread(my_file, 1, 'int16');
  a.ex_format = fread(my_file, 1, 'int16');
  a.trauma = fread(my_file, 1, 'int16');
  a.protocolflag = fread(my_file, 1, 'int16');
  a.study_status = fread(my_file, 1, 'int16');
  for id = 1 : 11
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  a.hist = freadc(my_file, 61);
  a.reqnum = freadc(my_file, 13);
  a.refphy = freadc(my_file, 33);
  a.diagrad = freadc(my_file, 33);
  a.op = freadc(my_file, 4);
  a.ex_desc = freadc(my_file, 65);
  a.ex_typ = freadc(my_file, 3);
  a.ex_sysid = freadc(my_file, 9);
  a.ex_alloc_key = freadc(my_file, 13);
  a.ex_diskid = fread(my_file, 1, 'char');
  a.hospname = freadc(my_file, 33);
  a.patid = freadc(my_file, 13);
  a.patname = freadc(my_file, 25);
  for id = 1 : 4
    a.ex_suid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.uniq_sys_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.service_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.mobile_loc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.study_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patnameff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patidff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 17
    a.reqnumff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 9
    a.dateofbirth(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.mwlstudyuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.mwlstudyid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 62
    a.ex_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 15.001
if rdbm_rev == 15.001 
  a.firstaxtime = fread(my_file, 1, 'float64');
  for id = 1 : 9
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.zerocell = fread(my_file, 1, 'float32');
  a.cellspace = fread(my_file, 1, 'float32');
  a.srctodet = fread(my_file, 1, 'float32');
  a.srctoiso = fread(my_file, 1, 'float32');
  for id = 1 : 8
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.ex_delta_cnt = fread(my_file, 1, 'int32');
  a.ex_complete = fread(my_file, 1, 'int32');
  a.ex_seriesct = fread(my_file, 1, 'int32');
  a.ex_numarch = fread(my_file, 1, 'int32');
  a.ex_numseries = fread(my_file, 1, 'int32');
  a.ex_numunser = fread(my_file, 1, 'int32');
  a.ex_toarchcnt = fread(my_file, 1, 'int32');
  a.ex_prospcnt = fread(my_file, 1, 'int32');
  a.ex_modelnum = fread(my_file, 1, 'int32');
  a.ex_modelcnt = fread(my_file, 1, 'int32');
  a.ex_checksum = fread(my_file, 1, 'uint32');
  for id = 1 : 8
    a.long_padding(id) = fread(my_file, 1, 'int32');
  end
  a.numcells = fread(my_file, 1, 'int32');
  a.magstrength = fread(my_file, 1, 'int32');
  a.patweight = fread(my_file, 1, 'int32');
  a.ex_datetime = fread(my_file, 1, 'int32');
  a.ex_lastmod = fread(my_file, 1, 'int32');
  for id = 1 : 12
    a.int_padding(id) = fread(my_file, 1, 'int32');
  end
  a.ex_no = fread(my_file, 1, 'uint16');
  a.ex_uniq = fread(my_file, 1, 'int16');
  a.detect = fread(my_file, 1, 'int16');
  a.tubetyp = fread(my_file, 1, 'int16');
  a.dastyp = fread(my_file, 1, 'int16');
  a.num_dcnk = fread(my_file, 1, 'int16');
  a.dcn_len = fread(my_file, 1, 'int16');
  a.dcn_density = fread(my_file, 1, 'int16');
  a.dcn_stepsize = fread(my_file, 1, 'int16');
  a.dcn_shiftcnt = fread(my_file, 1, 'int16');
  a.patage = fread(my_file, 1, 'int16');
  a.patian = fread(my_file, 1, 'int16');
  a.patsex = fread(my_file, 1, 'int16');
  a.ex_format = fread(my_file, 1, 'int16');
  a.trauma = fread(my_file, 1, 'int16');
  a.protocolflag = fread(my_file, 1, 'int16');
  a.study_status = fread(my_file, 1, 'int16');
  for id = 1 : 11
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  a.hist = freadc(my_file, 61);
  a.reqnum = freadc(my_file, 13);
  a.refphy = freadc(my_file, 33);
  a.diagrad = freadc(my_file, 33);
  a.op = freadc(my_file, 4);
  a.ex_desc = freadc(my_file, 65);
  a.ex_typ = freadc(my_file, 3);
  a.ex_sysid = freadc(my_file, 9);
  a.ex_alloc_key = freadc(my_file, 13);
  a.ex_diskid = fread(my_file, 1, 'char');
  a.hospname = freadc(my_file, 33);
  a.patid = freadc(my_file, 13);
  a.patname = freadc(my_file, 25);
  for id = 1 : 4
    a.ex_suid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.uniq_sys_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.service_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.mobile_loc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.study_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patnameff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patidff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 17
    a.reqnumff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 9
    a.dateofbirth(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.mwlstudyuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.mwlstudyid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 62
    a.ex_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 16.000
if rdbm_rev == 16.000 
  a.firstaxtime = fread(my_file, 1, 'float64');
  for id = 1 : 9
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.zerocell = fread(my_file, 1, 'float32');
  a.cellspace = fread(my_file, 1, 'float32');
  a.srctodet = fread(my_file, 1, 'float32');
  a.srctoiso = fread(my_file, 1, 'float32');
  for id = 1 : 8
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.ex_delta_cnt = fread(my_file, 1, 'int32');
  a.ex_complete = fread(my_file, 1, 'int32');
  a.ex_seriesct = fread(my_file, 1, 'int32');
  a.ex_numarch = fread(my_file, 1, 'int32');
  a.ex_numseries = fread(my_file, 1, 'int32');
  a.ex_numunser = fread(my_file, 1, 'int32');
  a.ex_toarchcnt = fread(my_file, 1, 'int32');
  a.ex_prospcnt = fread(my_file, 1, 'int32');
  a.ex_modelnum = fread(my_file, 1, 'int32');
  a.ex_modelcnt = fread(my_file, 1, 'int32');
  a.ex_checksum = fread(my_file, 1, 'uint32');
  for id = 1 : 8
    a.long_padding(id) = fread(my_file, 1, 'int32');
  end
  a.numcells = fread(my_file, 1, 'int32');
  a.magstrength = fread(my_file, 1, 'int32');
  a.patweight = fread(my_file, 1, 'int32');
  a.ex_datetime = fread(my_file, 1, 'int32');
  a.ex_lastmod = fread(my_file, 1, 'int32');
  for id = 1 : 12
    a.int_padding(id) = fread(my_file, 1, 'int32');
  end
  a.ex_no = fread(my_file, 1, 'uint16');
  a.ex_uniq = fread(my_file, 1, 'int16');
  a.detect = fread(my_file, 1, 'int16');
  a.tubetyp = fread(my_file, 1, 'int16');
  a.dastyp = fread(my_file, 1, 'int16');
  a.num_dcnk = fread(my_file, 1, 'int16');
  a.dcn_len = fread(my_file, 1, 'int16');
  a.dcn_density = fread(my_file, 1, 'int16');
  a.dcn_stepsize = fread(my_file, 1, 'int16');
  a.dcn_shiftcnt = fread(my_file, 1, 'int16');
  a.patage = fread(my_file, 1, 'int16');
  a.patian = fread(my_file, 1, 'int16');
  a.patsex = fread(my_file, 1, 'int16');
  a.ex_format = fread(my_file, 1, 'int16');
  a.trauma = fread(my_file, 1, 'int16');
  a.protocolflag = fread(my_file, 1, 'int16');
  a.study_status = fread(my_file, 1, 'int16');
  for id = 1 : 11
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  a.hist = freadc(my_file, 61);
  a.reqnum = freadc(my_file, 13);
  a.refphy = freadc(my_file, 33);
  a.diagrad = freadc(my_file, 33);
  a.op = freadc(my_file, 4);
  a.ex_desc = freadc(my_file, 65);
  a.ex_typ = freadc(my_file, 3);
  a.ex_sysid = freadc(my_file, 9);
  a.ex_alloc_key = freadc(my_file, 13);
  a.ex_diskid = fread(my_file, 1, 'char');
  a.hospname = freadc(my_file, 33);
  a.patid = freadc(my_file, 13);
  a.patname = freadc(my_file, 25);
  for id = 1 : 4
    a.ex_suid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.uniq_sys_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.service_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.mobile_loc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.study_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patnameff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patidff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 17
    a.reqnumff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 9
    a.dateofbirth(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.mwlstudyuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.mwlstudyid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 62
    a.ex_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 20.001
if rdbm_rev == 20.001 
  a.firstaxtime = fread(my_file, 1, 'float64');
  for id = 1 : 9
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.zerocell = fread(my_file, 1, 'float32');
  a.cellspace = fread(my_file, 1, 'float32');
  a.srctodet = fread(my_file, 1, 'float32');
  a.srctoiso = fread(my_file, 1, 'float32');
  for id = 1 : 8
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.ex_delta_cnt = fread(my_file, 1, 'int32');
  a.ex_complete = fread(my_file, 1, 'int32');
  a.ex_seriesct = fread(my_file, 1, 'int32');
  a.ex_numarch = fread(my_file, 1, 'int32');
  a.ex_numseries = fread(my_file, 1, 'int32');
  a.ex_numunser = fread(my_file, 1, 'int32');
  a.ex_toarchcnt = fread(my_file, 1, 'int32');
  a.ex_prospcnt = fread(my_file, 1, 'int32');
  a.ex_modelnum = fread(my_file, 1, 'int32');
  a.ex_modelcnt = fread(my_file, 1, 'int32');
  a.ex_checksum = fread(my_file, 1, 'uint32');
  for id = 1 : 8
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.numcells = fread(my_file, 1, 'int32');
  a.magstrength = fread(my_file, 1, 'int32');
  a.patweight = fread(my_file, 1, 'int32');
  a.ex_datetime = fread(my_file, 1, 'int32');
  a.ex_lastmod = fread(my_file, 1, 'int32');
  for id = 1 : 12
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.ex_no = fread(my_file, 1, 'uint16');
  a.ex_uniq = fread(my_file, 1, 'int16');
  a.detect = fread(my_file, 1, 'int16');
  a.tubetyp = fread(my_file, 1, 'int16');
  a.dastyp = fread(my_file, 1, 'int16');
  a.num_dcnk = fread(my_file, 1, 'int16');
  a.dcn_len = fread(my_file, 1, 'int16');
  a.dcn_density = fread(my_file, 1, 'int16');
  a.dcn_stepsize = fread(my_file, 1, 'int16');
  a.dcn_shiftcnt = fread(my_file, 1, 'int16');
  a.patage = fread(my_file, 1, 'int16');
  a.patian = fread(my_file, 1, 'int16');
  a.patsex = fread(my_file, 1, 'int16');
  a.ex_format = fread(my_file, 1, 'int16');
  a.trauma = fread(my_file, 1, 'int16');
  a.protocolflag = fread(my_file, 1, 'int16');
  a.study_status = fread(my_file, 1, 'int16');
  for id = 1 : 11
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  a.hist = freadc(my_file, 61);
  a.reqnum = freadc(my_file, 13);
  a.refphy = freadc(my_file, 33);
  a.diagrad = freadc(my_file, 33);
  a.op = freadc(my_file, 4);
  a.ex_desc = freadc(my_file, 65);
  a.ex_typ = freadc(my_file, 3);
  a.ex_sysid = freadc(my_file, 9);
  a.ex_alloc_key = freadc(my_file, 13);
  a.ex_diskid = fread(my_file, 1, 'char');
  a.hospname = freadc(my_file, 33);
  a.patid = freadc(my_file, 13);
  a.patname = freadc(my_file, 25);
  for id = 1 : 4
    a.ex_suid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.uniq_sys_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.service_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.mobile_loc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.study_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patnameff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patidff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 17
    a.reqnumff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 9
    a.dateofbirth(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.mwlstudyuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.mwlstudyid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 62
    a.ex_padding(id) = fread(my_file, 1, 'char');
  end

  
end
% RDBM revision 20.002
if rdbm_rev == 20.002 
  a.firstaxtime = fread(my_file, 1, 'float64');
  for id = 1 : 9
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.zerocell = fread(my_file, 1, 'float32');
  a.cellspace = fread(my_file, 1, 'float32');
  a.srctodet = fread(my_file, 1, 'float32');
  a.srctoiso = fread(my_file, 1, 'float32');
  for id = 1 : 8
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.ex_delta_cnt = fread(my_file, 1, 'int32');
  a.ex_complete = fread(my_file, 1, 'int32');
  a.ex_seriesct = fread(my_file, 1, 'int32');
  a.ex_numarch = fread(my_file, 1, 'int32');
  a.ex_numseries = fread(my_file, 1, 'int32');
  a.ex_numunser = fread(my_file, 1, 'int32');
  a.ex_toarchcnt = fread(my_file, 1, 'int32');
  a.ex_prospcnt = fread(my_file, 1, 'int32');
  a.ex_modelnum = fread(my_file, 1, 'int32');
  a.ex_modelcnt = fread(my_file, 1, 'int32');
  a.ex_checksum = fread(my_file, 1, 'uint32');
  for id = 1 : 8
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.numcells = fread(my_file, 1, 'int32');
  a.magstrength = fread(my_file, 1, 'int32');
  a.patweight = fread(my_file, 1, 'int32');
  a.ex_datetime = fread(my_file, 1, 'int32');
  a.ex_lastmod = fread(my_file, 1, 'int32');
  for id = 1 : 12
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.ex_no = fread(my_file, 1, 'uint16');
  a.ex_uniq = fread(my_file, 1, 'int16');
  a.detect = fread(my_file, 1, 'int16');
  a.tubetyp = fread(my_file, 1, 'int16');
  a.dastyp = fread(my_file, 1, 'int16');
  a.num_dcnk = fread(my_file, 1, 'int16');
  a.dcn_len = fread(my_file, 1, 'int16');
  a.dcn_density = fread(my_file, 1, 'int16');
  a.dcn_stepsize = fread(my_file, 1, 'int16');
  a.dcn_shiftcnt = fread(my_file, 1, 'int16');
  a.patage = fread(my_file, 1, 'int16');
  a.patian = fread(my_file, 1, 'int16');
  a.patsex = fread(my_file, 1, 'int16');
  a.ex_format = fread(my_file, 1, 'int16');
  a.trauma = fread(my_file, 1, 'int16');
  a.protocolflag = fread(my_file, 1, 'int16');
  a.study_status = fread(my_file, 1, 'int16');
  for id = 1 : 11
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  a.hist = freadc(my_file, 61);
  a.reqnum = freadc(my_file, 13);
  a.refphy = freadc(my_file, 33);
  a.diagrad = freadc(my_file, 33);
  a.op = freadc(my_file, 4);
  a.ex_desc = freadc(my_file, 65);
  a.ex_typ = freadc(my_file, 3);
  a.ex_sysid = freadc(my_file, 9);
  a.ex_alloc_key = freadc(my_file, 13);
  a.ex_diskid = fread(my_file, 1, 'char');
  a.hospname = freadc(my_file, 33);
  a.patid = freadc(my_file, 13);
  a.patname = freadc(my_file, 25);
  for id = 1 : 4
    a.ex_suid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.uniq_sys_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.service_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.mobile_loc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.study_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patnameff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patidff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 17
    a.reqnumff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 9
    a.dateofbirth(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.mwlstudyuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.mwlstudyid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 62
    a.ex_padding(id) = fread(my_file, 1, 'char');
  end


end
% RDBM revision 20.003
if rdbm_rev == 20.003 
  a.firstaxtime = fread(my_file, 1, 'float64');
  for id = 1 : 9
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.zerocell = fread(my_file, 1, 'float32');
  a.cellspace = fread(my_file, 1, 'float32');
  a.srctodet = fread(my_file, 1, 'float32');
  a.srctoiso = fread(my_file, 1, 'float32');
  for id = 1 : 8
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.ex_delta_cnt = fread(my_file, 1, 'int32');
  a.ex_complete = fread(my_file, 1, 'int32');
  a.ex_seriesct = fread(my_file, 1, 'int32');
  a.ex_numarch = fread(my_file, 1, 'int32');
  a.ex_numseries = fread(my_file, 1, 'int32');
  a.ex_numunser = fread(my_file, 1, 'int32');
  a.ex_toarchcnt = fread(my_file, 1, 'int32');
  a.ex_prospcnt = fread(my_file, 1, 'int32');
  a.ex_modelnum = fread(my_file, 1, 'int32');
  a.ex_modelcnt = fread(my_file, 1, 'int32');
  a.ex_checksum = fread(my_file, 1, 'uint32');
  for id = 1 : 8
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.numcells = fread(my_file, 1, 'int32');
  a.magstrength = fread(my_file, 1, 'int32');
  a.patweight = fread(my_file, 1, 'int32');
  a.ex_datetime = fread(my_file, 1, 'int32');
  a.ex_lastmod = fread(my_file, 1, 'int32');
  for id = 1 : 12
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.ex_no = fread(my_file, 1, 'uint16');
  a.ex_uniq = fread(my_file, 1, 'int16');
  a.detect = fread(my_file, 1, 'int16');
  a.tubetyp = fread(my_file, 1, 'int16');
  a.dastyp = fread(my_file, 1, 'int16');
  a.num_dcnk = fread(my_file, 1, 'int16');
  a.dcn_len = fread(my_file, 1, 'int16');
  a.dcn_density = fread(my_file, 1, 'int16');
  a.dcn_stepsize = fread(my_file, 1, 'int16');
  a.dcn_shiftcnt = fread(my_file, 1, 'int16');
  a.patage = fread(my_file, 1, 'int16');
  a.patian = fread(my_file, 1, 'int16');
  a.patsex = fread(my_file, 1, 'int16');
  a.ex_format = fread(my_file, 1, 'int16');
  a.trauma = fread(my_file, 1, 'int16');
  a.protocolflag = fread(my_file, 1, 'int16');
  a.study_status = fread(my_file, 1, 'int16');
  for id = 1 : 11
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  a.hist = freadc(my_file, 61);
  a.reqnum = freadc(my_file, 13);
  a.refphy = freadc(my_file, 33);
  a.diagrad = freadc(my_file, 33);
  a.op = freadc(my_file, 4);
  a.ex_desc = freadc(my_file, 65);
  a.ex_typ = freadc(my_file, 3);
  a.ex_sysid = freadc(my_file, 9);
  a.ex_alloc_key = freadc(my_file, 13);
  a.ex_diskid = fread(my_file, 1, 'char');
  a.hospname = freadc(my_file, 33);
  a.patid = freadc(my_file, 13);
  a.patname = freadc(my_file, 25);
  for id = 1 : 4
    a.ex_suid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.uniq_sys_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.service_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.mobile_loc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.study_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patnameff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patidff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 17
    a.reqnumff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 9
    a.dateofbirth(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.mwlstudyuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.mwlstudyid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 62
    a.ex_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 20.004
if rdbm_rev == 20.004 
  a.firstaxtime = fread(my_file, 1, 'float64');
  for id = 1 : 9
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.zerocell = fread(my_file, 1, 'float32');
  a.cellspace = fread(my_file, 1, 'float32');
  a.srctodet = fread(my_file, 1, 'float32');
  a.srctoiso = fread(my_file, 1, 'float32');
  for id = 1 : 8
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.ex_delta_cnt = fread(my_file, 1, 'int32');
  a.ex_complete = fread(my_file, 1, 'int32');
  a.ex_seriesct = fread(my_file, 1, 'int32');
  a.ex_numarch = fread(my_file, 1, 'int32');
  a.ex_numseries = fread(my_file, 1, 'int32');
  a.ex_numunser = fread(my_file, 1, 'int32');
  a.ex_toarchcnt = fread(my_file, 1, 'int32');
  a.ex_prospcnt = fread(my_file, 1, 'int32');
  a.ex_modelnum = fread(my_file, 1, 'int32');
  a.ex_modelcnt = fread(my_file, 1, 'int32');
  a.ex_checksum = fread(my_file, 1, 'uint32');
  for id = 1 : 8
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.numcells = fread(my_file, 1, 'int32');
  a.magstrength = fread(my_file, 1, 'int32');
  a.patweight = fread(my_file, 1, 'int32');
  a.ex_datetime = fread(my_file, 1, 'int32');
  a.ex_lastmod = fread(my_file, 1, 'int32');
  for id = 1 : 12
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.ex_no = fread(my_file, 1, 'uint16');
  a.ex_uniq = fread(my_file, 1, 'int16');
  a.detect = fread(my_file, 1, 'int16');
  a.tubetyp = fread(my_file, 1, 'int16');
  a.dastyp = fread(my_file, 1, 'int16');
  a.num_dcnk = fread(my_file, 1, 'int16');
  a.dcn_len = fread(my_file, 1, 'int16');
  a.dcn_density = fread(my_file, 1, 'int16');
  a.dcn_stepsize = fread(my_file, 1, 'int16');
  a.dcn_shiftcnt = fread(my_file, 1, 'int16');
  a.patage = fread(my_file, 1, 'int16');
  a.patian = fread(my_file, 1, 'int16');
  a.patsex = fread(my_file, 1, 'int16');
  a.ex_format = fread(my_file, 1, 'int16');
  a.trauma = fread(my_file, 1, 'int16');
  a.protocolflag = fread(my_file, 1, 'int16');
  a.study_status = fread(my_file, 1, 'int16');
  for id = 1 : 11
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  a.hist = freadc(my_file, 61);
  a.reqnum = freadc(my_file, 13);
  a.refphy = freadc(my_file, 33);
  a.diagrad = freadc(my_file, 33);
  a.op = freadc(my_file, 4);
  a.ex_desc = freadc(my_file, 65);
  a.ex_typ = freadc(my_file, 3);
  a.ex_sysid = freadc(my_file, 9);
  a.ex_alloc_key = freadc(my_file, 13);
  a.ex_diskid = fread(my_file, 1, 'char');
  a.hospname = freadc(my_file, 33);
  a.patid = freadc(my_file, 13);
  a.patname = freadc(my_file, 25);
  for id = 1 : 4
    a.ex_suid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.uniq_sys_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.service_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.mobile_loc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.study_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patnameff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patidff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 17
    a.reqnumff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 9
    a.dateofbirth(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.mwlstudyuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.mwlstudyid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 62
    a.ex_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 20.005
if rdbm_rev == 20.005 
  a.firstaxtime = fread(my_file, 1, 'float64');
  for id = 1 : 31
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.zerocell = fread(my_file, 1, 'float32');
  a.cellspace = fread(my_file, 1, 'float32');
  a.srctodet = fread(my_file, 1, 'float32');
  a.srctoiso = fread(my_file, 1, 'float32');
  for id = 1 : 32
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.ex_delta_cnt = fread(my_file, 1, 'int32');
  a.ex_complete = fread(my_file, 1, 'int32');
  a.ex_seriesct = fread(my_file, 1, 'int32');
  a.ex_numarch = fread(my_file, 1, 'int32');
  a.ex_numseries = fread(my_file, 1, 'int32');
  a.ex_numunser = fread(my_file, 1, 'int32');
  a.ex_toarchcnt = fread(my_file, 1, 'int32');
  a.ex_prospcnt = fread(my_file, 1, 'int32');
  a.ex_modelnum = fread(my_file, 1, 'int32');
  a.ex_modelcnt = fread(my_file, 1, 'int32');
  for id = 1 : 32
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.numcells = fread(my_file, 1, 'int32');
  a.magstrength = fread(my_file, 1, 'int32');
  a.patweight = fread(my_file, 1, 'int32');
  a.ex_datetime = fread(my_file, 1, 'int32');
  a.ex_lastmod = fread(my_file, 1, 'int32');
  for id = 1 : 27
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.ex_no = fread(my_file, 1, 'uint16');
  a.ex_uniq = fread(my_file, 1, 'int16');
  a.detect = fread(my_file, 1, 'int16');
  a.tubetyp = fread(my_file, 1, 'int16');
  a.dastyp = fread(my_file, 1, 'int16');
  a.num_dcnk = fread(my_file, 1, 'int16');
  a.dcn_len = fread(my_file, 1, 'int16');
  a.dcn_density = fread(my_file, 1, 'int16');
  a.dcn_stepsize = fread(my_file, 1, 'int16');
  a.dcn_shiftcnt = fread(my_file, 1, 'int16');
  a.patage = fread(my_file, 1, 'int16');
  a.patian = fread(my_file, 1, 'int16');
  a.patsex = fread(my_file, 1, 'int16');
  a.ex_format = fread(my_file, 1, 'int16');
  a.trauma = fread(my_file, 1, 'int16');
  a.protocolflag = fread(my_file, 1, 'int16');
  a.study_status = fread(my_file, 1, 'int16');
  for id = 1 : 35
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  a.hist = freadc(my_file, 257);
  a.refphy = freadc(my_file, 65);
  a.diagrad = freadc(my_file, 65);
  a.operator_new = freadc(my_file, 65);
  a.ex_desc = freadc(my_file, 65);
  a.ex_typ = freadc(my_file, 3);
  a.ex_sysid = freadc(my_file, 9);
  a.ex_alloc_key = freadc(my_file, 13);
  a.ex_diskid = fread(my_file, 1, 'char');
  a.hospname = freadc(my_file, 33);
  for id = 1 : 4
    a.ex_suid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.uniq_sys_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.service_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.mobile_loc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.study_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patnameff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patidff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 17
    a.reqnumff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 9
    a.dateofbirth(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.mwlstudyuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.mwlstudyid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 240
    a.ex_padding(id) = fread(my_file, 1, 'char');
  end


end
% RDBM revision 20.006
if rdbm_rev == 20.006 
  a.firstaxtime = fread(my_file, 1, 'float64');
  for id = 1 : 31
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.zerocell = fread(my_file, 1, 'float32');
  a.cellspace = fread(my_file, 1, 'float32');
  a.srctodet = fread(my_file, 1, 'float32');
  a.srctoiso = fread(my_file, 1, 'float32');
  for id = 1 : 32
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.ex_delta_cnt = fread(my_file, 1, 'int32');
  a.ex_complete = fread(my_file, 1, 'int32');
  a.ex_seriesct = fread(my_file, 1, 'int32');
  a.ex_numarch = fread(my_file, 1, 'int32');
  a.ex_numseries = fread(my_file, 1, 'int32');
  a.ex_numunser = fread(my_file, 1, 'int32');
  a.ex_toarchcnt = fread(my_file, 1, 'int32');
  a.ex_prospcnt = fread(my_file, 1, 'int32');
  a.ex_modelnum = fread(my_file, 1, 'int32');
  a.ex_modelcnt = fread(my_file, 1, 'int32');
  a.patCheckSum = fread(my_file, 1, 'int32');
  for id = 1 : 31
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.numcells = fread(my_file, 1, 'int32');
  a.magstrength = fread(my_file, 1, 'int32');
  a.patweight = fread(my_file, 1, 'int32');
  a.ex_datetime = fread(my_file, 1, 'int32');
  a.ex_lastmod = fread(my_file, 1, 'int32');
  a.patChecksumType = fread(my_file, 1, 'int32');
  for id = 1 : 26
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.ex_no = fread(my_file, 1, 'uint16');
  a.ex_uniq = fread(my_file, 1, 'int16');
  a.detect = fread(my_file, 1, 'int16');
  a.tubetyp = fread(my_file, 1, 'int16');
  a.dastyp = fread(my_file, 1, 'int16');
  a.num_dcnk = fread(my_file, 1, 'int16');
  a.dcn_len = fread(my_file, 1, 'int16');
  a.dcn_density = fread(my_file, 1, 'int16');
  a.dcn_stepsize = fread(my_file, 1, 'int16');
  a.dcn_shiftcnt = fread(my_file, 1, 'int16');
  a.patage = fread(my_file, 1, 'int16');
  a.patian = fread(my_file, 1, 'int16');
  a.patsex = fread(my_file, 1, 'int16');
  a.ex_format = fread(my_file, 1, 'int16');
  a.trauma = fread(my_file, 1, 'int16');
  a.protocolflag = fread(my_file, 1, 'int16');
  a.study_status = fread(my_file, 1, 'int16');
  for id = 1 : 35
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  a.hist = freadc(my_file, 257);
  a.refphy = freadc(my_file, 65);
  a.diagrad = freadc(my_file, 65);
  a.operator_new = freadc(my_file, 65);
  a.ex_desc = freadc(my_file, 65);
  a.ex_typ = freadc(my_file, 3);
  a.ex_sysid = freadc(my_file, 9);
  a.ex_alloc_key = freadc(my_file, 13);
  a.ex_diskid = fread(my_file, 1, 'char');
  a.hospname = freadc(my_file, 33);
  for id = 1 : 4
    a.ex_suid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.uniq_sys_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.service_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.mobile_loc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.study_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patnameff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patidff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 17
    a.reqnumff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 9
    a.dateofbirth(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.mwlstudyuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.mwlstudyid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 240
    a.ex_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 20.007
if rdbm_rev == 20.007 
  a.firstaxtime = fread(my_file, 1, 'float64');
  for id = 1 : 31
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.zerocell = fread(my_file, 1, 'float32');
  a.cellspace = fread(my_file, 1, 'float32');
  a.srctodet = fread(my_file, 1, 'float32');
  a.srctoiso = fread(my_file, 1, 'float32');
  for id = 1 : 32
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.ex_delta_cnt = fread(my_file, 1, 'int32');
  a.ex_complete = fread(my_file, 1, 'int32');
  a.ex_seriesct = fread(my_file, 1, 'int32');
  a.ex_numarch = fread(my_file, 1, 'int32');
  a.ex_numseries = fread(my_file, 1, 'int32');
  a.ex_numunser = fread(my_file, 1, 'int32');
  a.ex_toarchcnt = fread(my_file, 1, 'int32');
  a.ex_prospcnt = fread(my_file, 1, 'int32');
  a.ex_modelnum = fread(my_file, 1, 'int32');
  a.ex_modelcnt = fread(my_file, 1, 'int32');
  a.patCheckSum = fread(my_file, 1, 'int32');
  for id = 1 : 31
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.numcells = fread(my_file, 1, 'int32');
  a.magstrength = fread(my_file, 1, 'int32');
  a.patweight = fread(my_file, 1, 'int32');
  a.ex_datetime = fread(my_file, 1, 'int32');
  a.ex_lastmod = fread(my_file, 1, 'int32');
  a.patChecksumType = fread(my_file, 1, 'int32');
  for id = 1 : 26
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.ex_no = fread(my_file, 1, 'uint16');
  a.ex_uniq = fread(my_file, 1, 'int16');
  a.detect = fread(my_file, 1, 'int16');
  a.tubetyp = fread(my_file, 1, 'int16');
  a.dastyp = fread(my_file, 1, 'int16');
  a.num_dcnk = fread(my_file, 1, 'int16');
  a.dcn_len = fread(my_file, 1, 'int16');
  a.dcn_density = fread(my_file, 1, 'int16');
  a.dcn_stepsize = fread(my_file, 1, 'int16');
  a.dcn_shiftcnt = fread(my_file, 1, 'int16');
  a.patage = fread(my_file, 1, 'int16');
  a.patian = fread(my_file, 1, 'int16');
  a.patsex = fread(my_file, 1, 'int16');
  a.ex_format = fread(my_file, 1, 'int16');
  a.trauma = fread(my_file, 1, 'int16');
  a.protocolflag = fread(my_file, 1, 'int16');
  a.study_status = fread(my_file, 1, 'int16');
  for id = 1 : 35
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  a.hist = freadc(my_file, 257);
  a.refphy = freadc(my_file, 65);
  a.diagrad = freadc(my_file, 65);
  a.operator_new = freadc(my_file, 65);
  a.ex_desc = freadc(my_file, 65);
  a.ex_typ = freadc(my_file, 3);
  a.ex_sysid = freadc(my_file, 17);
  a.ex_alloc_key = freadc(my_file, 13);
  a.ex_diskid = fread(my_file, 1, 'char');
  a.hospname = freadc(my_file, 33);
  for id = 1 : 4
    a.ex_suid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.uniq_sys_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.service_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.mobile_loc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.study_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patnameff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patidff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 17
    a.reqnumff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 9
    a.dateofbirth(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.mwlstudyuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.mwlstudyid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 232
    a.ex_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 24.000
if rdbm_rev == 24.000 
  a.firstaxtime = fread(my_file, 1, 'float64');
  for id = 1 : 31
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.zerocell = fread(my_file, 1, 'float32');
  a.cellspace = fread(my_file, 1, 'float32');
  a.srctodet = fread(my_file, 1, 'float32');
  a.srctoiso = fread(my_file, 1, 'float32');
  for id = 1 : 32
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.ex_delta_cnt = fread(my_file, 1, 'int32');
  a.ex_complete = fread(my_file, 1, 'int32');
  a.ex_seriesct = fread(my_file, 1, 'int32');
  a.ex_numarch = fread(my_file, 1, 'int32');
  a.ex_numseries = fread(my_file, 1, 'int32');
  a.ex_numunser = fread(my_file, 1, 'int32');
  a.ex_toarchcnt = fread(my_file, 1, 'int32');
  a.ex_prospcnt = fread(my_file, 1, 'int32');
  a.ex_modelnum = fread(my_file, 1, 'int32');
  a.ex_modelcnt = fread(my_file, 1, 'int32');
  a.patCheckSum = fread(my_file, 1, 'int32');
  for id = 1 : 31
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.numcells = fread(my_file, 1, 'int32');
  a.magstrength = fread(my_file, 1, 'int32');
  a.patweight = fread(my_file, 1, 'int32');
  a.ex_datetime = fread(my_file, 1, 'int32');
  a.ex_lastmod = fread(my_file, 1, 'int32');
  a.patChecksumType = fread(my_file, 1, 'int32');
  for id = 1 : 26
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.ex_no = fread(my_file, 1, 'uint16');
  a.ex_uniq = fread(my_file, 1, 'int16');
  a.detect = fread(my_file, 1, 'int16');
  a.tubetyp = fread(my_file, 1, 'int16');
  a.dastyp = fread(my_file, 1, 'int16');
  a.num_dcnk = fread(my_file, 1, 'int16');
  a.dcn_len = fread(my_file, 1, 'int16');
  a.dcn_density = fread(my_file, 1, 'int16');
  a.dcn_stepsize = fread(my_file, 1, 'int16');
  a.dcn_shiftcnt = fread(my_file, 1, 'int16');
  a.patage = fread(my_file, 1, 'int16');
  a.patian = fread(my_file, 1, 'int16');
  a.patsex = fread(my_file, 1, 'int16');
  a.ex_format = fread(my_file, 1, 'int16');
  a.trauma = fread(my_file, 1, 'int16');
  a.protocolflag = fread(my_file, 1, 'int16');
  a.study_status = fread(my_file, 1, 'int16');
  for id = 1 : 35
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  a.hist = freadc(my_file, 257);
  a.refphy = freadc(my_file, 65);
  a.diagrad = freadc(my_file, 65);
  a.operator_new = freadc(my_file, 65);
  a.ex_desc = freadc(my_file, 65);
  a.ex_typ = freadc(my_file, 3);
  a.ex_sysid = freadc(my_file, 17);
  a.ex_alloc_key = freadc(my_file, 13);
  a.ex_diskid = fread(my_file, 1, 'char');
  a.hospname = freadc(my_file, 33);
  for id = 1 : 4
    a.ex_suid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.uniq_sys_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.service_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.mobile_loc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.study_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patnameff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patidff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 17
    a.reqnumff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 9
    a.dateofbirth(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.mwlstudyuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.mwlstudyid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 232
    a.ex_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 25.001
if rdbm_rev == 25.001 
  a.firstaxtime = fread(my_file, 1, 'float64');
  for id = 1 : 31
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.zerocell = fread(my_file, 1, 'float32');
  a.cellspace = fread(my_file, 1, 'float32');
  a.srctodet = fread(my_file, 1, 'float32');
  a.srctoiso = fread(my_file, 1, 'float32');
  for id = 1 : 32
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.ex_delta_cnt = fread(my_file, 1, 'int32');
  a.ex_complete = fread(my_file, 1, 'int32');
  a.ex_seriesct = fread(my_file, 1, 'int32');
  a.ex_numarch = fread(my_file, 1, 'int32');
  a.ex_numseries = fread(my_file, 1, 'int32');
  a.ex_numunser = fread(my_file, 1, 'int32');
  a.ex_toarchcnt = fread(my_file, 1, 'int32');
  a.ex_prospcnt = fread(my_file, 1, 'int32');
  a.ex_modelnum = fread(my_file, 1, 'int32');
  a.ex_modelcnt = fread(my_file, 1, 'int32');
  a.patCheckSum = fread(my_file, 1, 'int32');
  for id = 1 : 31
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.numcells = fread(my_file, 1, 'int32');
  a.magstrength = fread(my_file, 1, 'int32');
  a.patweight = fread(my_file, 1, 'int32');
  a.ex_datetime = fread(my_file, 1, 'int32');
  a.ex_lastmod = fread(my_file, 1, 'int32');
  a.patChecksumType = fread(my_file, 1, 'int32');
  for id = 1 : 26
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.ex_no = fread(my_file, 1, 'uint16');
  a.ex_uniq = fread(my_file, 1, 'int16');
  a.detect = fread(my_file, 1, 'int16');
  a.tubetyp = fread(my_file, 1, 'int16');
  a.dastyp = fread(my_file, 1, 'int16');
  a.num_dcnk = fread(my_file, 1, 'int16');
  a.dcn_len = fread(my_file, 1, 'int16');
  a.dcn_density = fread(my_file, 1, 'int16');
  a.dcn_stepsize = fread(my_file, 1, 'int16');
  a.dcn_shiftcnt = fread(my_file, 1, 'int16');
  a.patage = fread(my_file, 1, 'int16');
  a.patian = fread(my_file, 1, 'int16');
  a.patsex = fread(my_file, 1, 'int16');
  a.ex_format = fread(my_file, 1, 'int16');
  a.trauma = fread(my_file, 1, 'int16');
  a.protocolflag = fread(my_file, 1, 'int16');
  a.study_status = fread(my_file, 1, 'int16');
  for id = 1 : 35
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  a.hist = freadc(my_file, 257);
  a.refphy = freadc(my_file, 65);
  a.diagrad = freadc(my_file, 65);
  a.operator_new = freadc(my_file, 65);
  a.ex_desc = freadc(my_file, 65);
  a.ex_typ = freadc(my_file, 3);
  a.ex_sysid = freadc(my_file, 17);
  a.ex_alloc_key = freadc(my_file, 13);
  a.ex_diskid = fread(my_file, 1, 'char');
  a.hospname = freadc(my_file, 33);
  for id = 1 : 4
    a.ex_suid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.uniq_sys_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.service_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.mobile_loc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.study_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patnameff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patidff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 17
    a.reqnumff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 9
    a.dateofbirth(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.mwlstudyuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.mwlstudyid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 232
    a.ex_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 25.002
if rdbm_rev == 25.002 
  a.firstaxtime = fread(my_file, 1, 'float64');
  for id = 1 : 31
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.zerocell = fread(my_file, 1, 'float32');
  a.cellspace = fread(my_file, 1, 'float32');
  a.srctodet = fread(my_file, 1, 'float32');
  a.srctoiso = fread(my_file, 1, 'float32');
  for id = 1 : 32
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.ex_delta_cnt = fread(my_file, 1, 'int32');
  a.ex_complete = fread(my_file, 1, 'int32');
  a.ex_seriesct = fread(my_file, 1, 'int32');
  a.ex_numarch = fread(my_file, 1, 'int32');
  a.ex_numseries = fread(my_file, 1, 'int32');
  a.ex_numunser = fread(my_file, 1, 'int32');
  a.ex_toarchcnt = fread(my_file, 1, 'int32');
  a.ex_prospcnt = fread(my_file, 1, 'int32');
  a.ex_modelnum = fread(my_file, 1, 'int32');
  a.ex_modelcnt = fread(my_file, 1, 'int32');
  a.patCheckSum = fread(my_file, 1, 'int32');
  for id = 1 : 31
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.numcells = fread(my_file, 1, 'int32');
  a.magstrength = fread(my_file, 1, 'int32');
  a.patweight = fread(my_file, 1, 'int32');
  a.ex_datetime = fread(my_file, 1, 'int32');
  a.ex_lastmod = fread(my_file, 1, 'int32');
  a.patChecksumType = fread(my_file, 1, 'int32');
  for id = 1 : 26
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.ex_no = fread(my_file, 1, 'uint16');
  a.ex_uniq = fread(my_file, 1, 'int16');
  a.detect = fread(my_file, 1, 'int16');
  a.tubetyp = fread(my_file, 1, 'int16');
  a.dastyp = fread(my_file, 1, 'int16');
  a.num_dcnk = fread(my_file, 1, 'int16');
  a.dcn_len = fread(my_file, 1, 'int16');
  a.dcn_density = fread(my_file, 1, 'int16');
  a.dcn_stepsize = fread(my_file, 1, 'int16');
  a.dcn_shiftcnt = fread(my_file, 1, 'int16');
  a.patage = fread(my_file, 1, 'int16');
  a.patian = fread(my_file, 1, 'int16');
  a.patsex = fread(my_file, 1, 'int16');
  a.ex_format = fread(my_file, 1, 'int16');
  a.trauma = fread(my_file, 1, 'int16');
  a.protocolflag = fread(my_file, 1, 'int16');
  a.study_status = fread(my_file, 1, 'int16');
  for id = 1 : 35
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  a.hist = freadc(my_file, 257);
  a.refphy = freadc(my_file, 65);
  a.diagrad = freadc(my_file, 65);
  a.operator_new = freadc(my_file, 65);
  a.ex_desc = freadc(my_file, 65);
  a.ex_typ = freadc(my_file, 3);
  a.ex_sysid = freadc(my_file, 17);
  a.ex_alloc_key = freadc(my_file, 13);
  a.ex_diskid = fread(my_file, 1, 'char');
  a.hospname = freadc(my_file, 33);
  for id = 1 : 4
    a.ex_suid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.uniq_sys_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.service_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.mobile_loc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.study_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patnameff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patidff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 17
    a.reqnumff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 9
    a.dateofbirth(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.mwlstudyuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.mwlstudyid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 232
    a.ex_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 25.003
if rdbm_rev == 25.003 
  a.firstaxtime = fread(my_file, 1, 'float64');
  for id = 1 : 31
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.zerocell = fread(my_file, 1, 'float32');
  a.cellspace = fread(my_file, 1, 'float32');
  a.srctodet = fread(my_file, 1, 'float32');
  a.srctoiso = fread(my_file, 1, 'float32');
  for id = 1 : 32
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.ex_delta_cnt = fread(my_file, 1, 'int32');
  a.ex_complete = fread(my_file, 1, 'int32');
  a.ex_seriesct = fread(my_file, 1, 'int32');
  a.ex_numarch = fread(my_file, 1, 'int32');
  a.ex_numseries = fread(my_file, 1, 'int32');
  a.ex_numunser = fread(my_file, 1, 'int32');
  a.ex_toarchcnt = fread(my_file, 1, 'int32');
  a.ex_prospcnt = fread(my_file, 1, 'int32');
  a.ex_modelnum = fread(my_file, 1, 'int32');
  a.ex_modelcnt = fread(my_file, 1, 'int32');
  a.patCheckSum = fread(my_file, 1, 'int32');
  for id = 1 : 31
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.numcells = fread(my_file, 1, 'int32');
  a.magstrength = fread(my_file, 1, 'int32');
  a.patweight = fread(my_file, 1, 'int32');
  a.ex_datetime = fread(my_file, 1, 'int32');
  a.ex_lastmod = fread(my_file, 1, 'int32');
  a.patChecksumType = fread(my_file, 1, 'int32');
  for id = 1 : 26
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.ex_no = fread(my_file, 1, 'uint16');
  a.ex_uniq = fread(my_file, 1, 'int16');
  a.detect = fread(my_file, 1, 'int16');
  a.tubetyp = fread(my_file, 1, 'int16');
  a.dastyp = fread(my_file, 1, 'int16');
  a.num_dcnk = fread(my_file, 1, 'int16');
  a.dcn_len = fread(my_file, 1, 'int16');
  a.dcn_density = fread(my_file, 1, 'int16');
  a.dcn_stepsize = fread(my_file, 1, 'int16');
  a.dcn_shiftcnt = fread(my_file, 1, 'int16');
  a.patage = fread(my_file, 1, 'int16');
  a.patian = fread(my_file, 1, 'int16');
  a.patsex = fread(my_file, 1, 'int16');
  a.ex_format = fread(my_file, 1, 'int16');
  a.trauma = fread(my_file, 1, 'int16');
  a.protocolflag = fread(my_file, 1, 'int16');
  a.study_status = fread(my_file, 1, 'int16');
  for id = 1 : 35
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  a.hist = freadc(my_file, 257);
  a.refphy = freadc(my_file, 65);
  a.diagrad = freadc(my_file, 65);
  a.operator_new = freadc(my_file, 65);
  a.ex_desc = freadc(my_file, 65);
  a.ex_typ = freadc(my_file, 3);
  a.ex_sysid = freadc(my_file, 17);
  a.ex_alloc_key = freadc(my_file, 13);
  a.ex_diskid = fread(my_file, 1, 'char');
  a.hospname = freadc(my_file, 33);
  for id = 1 : 4
    a.ex_suid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.uniq_sys_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.service_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.mobile_loc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.study_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patnameff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patidff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 17
    a.reqnumff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 9
    a.dateofbirth(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.mwlstudyuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.mwlstudyid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 232
    a.ex_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 25.004
if rdbm_rev == 25.004 
  a.firstaxtime = fread(my_file, 1, 'float64');
  for id = 1 : 31
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.zerocell = fread(my_file, 1, 'float32');
  a.cellspace = fread(my_file, 1, 'float32');
  a.srctodet = fread(my_file, 1, 'float32');
  a.srctoiso = fread(my_file, 1, 'float32');
  for id = 1 : 32
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.ex_delta_cnt = fread(my_file, 1, 'int32');
  a.ex_complete = fread(my_file, 1, 'int32');
  a.ex_seriesct = fread(my_file, 1, 'int32');
  a.ex_numarch = fread(my_file, 1, 'int32');
  a.ex_numseries = fread(my_file, 1, 'int32');
  a.ex_numunser = fread(my_file, 1, 'int32');
  a.ex_toarchcnt = fread(my_file, 1, 'int32');
  a.ex_prospcnt = fread(my_file, 1, 'int32');
  a.ex_modelnum = fread(my_file, 1, 'int32');
  a.ex_modelcnt = fread(my_file, 1, 'int32');
  a.patCheckSum = fread(my_file, 1, 'int32');
  for id = 1 : 31
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.numcells = fread(my_file, 1, 'int32');
  a.magstrength = fread(my_file, 1, 'int32');
  a.patweight = fread(my_file, 1, 'int32');
  a.ex_datetime = fread(my_file, 1, 'int32');
  a.ex_lastmod = fread(my_file, 1, 'int32');
  a.patChecksumType = fread(my_file, 1, 'int32');
  for id = 1 : 26
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.ex_no = fread(my_file, 1, 'uint16');
  a.ex_uniq = fread(my_file, 1, 'int16');
  a.detect = fread(my_file, 1, 'int16');
  a.tubetyp = fread(my_file, 1, 'int16');
  a.dastyp = fread(my_file, 1, 'int16');
  a.num_dcnk = fread(my_file, 1, 'int16');
  a.dcn_len = fread(my_file, 1, 'int16');
  a.dcn_density = fread(my_file, 1, 'int16');
  a.dcn_stepsize = fread(my_file, 1, 'int16');
  a.dcn_shiftcnt = fread(my_file, 1, 'int16');
  a.patage = fread(my_file, 1, 'int16');
  a.patian = fread(my_file, 1, 'int16');
  a.patsex = fread(my_file, 1, 'int16');
  a.ex_format = fread(my_file, 1, 'int16');
  a.trauma = fread(my_file, 1, 'int16');
  a.protocolflag = fread(my_file, 1, 'int16');
  a.study_status = fread(my_file, 1, 'int16');
  for id = 1 : 35
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  a.hist = freadc(my_file, 257);
  a.refphy = freadc(my_file, 65);
  a.diagrad = freadc(my_file, 65);
  a.operator_new = freadc(my_file, 65);
  a.ex_desc = freadc(my_file, 65);
  a.ex_typ = freadc(my_file, 3);
  a.ex_sysid = freadc(my_file, 17);
  a.ex_alloc_key = freadc(my_file, 13);
  a.ex_diskid = fread(my_file, 1, 'char');
  a.hospname = freadc(my_file, 33);
  for id = 1 : 4
    a.ex_suid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.uniq_sys_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.service_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.mobile_loc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.study_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patnameff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patidff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 17
    a.reqnumff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 9
    a.dateofbirth(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.mwlstudyuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.mwlstudyid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 232
    a.ex_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 26.000
if rdbm_rev == 26.000 
  a.firstaxtime = fread(my_file, 1, 'float64');
  for id = 1 : 31
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.zerocell = fread(my_file, 1, 'float32');
  a.cellspace = fread(my_file, 1, 'float32');
  a.srctodet = fread(my_file, 1, 'float32');
  a.srctoiso = fread(my_file, 1, 'float32');
  for id = 1 : 32
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.ex_delta_cnt = fread(my_file, 1, 'int32');
  a.ex_complete = fread(my_file, 1, 'int32');
  a.ex_seriesct = fread(my_file, 1, 'int32');
  a.ex_numarch = fread(my_file, 1, 'int32');
  a.ex_numseries = fread(my_file, 1, 'int32');
  a.ex_numunser = fread(my_file, 1, 'int32');
  a.ex_toarchcnt = fread(my_file, 1, 'int32');
  a.ex_prospcnt = fread(my_file, 1, 'int32');
  a.ex_modelnum = fread(my_file, 1, 'int32');
  a.ex_modelcnt = fread(my_file, 1, 'int32');
  a.patCheckSum = fread(my_file, 1, 'int32');
  for id = 1 : 31
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.numcells = fread(my_file, 1, 'int32');
  a.magstrength = fread(my_file, 1, 'int32');
  a.patweight = fread(my_file, 1, 'int32');
  a.ex_datetime = fread(my_file, 1, 'int32');
  a.ex_lastmod = fread(my_file, 1, 'int32');
  a.patChecksumType = fread(my_file, 1, 'int32');
  for id = 1 : 26
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.ex_no = fread(my_file, 1, 'uint16');
  a.ex_uniq = fread(my_file, 1, 'int16');
  a.detect = fread(my_file, 1, 'int16');
  a.tubetyp = fread(my_file, 1, 'int16');
  a.dastyp = fread(my_file, 1, 'int16');
  a.num_dcnk = fread(my_file, 1, 'int16');
  a.dcn_len = fread(my_file, 1, 'int16');
  a.dcn_density = fread(my_file, 1, 'int16');
  a.dcn_stepsize = fread(my_file, 1, 'int16');
  a.dcn_shiftcnt = fread(my_file, 1, 'int16');
  a.patage = fread(my_file, 1, 'int16');
  a.patian = fread(my_file, 1, 'int16');
  a.patsex = fread(my_file, 1, 'int16');
  a.ex_format = fread(my_file, 1, 'int16');
  a.trauma = fread(my_file, 1, 'int16');
  a.protocolflag = fread(my_file, 1, 'int16');
  a.study_status = fread(my_file, 1, 'int16');
  for id = 1 : 35
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  a.hist = freadc(my_file, 257);
  a.refphy = freadc(my_file, 65);
  a.diagrad = freadc(my_file, 65);
  a.operator_new = freadc(my_file, 65);
  a.ex_desc = freadc(my_file, 65);
  a.ex_typ = freadc(my_file, 3);
  a.ex_sysid = freadc(my_file, 17);
  a.ex_alloc_key = freadc(my_file, 13);
  a.ex_diskid = fread(my_file, 1, 'char');
  a.hospname = freadc(my_file, 33);
  for id = 1 : 4
    a.ex_suid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.uniq_sys_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.service_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.mobile_loc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.study_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patnameff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patidff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 17
    a.reqnumff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 9
    a.dateofbirth(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.mwlstudyuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.mwlstudyid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 232
    a.ex_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 26.001
if rdbm_rev == 26.001 
  a.firstaxtime = fread(my_file, 1, 'float64');
  for id = 1 : 31
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.zerocell = fread(my_file, 1, 'float32');
  a.cellspace = fread(my_file, 1, 'float32');
  a.srctodet = fread(my_file, 1, 'float32');
  a.srctoiso = fread(my_file, 1, 'float32');
  for id = 1 : 32
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.ex_delta_cnt = fread(my_file, 1, 'int32');
  a.ex_complete = fread(my_file, 1, 'int32');
  a.ex_seriesct = fread(my_file, 1, 'int32');
  a.ex_numarch = fread(my_file, 1, 'int32');
  a.ex_numseries = fread(my_file, 1, 'int32');
  a.ex_numunser = fread(my_file, 1, 'int32');
  a.ex_toarchcnt = fread(my_file, 1, 'int32');
  a.ex_prospcnt = fread(my_file, 1, 'int32');
  a.ex_modelnum = fread(my_file, 1, 'int32');
  a.ex_modelcnt = fread(my_file, 1, 'int32');
  a.patCheckSum = fread(my_file, 1, 'int32');
  for id = 1 : 31
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.numcells = fread(my_file, 1, 'int32');
  a.magstrength = fread(my_file, 1, 'int32');
  a.patweight = fread(my_file, 1, 'int32');
  a.ex_datetime = fread(my_file, 1, 'int32');
  a.ex_lastmod = fread(my_file, 1, 'int32');
  a.patChecksumType = fread(my_file, 1, 'int32');
  for id = 1 : 26
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.ex_no = fread(my_file, 1, 'uint16');
  a.ex_uniq = fread(my_file, 1, 'int16');
  a.detect = fread(my_file, 1, 'int16');
  a.tubetyp = fread(my_file, 1, 'int16');
  a.dastyp = fread(my_file, 1, 'int16');
  a.num_dcnk = fread(my_file, 1, 'int16');
  a.dcn_len = fread(my_file, 1, 'int16');
  a.dcn_density = fread(my_file, 1, 'int16');
  a.dcn_stepsize = fread(my_file, 1, 'int16');
  a.dcn_shiftcnt = fread(my_file, 1, 'int16');
  a.patage = fread(my_file, 1, 'int16');
  a.patian = fread(my_file, 1, 'int16');
  a.patsex = fread(my_file, 1, 'int16');
  a.ex_format = fread(my_file, 1, 'int16');
  a.trauma = fread(my_file, 1, 'int16');
  a.protocolflag = fread(my_file, 1, 'int16');
  a.study_status = fread(my_file, 1, 'int16');
  for id = 1 : 35
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  a.hist = freadc(my_file, 257);
  a.refphy = freadc(my_file, 65);
  a.diagrad = freadc(my_file, 65);
  a.operator_new = freadc(my_file, 65);
  a.ex_desc = freadc(my_file, 65);
  a.ex_typ = freadc(my_file, 3);
  a.ex_sysid = freadc(my_file, 17);
  a.ex_alloc_key = freadc(my_file, 13);
  a.ex_diskid = fread(my_file, 1, 'char');
  a.hospname = freadc(my_file, 33);
  for id = 1 : 4
    a.ex_suid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.uniq_sys_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.service_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.mobile_loc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.study_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patnameff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patidff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 17
    a.reqnumff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 9
    a.dateofbirth(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.mwlstudyuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.mwlstudyid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 232
    a.ex_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 26.002
if rdbm_rev == 26.002 
  a.firstaxtime = fread(my_file, 1, 'float64');
  for id = 1 : 31
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.zerocell = fread(my_file, 1, 'float32');
  a.cellspace = fread(my_file, 1, 'float32');
  a.srctodet = fread(my_file, 1, 'float32');
  a.srctoiso = fread(my_file, 1, 'float32');
  for id = 1 : 32
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.ex_delta_cnt = fread(my_file, 1, 'int32');
  a.ex_complete = fread(my_file, 1, 'int32');
  a.ex_seriesct = fread(my_file, 1, 'int32');
  a.ex_numarch = fread(my_file, 1, 'int32');
  a.ex_numseries = fread(my_file, 1, 'int32');
  a.ex_numunser = fread(my_file, 1, 'int32');
  a.ex_toarchcnt = fread(my_file, 1, 'int32');
  a.ex_prospcnt = fread(my_file, 1, 'int32');
  a.ex_modelnum = fread(my_file, 1, 'int32');
  a.ex_modelcnt = fread(my_file, 1, 'int32');
  a.patCheckSum = fread(my_file, 1, 'int32');
  for id = 1 : 31
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.numcells = fread(my_file, 1, 'int32');
  a.magstrength = fread(my_file, 1, 'int32');
  a.patweight = fread(my_file, 1, 'int32');
  a.ex_datetime = fread(my_file, 1, 'int32');
  a.ex_lastmod = fread(my_file, 1, 'int32');
  a.patChecksumType = fread(my_file, 1, 'int32');
  for id = 1 : 26
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.ex_no = fread(my_file, 1, 'uint16');
  a.ex_uniq = fread(my_file, 1, 'int16');
  a.detect = fread(my_file, 1, 'int16');
  a.tubetyp = fread(my_file, 1, 'int16');
  a.dastyp = fread(my_file, 1, 'int16');
  a.num_dcnk = fread(my_file, 1, 'int16');
  a.dcn_len = fread(my_file, 1, 'int16');
  a.dcn_density = fread(my_file, 1, 'int16');
  a.dcn_stepsize = fread(my_file, 1, 'int16');
  a.dcn_shiftcnt = fread(my_file, 1, 'int16');
  a.patage = fread(my_file, 1, 'int16');
  a.patian = fread(my_file, 1, 'int16');
  a.patsex = fread(my_file, 1, 'int16');
  a.ex_format = fread(my_file, 1, 'int16');
  a.trauma = fread(my_file, 1, 'int16');
  a.protocolflag = fread(my_file, 1, 'int16');
  a.study_status = fread(my_file, 1, 'int16');
  for id = 1 : 35
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  a.hist = freadc(my_file, 257);
  a.refphy = freadc(my_file, 65);
  a.diagrad = freadc(my_file, 65);
  a.operator_new = freadc(my_file, 65);
  a.ex_desc = freadc(my_file, 65);
  a.ex_typ = freadc(my_file, 3);
  a.ex_sysid = freadc(my_file, 17);
  a.ex_alloc_key = freadc(my_file, 13);
  a.ex_diskid = fread(my_file, 1, 'char');
  a.hospname = freadc(my_file, 33);
  for id = 1 : 4
    a.ex_suid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.ex_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.uniq_sys_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.service_id(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.mobile_loc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.study_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patnameff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.patidff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 17
    a.reqnumff(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 9
    a.dateofbirth(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.mwlstudyuid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.mwlstudyid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 232
    a.ex_padding(id) = fread(my_file, 1, 'char');
  end


end

