function a = read_series_header( my_file, rdbm_rev )
%read_series_header - Read GE series header
%
%  a = read_series_header( my_file, rdbm_rev );
%    my_file - string indicating file name to read
%    rdbm_rev - raw header (RDBM) revision number
%    a - structure with header values
%

% Copyright (c) 2012 by General Electric Company. All rights reserved.

if rdbm_rev < 11
    a.se_suid       = freadc( my_file,  4  );
    a.se_uniq       =  fread( my_file,  1, 'int16'  );
    a.se_diskid     = freadc( my_file,  1  );
    fseek(my_file, 1, 'cof');
    a.se_exno       =  fread( my_file,  1, 'uint16' );
    a.se_no         =  fread( my_file,  1, 'int16'  );
    a.se_datetime   =  fread( my_file,  1, 'int32'  );
    a.se_actual_dt  =  fread( my_file,  1, 'int32'  );
    a.se_desc       = freadc( my_file, 30  );
    a.pr_sysid      = freadc( my_file,  9  );
    a.pansysid      = freadc( my_file,  9  );
    a.se_typ        =  fread( my_file,  1, 'int16'  );
    a.se_source     =  fread( my_file,  1, 'int16'  );
    a.se_plane      =  fread( my_file,  1, 'int16'  );
    a.scan_type     =  fread( my_file,  1, 'int16'  );
    a.position      =  fread( my_file,  1, 'int32'  );
    a.entry         =  fread( my_file,  1, 'int32'  );
    a.anref         = freadc( my_file,  3  );
    fseek(my_file, 1, 'cof');
    a.lmhor         =  fread( my_file,  1, 'float32');
    a.prtcl         = freadc( my_file, 25  );
    fseek(my_file, 1, 'cof');
    a.se_contrast   =  fread( my_file,  1, 'int16'  );
    a.start_ras     = freadc( my_file,  1  );
    fseek(my_file, 3, 'cof');
    a.start_loc     =  fread( my_file,  1, 'float32');
    a.end_ras       = freadc( my_file,  1 );
    fseek(my_file, 3, 'cof');
    a.end_loc       =  fread( my_file,  1, 'float32');
    a.se_pseq       =  fread( my_file,  1, 'int16'  );
    a.se_sortorder  =  fread( my_file,  1, 'int16'  );
    a.se_lndmrkcnt  =  fread( my_file,  1, 'int32'  );
    a.se_nacq       =  fread( my_file,  1, 'int16'  );
    a.xbasest       =  fread( my_file,  1, 'int16'  );
    a.xbaseend      =  fread( my_file,  1, 'int16'  );
    a.xenhst        =  fread( my_file,  1, 'int16'  );
    a.xenhend       =  fread( my_file,  1, 'int16'  );
    fseek(my_file, 2, 'cof');
    a.se_lastmod    =  fread( my_file,  1, 'int32'  );
    a.se_alloc_key  = freadc( my_file, 13 );
    fseek(my_file, 3, 'cof');
    a.se_delta_cnt  =  fread( my_file,  1, 'int32'  );
    a.se_verscre    = freadc( my_file,  2 );
    a.se_verscur    = freadc( my_file,  2 );
    a.se_pds_a      =  fread( my_file,  1, 'float32' );
    a.se_pds_c      =  fread( my_file,  1, 'float32' );
    a.se_pds_u      =  fread( my_file,  1, 'float32' );
    a.se_checksum   =  fread( my_file,  1, 'uint32'  );
    a.se_complete   =  fread( my_file,  1, 'int32'   );
    a.se_numarch    =  fread( my_file,  1, 'int32'   );
    a.se_imagect    =  fread( my_file,  1, 'int32'   );
    a.se_numimages  =  fread( my_file,  1, 'int32'   );
    a.se_images     =  fread_vartype( my_file );
    a.se_numunimg   =  fread( my_file,  1, 'int32'   );
    a.se_unimages   =  fread_vartype( my_file );
    a.se_toarchcnt  =  fread( my_file,  1, 'int32'   );
    a.se_toarchive  =  fread_vartype( my_file );
    a.echo1_alpha   =  fread( my_file,  1, 'float32' );
    a.echo1_beta    =  fread( my_file,  1, 'float32' );
    a.echo1_window  =  fread( my_file,  1, 'uint16'  );
    a.echo1_level   =  fread( my_file,  1, 'int16'   );
    a.echo2_alpha   =  fread( my_file,  1, 'float32' );
    a.echo2_beta    =  fread( my_file,  1, 'float32' );
    a.echo2_window  =  fread( my_file,  1, 'uint16'  );
    a.echo2_level   =  fread( my_file,  1, 'int16'   );
    a.echo3_alpha   =  fread( my_file,  1, 'float32' );
    a.echo3_beta    =  fread( my_file,  1, 'float32' );
    a.echo3_window  =  fread( my_file,  1, 'uint16'  );
    a.echo3_level   =  fread( my_file,  1, 'int16'   );
    a.echo4_alpha   =  fread( my_file,  1, 'float32' );
    a.echo4_beta    =  fread( my_file,  1, 'float32' );
    a.echo4_window  =  fread( my_file,  1, 'uint16'  );
    a.echo4_level   =  fread( my_file,  1, 'int16'   );
    a.echo5_alpha   =  fread( my_file,  1, 'float32' );
    a.echo5_beta    =  fread( my_file,  1, 'float32' );
    a.echo5_window  =  fread( my_file,  1, 'uint16'  );
    a.echo5_level   =  fread( my_file,  1, 'int16'   );
    a.echo6_alpha   =  fread( my_file,  1, 'float32' );
    a.echo6_beta    =  fread( my_file,  1, 'float32' );
    a.echo6_window  =  fread( my_file,  1, 'uint16'  );
    a.echo6_level   =  fread( my_file,  1, 'int16'   );
    a.echo7_alpha   =  fread( my_file,  1, 'float32' );
    a.echo7_beta    =  fread( my_file,  1, 'float32' );
    a.echo7_window  =  fread( my_file,  1, 'uint16'  );
    a.echo7_level   =  fread( my_file,  1, 'int16'   );
    a.echo8_alpha   =  fread( my_file,  1, 'float32' );
    a.echo8_beta    =  fread( my_file,  1, 'float32' );
    a.echo8_window  =  fread( my_file,  1, 'uint16'  );
    a.echo8_level   =  fread( my_file,  1, 'int16'   );
    a.series_uid    = freadc( my_file, 32  );
    a.landmark_uid  = freadc( my_file, 32  );
    a.equipmnt_uid  = freadc( my_file, 32  );
    a.refsopcuids   = freadc( my_file, 32  );
    a.refsopiuids   = freadc( my_file, 32  );
    a.schacitval    = freadc( my_file, 16  );
    a.schacitdesc   = freadc( my_file, 16  );
    a.schacitmea    = freadc( my_file, 64  );
    a.schprocstdesc = freadc( my_file, 64  );
    a.schprocstid   = freadc( my_file, 16  );
    a.reqprocstid   = freadc( my_file, 16  );
    a.perprocstid   = freadc( my_file, 16  );
    a.perprocstdesc = freadc( my_file, 64  );

    a.table_entry   =  fread( my_file,  1, 'int16'  );
    a.SwingAngle    =  fread( my_file,  1, 'int16'  );
    a.LateralOffset =  fread( my_file,  1, 'int16'  );
    a.reqprocstid2  = freadc( my_file, 16  );
    a.reqprocstid3  = freadc( my_file, 16  );
    a.schprocstid2  = freadc( my_file, 16  );
    a.schprocstid3  = freadc( my_file, 16  );
    a.refImgUID     = freadc( my_file, 32  );
    a.GradientCoil  =  fread( my_file,  1, 'int16'  );
    % a.se_padding    = freadc( my_file,148  );    % Spare space

end

if rdbm_rev <= 14.0
    a.se_images = fread_vartype( my_file );
    a.se_unimages = fread_vartype( my_file );
    a.se_toarchive = fread_vartype( my_file );
    a.se_pds_a = fread(my_file, 1, 'float32');
    a.se_pds_c = fread(my_file, 1, 'float32');
    a.se_pds_u = fread(my_file, 1, 'float32');
    a.lmhor = fread(my_file, 1, 'float32');
    a.start_loc = fread(my_file, 1, 'float32');
    a.end_loc = fread(my_file, 1, 'float32');
    a.echo1_alpha = fread(my_file, 1, 'float32');
    a.echo1_beta = fread(my_file, 1, 'float32');
    a.echo2_alpha = fread(my_file, 1, 'float32');
    a.echo2_beta = fread(my_file, 1, 'float32');
    a.echo3_alpha = fread(my_file, 1, 'float32');
    a.echo3_beta = fread(my_file, 1, 'float32');
    a.echo4_alpha = fread(my_file, 1, 'float32');
    a.echo4_beta = fread(my_file, 1, 'float32');
    a.echo5_alpha = fread(my_file, 1, 'float32');
    a.echo5_beta = fread(my_file, 1, 'float32');
    a.echo6_alpha = fread(my_file, 1, 'float32');
    a.echo6_beta = fread(my_file, 1, 'float32');
    a.echo7_alpha = fread(my_file, 1, 'float32');
    a.echo7_beta = fread(my_file, 1, 'float32');
    a.echo8_alpha = fread(my_file, 1, 'float32');
    a.echo8_beta = fread(my_file, 1, 'float32');
    a.se_checksum = fread(my_file, 1, 'uint32');
    a.se_complete = fread(my_file, 1, 'int32');
    a.se_numarch = fread(my_file, 1, 'int32');
    a.se_imagect = fread(my_file, 1, 'int32');
    a.se_numimages = fread(my_file, 1, 'int32');
    a.se_delta_cnt = fread(my_file, 1, 'int32');
    a.se_numunimg = fread(my_file, 1, 'int32');
    a.se_toarchcnt = fread(my_file, 1, 'int32');
    a.se_datetime = fread(my_file, 1, 'int32');
    a.se_actual_dt = fread(my_file, 1, 'int32');
    a.position = fread(my_file, 1, 'int32');
    a.entry = fread(my_file, 1, 'int32');
    a.se_lndmrkcnt = fread(my_file, 1, 'int32');
    a.se_lastmod = fread(my_file, 1, 'int32');
    a.ExpType = fread(my_file, 1, 'int32');
    a.TrRest = fread(my_file, 1, 'int32');
    a.TrActive = fread(my_file, 1, 'int32');
    a.DumAcq = fread(my_file, 1, 'int32');
    a.ExptTimePts = fread(my_file, 1, 'int32');
    a.se_exno = fread(my_file, 1, 'uint16');
    a.echo1_window = fread(my_file, 1, 'uint16');
    a.echo2_window = fread(my_file, 1, 'uint16');
    a.echo3_window = fread(my_file, 1, 'uint16');
    a.echo4_window = fread(my_file, 1, 'uint16');
    a.echo5_window = fread(my_file, 1, 'uint16');
    a.echo6_window = fread(my_file, 1, 'uint16');
    a.echo7_window = fread(my_file, 1, 'uint16');
    a.echo8_window = fread(my_file, 1, 'uint16');
    a.echo8_level = fread(my_file, 1, 'int16');
    a.echo7_level = fread(my_file, 1, 'int16');
    a.echo6_level = fread(my_file, 1, 'int16');
    a.echo5_level = fread(my_file, 1, 'int16');
    a.echo4_level = fread(my_file, 1, 'int16');
    a.echo3_level = fread(my_file, 1, 'int16');
    a.echo2_level = fread(my_file, 1, 'int16');
    a.echo1_level = fread(my_file, 1, 'int16');
    a.se_no = fread(my_file, 1, 'int16');
    a.se_typ = fread(my_file, 1, 'int16');
    a.se_source = fread(my_file, 1, 'int16');
    a.se_plane = fread(my_file, 1, 'int16');
    a.scan_type = fread(my_file, 1, 'int16');
    a.se_uniq = fread(my_file, 1, 'int16');
    a.se_contrast = fread(my_file, 1, 'int16');
    a.se_pseq = fread(my_file, 1, 'int16');
    a.se_sortorder = fread(my_file, 1, 'int16');
    a.se_nacq = fread(my_file, 1, 'int16');
    a.xbasest = fread(my_file, 1, 'int16');
    a.xbaseend = fread(my_file, 1, 'int16');
    a.xenhst = fread(my_file, 1, 'int16');
    a.xenhend = fread(my_file, 1, 'int16');
    a.table_entry = fread(my_file, 1, 'int16');
    a.SwingAngle = fread(my_file, 1, 'int16');
    a.LateralOffset = fread(my_file, 1, 'int16');
    a.GradientCoil = fread(my_file, 1, 'int16');
    a.se_subtype = fread(my_file, 1, 'int16');
    a.BWRT = fread(my_file, 1, 'int16');
    a.assetcal_serno = fread(my_file, 1, 'int16');
    a.assetcal_scnno = fread(my_file, 1, 'int16');
    a.content_qualifn = fread(my_file, 1, 'int16');
    a.purecal_serno = fread(my_file, 1, 'int16');
    a.purecal_scnno = fread(my_file, 1, 'int16');
    a.short_padding = fread(my_file, 2, 'int16');
    a.se_verscre = freadc(my_file, 2);
    a.se_verscur = freadc(my_file, 2);
    a.se_suid = freadc(my_file, 4);
    a.se_alloc_key = freadc(my_file, 13);
    a.se_diskid = fread(my_file, 1, 'char');
    a.se_desc = freadc(my_file, 65);
    a.pr_sysid = freadc(my_file, 9);
    a.pansysid = freadc(my_file, 9);
    a.anref = freadc(my_file, 3);
    a.prtcl = freadc(my_file, 25);
    a.start_ras = fread(my_file, 1, 'char');
    a.end_ras = fread(my_file, 1, 'char');
    a.series_uid = freadc(my_file, 32);
    a.landmark_uid = freadc(my_file, 32);
    a.equipmnt_uid = freadc(my_file, 32);
    a.refsopcuids = freadc(my_file, 32);
    a.refsopiuids = freadc(my_file, 32);
    a.schacitval = freadc(my_file, 16);
    a.schacitdesc = freadc(my_file, 16);
    a.schacitmea = freadc(my_file, 64);
    a.schprocstdesc = freadc(my_file, 65);
    a.schprocstid = freadc(my_file, 16);
    a.reqprocstid = freadc(my_file, 16);
    a.perprocstid = freadc(my_file, 16);
    a.perprocstdesc = freadc(my_file, 65);
    a.reqprocstid2 = freadc(my_file, 16);
    a.reqprocstid3 = freadc(my_file, 16);
    a.schprocstid2 = freadc(my_file, 16);
    a.schprocstid3 = freadc(my_file, 16);
    a.refImgUID = freadc(my_file, 32);
    a.PdgmStr = freadc(my_file, 64);
    a.PdgmDesc = freadc(my_file, 256);
    a.PdgmUID = freadc(my_file, 64);
    a.ApplName = freadc(my_file, 16);
    a.ApplVer = freadc(my_file, 16);
    a.asset_appl = freadc(my_file, 12);
    a.scic_a = freadc(my_file, 32);
    a.scic_s = freadc(my_file, 32);
    a.scic_c = freadc(my_file, 32);
    a.pure_cfg_params = freadc(my_file, 64);
    a.se_padding = freadc(my_file, 423);
end

if rdbm_rev == 14.1
    a.se_images.length = fread(my_file, 1, 'int32');
    a.se_images.data = fread(my_file, 1, 'int32');
    a.se_unimages.length = fread(my_file, 1, 'int32');
    a.se_unimages.data = fread(my_file, 1, 'int32');
    a.se_toarchive.length = fread(my_file, 1, 'int32');
    a.se_toarchive.data = fread(my_file, 1, 'int32');
    a.se_pds_a = fread(my_file, 1, 'float32');
    a.se_pds_c = fread(my_file, 1, 'float32');
    a.se_pds_u = fread(my_file, 1, 'float32');
    a.lmhor = fread(my_file, 1, 'float32');
    a.start_loc = fread(my_file, 1, 'float32');
    a.end_loc = fread(my_file, 1, 'float32');
    a.echo1_alpha = fread(my_file, 1, 'float32');
    a.echo1_beta = fread(my_file, 1, 'float32');
    a.echo2_alpha = fread(my_file, 1, 'float32');
    a.echo2_beta = fread(my_file, 1, 'float32');
    a.echo3_alpha = fread(my_file, 1, 'float32');
    a.echo3_beta = fread(my_file, 1, 'float32');
    a.echo4_alpha = fread(my_file, 1, 'float32');
    a.echo4_beta = fread(my_file, 1, 'float32');
    a.echo5_alpha = fread(my_file, 1, 'float32');
    a.echo5_beta = fread(my_file, 1, 'float32');
    a.echo6_alpha = fread(my_file, 1, 'float32');
    a.echo6_beta = fread(my_file, 1, 'float32');
    a.echo7_alpha = fread(my_file, 1, 'float32');
    a.echo7_beta = fread(my_file, 1, 'float32');
    a.echo8_alpha = fread(my_file, 1, 'float32');
    a.echo8_beta = fread(my_file, 1, 'float32');
    a.se_checksum = fread(my_file, 1, 'uint32');
    a.se_complete = fread(my_file, 1, 'int32');
    a.se_numarch = fread(my_file, 1, 'int32');
    a.se_imagect = fread(my_file, 1, 'int32');
    a.se_numimages = fread(my_file, 1, 'int32');
    a.se_delta_cnt = fread(my_file, 1, 'int32');
    a.se_numunimg = fread(my_file, 1, 'int32');
    a.se_toarchcnt = fread(my_file, 1, 'int32');
    a.se_datetime = fread(my_file, 1, 'int32');
    a.se_actual_dt = fread(my_file, 1, 'int32');
    a.position = fread(my_file, 1, 'int32');
    a.entry = fread(my_file, 1, 'int32');
    a.se_lndmrkcnt = fread(my_file, 1, 'int32');
    a.se_lastmod = fread(my_file, 1, 'int32');
    a.ExpType = fread(my_file, 1, 'int32');
    a.TrRest = fread(my_file, 1, 'int32');
    a.TrActive = fread(my_file, 1, 'int32');
    a.DumAcq = fread(my_file, 1, 'int32');
    a.ExptTimePts = fread(my_file, 1, 'int32');
    a.se_exno = fread(my_file, 1, 'uint16');
    a.echo1_window = fread(my_file, 1, 'uint16');
    a.echo2_window = fread(my_file, 1, 'uint16');
    a.echo3_window = fread(my_file, 1, 'uint16');
    a.echo4_window = fread(my_file, 1, 'uint16');
    a.echo5_window = fread(my_file, 1, 'uint16');
    a.echo6_window = fread(my_file, 1, 'uint16');
    a.echo7_window = fread(my_file, 1, 'uint16');
    a.echo8_window = fread(my_file, 1, 'uint16');
    a.echo8_level = fread(my_file, 1, 'int16');
    a.echo7_level = fread(my_file, 1, 'int16');
    a.echo6_level = fread(my_file, 1, 'int16');
    a.echo5_level = fread(my_file, 1, 'int16');
    a.echo4_level = fread(my_file, 1, 'int16');
    a.echo3_level = fread(my_file, 1, 'int16');
    a.echo2_level = fread(my_file, 1, 'int16');
    a.echo1_level = fread(my_file, 1, 'int16');
    a.se_no = fread(my_file, 1, 'int16');
    a.se_typ = fread(my_file, 1, 'int16');
    a.se_source = fread(my_file, 1, 'int16');
    a.se_plane = fread(my_file, 1, 'int16');
    a.scan_type = fread(my_file, 1, 'int16');
    a.se_uniq = fread(my_file, 1, 'int16');
    a.se_contrast = fread(my_file, 1, 'int16');
    a.se_pseq = fread(my_file, 1, 'int16');
    a.se_sortorder = fread(my_file, 1, 'int16');
    a.se_nacq = fread(my_file, 1, 'int16');
    a.xbasest = fread(my_file, 1, 'int16');
    a.xbaseend = fread(my_file, 1, 'int16');
    a.xenhst = fread(my_file, 1, 'int16');
    a.xenhend = fread(my_file, 1, 'int16');
    a.table_entry = fread(my_file, 1, 'int16');
    a.SwingAngle = fread(my_file, 1, 'int16');
    a.LateralOffset = fread(my_file, 1, 'int16');
    a.GradientCoil = fread(my_file, 1, 'int16');
    a.se_subtype = fread(my_file, 1, 'int16');
    a.BWRT = fread(my_file, 1, 'int16');
    a.assetcal_serno = fread(my_file, 1, 'int16');
    a.assetcal_scnno = fread(my_file, 1, 'int16');
    a.content_qualifn = fread(my_file, 1, 'int16');
    a.purecal_serno = fread(my_file, 1, 'int16');
    a.purecal_scnno = fread(my_file, 1, 'int16');
    for id = 1 : 2
        a.short_padding(id) = fread(my_file, 1, 'int16');
    end
    for id = 1 : 2
        a.se_verscre(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 2
        a.se_verscur(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 4
        a.se_suid(id) = fread(my_file, 1, 'char');
    end
    a.se_alloc_key = freadc(my_file, 13);
    a.se_diskid = fread(my_file, 1, 'char');
    a.se_desc = freadc(my_file, 65);
    a.pr_sysid = freadc(my_file, 9);
    a.pansysid = freadc(my_file, 9);
    a.anref = freadc(my_file, 3);
    a.prtcl = freadc(my_file, 25);
    a.start_ras = fread(my_file, 1, 'char');
    a.end_ras = fread(my_file, 1, 'char');
    for id = 1 : 32
        a.series_uid(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 32
        a.landmark_uid(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 32
        a.equipmnt_uid(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 32
        a.refsopcuids(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 32
        a.refsopiuids(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 16
        a.schacitval(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 16
        a.schacitdesc(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 64
        a.schacitmea(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 65
        a.schprocstdesc(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 16
        a.schprocstid(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 16
        a.reqprocstid(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 16
        a.perprocstid(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 65
        a.perprocstdesc(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 16
        a.reqprocstid2(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 16
        a.reqprocstid3(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 16
        a.schprocstid2(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 16
        a.schprocstid3(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 32
        a.refImgUID(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 64
        a.PdgmStr(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 256
        a.PdgmDesc(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 64
        a.PdgmUID(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 16
        a.ApplName(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 16
        a.ApplVer(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 12
        a.asset_appl(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 32
        a.scic_a(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 32
        a.scic_s(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 32
        a.scic_c(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 64
        a.pure_cfg_params(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 423
        a.se_padding(id) = fread(my_file, 1, 'char');
    end
end

if rdbm_rev == 14.2
    for id = 1 : 7
        a.double_padding(id) = fread(my_file, 1, 'double');
    end
    a.se_pds_a = fread(my_file, 1, 'float32');
    a.se_pds_c = fread(my_file, 1, 'float32');
    a.se_pds_u = fread(my_file, 1, 'float32');
    a.lmhor = fread(my_file, 1, 'float32');
    a.start_loc = fread(my_file, 1, 'float32');
    a.end_loc = fread(my_file, 1, 'float32');
    a.echo1_alpha = fread(my_file, 1, 'float32');
    a.echo1_beta = fread(my_file, 1, 'float32');
    a.echo2_alpha = fread(my_file, 1, 'float32');
    a.echo2_beta = fread(my_file, 1, 'float32');
    a.echo3_alpha = fread(my_file, 1, 'float32');
    a.echo3_beta = fread(my_file, 1, 'float32');
    a.echo4_alpha = fread(my_file, 1, 'float32');
    a.echo4_beta = fread(my_file, 1, 'float32');
    a.echo5_alpha = fread(my_file, 1, 'float32');
    a.echo5_beta = fread(my_file, 1, 'float32');
    a.echo6_alpha = fread(my_file, 1, 'float32');
    a.echo6_beta = fread(my_file, 1, 'float32');
    a.echo7_alpha = fread(my_file, 1, 'float32');
    a.echo7_beta = fread(my_file, 1, 'float32');
    a.echo8_alpha = fread(my_file, 1, 'float32');
    a.echo8_beta = fread(my_file, 1, 'float32');
    for id = 1 : 8
        a.float_padding(id) = fread(my_file, 1, 'float32');
    end
    a.se_checksum = fread(my_file, 1, 'uint32');
    a.se_complete = fread(my_file, 1, 'int32');
    a.se_numarch = fread(my_file, 1, 'int32');
    a.se_imagect = fread(my_file, 1, 'int32');
    a.se_numimages = fread(my_file, 1, 'int32');
    a.se_delta_cnt = fread(my_file, 1, 'int32');
    a.se_numunimg = fread(my_file, 1, 'int32');
    a.se_toarchcnt = fread(my_file, 1, 'int32');
    for id = 1 : 8
        a.long_padding(id) = fread(my_file, 1, 'int32');
    end
    a.se_datetime = fread(my_file, 1, 'int32');
    a.se_actual_dt = fread(my_file, 1, 'int32');
    a.position = fread(my_file, 1, 'int32');
    a.entry = fread(my_file, 1, 'int32');
    a.se_lndmrkcnt = fread(my_file, 1, 'int32');
    a.se_lastmod = fread(my_file, 1, 'int32');
    a.ExpType = fread(my_file, 1, 'int32');
    a.TrRest = fread(my_file, 1, 'int32');
    a.TrActive = fread(my_file, 1, 'int32');
    a.DumAcq = fread(my_file, 1, 'int32');
    a.ExptTimePts = fread(my_file, 1, 'int32');
    for id = 1 : 16
        a.int_padding(id) = fread(my_file, 1, 'int32');
    end
    a.se_exno = fread(my_file, 1, 'uint16');
    a.echo1_window = fread(my_file, 1, 'uint16');
    a.echo2_window = fread(my_file, 1, 'uint16');
    a.echo3_window = fread(my_file, 1, 'uint16');
    a.echo4_window = fread(my_file, 1, 'uint16');
    a.echo5_window = fread(my_file, 1, 'uint16');
    a.echo6_window = fread(my_file, 1, 'uint16');
    a.echo7_window = fread(my_file, 1, 'uint16');
    a.echo8_window = fread(my_file, 1, 'uint16');
    a.echo8_level = fread(my_file, 1, 'int16');
    a.echo7_level = fread(my_file, 1, 'int16');
    a.echo6_level = fread(my_file, 1, 'int16');
    a.echo5_level = fread(my_file, 1, 'int16');
    a.echo4_level = fread(my_file, 1, 'int16');
    a.echo3_level = fread(my_file, 1, 'int16');
    a.echo2_level = fread(my_file, 1, 'int16');
    a.echo1_level = fread(my_file, 1, 'int16');
    a.se_no = fread(my_file, 1, 'int16');
    a.se_typ = fread(my_file, 1, 'int16');
    a.se_source = fread(my_file, 1, 'int16');
    a.se_plane = fread(my_file, 1, 'int16');
    a.scan_type = fread(my_file, 1, 'int16');
    a.se_uniq = fread(my_file, 1, 'int16');
    a.se_contrast = fread(my_file, 1, 'int16');
    a.se_pseq = fread(my_file, 1, 'int16');
    a.se_sortorder = fread(my_file, 1, 'int16');
    a.se_nacq = fread(my_file, 1, 'int16');
    a.xbasest = fread(my_file, 1, 'int16');
    a.xbaseend = fread(my_file, 1, 'int16');
    a.xenhst = fread(my_file, 1, 'int16');
    a.xenhend = fread(my_file, 1, 'int16');
    a.table_entry = fread(my_file, 1, 'int16');
    a.SwingAngle = fread(my_file, 1, 'int16');
    a.LateralOffset = fread(my_file, 1, 'int16');
    a.GradientCoil = fread(my_file, 1, 'int16');
    a.se_subtype = fread(my_file, 1, 'int16');
    a.BWRT = fread(my_file, 1, 'int16');
    a.assetcal_serno = fread(my_file, 1, 'int16');
    a.assetcal_scnno = fread(my_file, 1, 'int16');
    a.content_qualifn = fread(my_file, 1, 'int16');
    a.purecal_serno = fread(my_file, 1, 'int16');
    a.purecal_scnno = fread(my_file, 1, 'int16');
    for id = 1 : 26
        a.short_padding(id) = fread(my_file, 1, 'int16');
    end
    for id = 1 : 2
        a.se_verscre(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 2
        a.se_verscur(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 4
        a.se_suid(id) = fread(my_file, 1, 'char');
    end
    a.se_alloc_key = freadc(my_file, 13);
    a.se_diskid = fread(my_file, 1, 'char');
    a.se_desc = freadc(my_file, 65);
    a.pr_sysid = freadc(my_file, 9);
    a.pansysid = freadc(my_file, 9);
    a.anref = freadc(my_file, 3);
    a.prtcl = freadc(my_file, 25);
    a.start_ras = fread(my_file, 1, 'char');
    a.end_ras = fread(my_file, 1, 'char');
    for id = 1 : 32
        a.series_uid(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 32
        a.landmark_uid(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 32
        a.equipmnt_uid(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 32
        a.refsopcuids(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 32
        a.refsopiuids(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 16
        a.schacitval(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 16
        a.schacitdesc(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 64
        a.schacitmea(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 65
        a.schprocstdesc(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 16
        a.schprocstid(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 16
        a.reqprocstid(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 16
        a.perprocstid(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 65
        a.perprocstdesc(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 16
        a.reqprocstid2(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 16
        a.reqprocstid3(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 16
        a.schprocstid2(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 16
        a.schprocstid3(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 32
        a.refImgUID(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 64
        a.PdgmStr(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 256
        a.PdgmDesc(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 64
        a.PdgmUID(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 16
        a.ApplName(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 16
        a.ApplVer(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 12
        a.asset_appl(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 32
        a.scic_a(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 32
        a.scic_s(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 32
        a.scic_c(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 64
        a.pure_cfg_params(id) = fread(my_file, 1, 'char');
    end
    for id = 1 : 215
        a.se_padding(id) = fread(my_file, 1, 'char');
    end
end

% RDBM revision 14.3
if rdbm_rev == 14.3 
  fseek(my_file, 28, 'cof');
  for id = 1 : 7
    a.double_padding(id) = fread(my_file, 1, 'float32');
  end
  a.se_pds_a = fread(my_file, 1, 'float32');
  a.se_pds_c = fread(my_file, 1, 'float32');
  a.se_pds_u = fread(my_file, 1, 'float32');
  a.lmhor = fread(my_file, 1, 'float32');
  a.start_loc = fread(my_file, 1, 'float32');
  a.end_loc = fread(my_file, 1, 'float32');
  a.echo1_alpha = fread(my_file, 1, 'float32');
  a.echo1_beta = fread(my_file, 1, 'float32');
  a.echo2_alpha = fread(my_file, 1, 'float32');
  a.echo2_beta = fread(my_file, 1, 'float32');
  a.echo3_alpha = fread(my_file, 1, 'float32');
  a.echo3_beta = fread(my_file, 1, 'float32');
  a.echo4_alpha = fread(my_file, 1, 'float32');
  a.echo4_beta = fread(my_file, 1, 'float32');
  a.echo5_alpha = fread(my_file, 1, 'float32');
  a.echo5_beta = fread(my_file, 1, 'float32');
  a.echo6_alpha = fread(my_file, 1, 'float32');
  a.echo6_beta = fread(my_file, 1, 'float32');
  a.echo7_alpha = fread(my_file, 1, 'float32');
  a.echo7_beta = fread(my_file, 1, 'float32');
  a.echo8_alpha = fread(my_file, 1, 'float32');
  a.echo8_beta = fread(my_file, 1, 'float32');
  for id = 1 : 8
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.se_checksum = fread(my_file, 1, 'uint32');
  a.se_complete = fread(my_file, 1, 'int32');
  a.se_numarch = fread(my_file, 1, 'int32');
  a.se_imagect = fread(my_file, 1, 'int32');
  a.se_numimages = fread(my_file, 1, 'int32');
  a.se_delta_cnt = fread(my_file, 1, 'int32');
  a.se_numunimg = fread(my_file, 1, 'int32');
  a.se_toarchcnt = fread(my_file, 1, 'int32');
  for id = 1 : 8
    a.long_padding(id) = fread(my_file, 1, 'int32');
  end
  a.se_datetime = fread(my_file, 1, 'int32');
  a.se_actual_dt = fread(my_file, 1, 'int32');
  a.position = fread(my_file, 1, 'int32');
  a.entry = fread(my_file, 1, 'int32');
  a.se_lndmrkcnt = fread(my_file, 1, 'int32');
  a.se_lastmod = fread(my_file, 1, 'int32');
  a.ExpType = fread(my_file, 1, 'int32');
  a.TrRest = fread(my_file, 1, 'int32');
  a.TrActive = fread(my_file, 1, 'int32');
  a.DumAcq = fread(my_file, 1, 'int32');
  a.ExptTimePts = fread(my_file, 1, 'int32');
  for id = 1 : 16
    a.int_padding(id) = fread(my_file, 1, 'int32');
  end
  a.se_exno = fread(my_file, 1, 'uint16');
  a.echo1_window = fread(my_file, 1, 'uint16');
  a.echo2_window = fread(my_file, 1, 'uint16');
  a.echo3_window = fread(my_file, 1, 'uint16');
  a.echo4_window = fread(my_file, 1, 'uint16');
  a.echo5_window = fread(my_file, 1, 'uint16');
  a.echo6_window = fread(my_file, 1, 'uint16');
  a.echo7_window = fread(my_file, 1, 'uint16');
  a.echo8_window = fread(my_file, 1, 'uint16');
  a.echo8_level = fread(my_file, 1, 'int16');
  a.echo7_level = fread(my_file, 1, 'int16');
  a.echo6_level = fread(my_file, 1, 'int16');
  a.echo5_level = fread(my_file, 1, 'int16');
  a.echo4_level = fread(my_file, 1, 'int16');
  a.echo3_level = fread(my_file, 1, 'int16');
  a.echo2_level = fread(my_file, 1, 'int16');
  a.echo1_level = fread(my_file, 1, 'int16');
  a.se_no = fread(my_file, 1, 'int16');
  a.se_typ = fread(my_file, 1, 'int16');
  a.se_source = fread(my_file, 1, 'int16');
  a.se_plane = fread(my_file, 1, 'int16');
  a.scan_type = fread(my_file, 1, 'int16');
  a.se_uniq = fread(my_file, 1, 'int16');
  a.se_contrast = fread(my_file, 1, 'int16');
  a.se_pseq = fread(my_file, 1, 'int16');
  a.se_sortorder = fread(my_file, 1, 'int16');
  a.se_nacq = fread(my_file, 1, 'int16');
  a.xbasest = fread(my_file, 1, 'int16');
  a.xbaseend = fread(my_file, 1, 'int16');
  a.xenhst = fread(my_file, 1, 'int16');
  a.xenhend = fread(my_file, 1, 'int16');
  a.table_entry = fread(my_file, 1, 'int16');
  a.SwingAngle = fread(my_file, 1, 'int16');
  a.LateralOffset = fread(my_file, 1, 'int16');
  a.GradientCoil = fread(my_file, 1, 'int16');
  a.se_subtype = fread(my_file, 1, 'int16');
  a.BWRT = fread(my_file, 1, 'int16');
  a.assetcal_serno = fread(my_file, 1, 'int16');
  a.assetcal_scnno = fread(my_file, 1, 'int16');
  a.content_qualifn = fread(my_file, 1, 'int16');
  a.purecal_serno = fread(my_file, 1, 'int16');
  a.purecal_scnno = fread(my_file, 1, 'int16');
  for id = 1 : 26
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  for id = 1 : 2
    a.se_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.se_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.se_suid(id) = fread(my_file, 1, 'char');
  end
  a.se_alloc_key = freadc(my_file, 13);
  a.se_diskid = fread(my_file, 1, 'char');
  a.se_desc = freadc(my_file, 65);
  a.pr_sysid = freadc(my_file, 9);
  a.pansysid = freadc(my_file, 9);
  a.anref = freadc(my_file, 3);
  a.prtcl = freadc(my_file, 25);
  a.start_ras = fread(my_file, 1, 'char');
  a.end_ras = fread(my_file, 1, 'char');
  for id = 1 : 32
    a.series_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.landmark_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.equipmnt_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitval(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.schacitmea(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.schprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.perprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.perprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id1 = 1 : 4
    for id2 = 1 : 32
        a.refImgUID(id1,id2) = fread(my_file, 1, 'char');
    end
  end
  for id = 1 : 64
    a.PdgmStr(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 256
    a.PdgmDesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.PdgmUID(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplName(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplVer(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 12
    a.asset_appl(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_a(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_s(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_c(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.pure_cfg_params(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 215
    a.se_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 15.000
if rdbm_rev == 15.000 
  for id = 1 : 7
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.se_pds_a = fread(my_file, 1, 'float32');
  a.se_pds_c = fread(my_file, 1, 'float32');
  a.se_pds_u = fread(my_file, 1, 'float32');
  a.lmhor = fread(my_file, 1, 'float32');
  a.start_loc = fread(my_file, 1, 'float32');
  a.end_loc = fread(my_file, 1, 'float32');
  a.echo1_alpha = fread(my_file, 1, 'float32');
  a.echo1_beta = fread(my_file, 1, 'float32');
  a.echo2_alpha = fread(my_file, 1, 'float32');
  a.echo2_beta = fread(my_file, 1, 'float32');
  a.echo3_alpha = fread(my_file, 1, 'float32');
  a.echo3_beta = fread(my_file, 1, 'float32');
  a.echo4_alpha = fread(my_file, 1, 'float32');
  a.echo4_beta = fread(my_file, 1, 'float32');
  a.echo5_alpha = fread(my_file, 1, 'float32');
  a.echo5_beta = fread(my_file, 1, 'float32');
  a.echo6_alpha = fread(my_file, 1, 'float32');
  a.echo6_beta = fread(my_file, 1, 'float32');
  a.echo7_alpha = fread(my_file, 1, 'float32');
  a.echo7_beta = fread(my_file, 1, 'float32');
  a.echo8_alpha = fread(my_file, 1, 'float32');
  a.echo8_beta = fread(my_file, 1, 'float32');
  for id = 1 : 8
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.se_checksum = fread(my_file, 1, 'uint32');
  a.se_complete = fread(my_file, 1, 'int32');
  a.se_numarch = fread(my_file, 1, 'int32');
  a.se_imagect = fread(my_file, 1, 'int32');
  a.se_numimages = fread(my_file, 1, 'int32');
  a.se_delta_cnt = fread(my_file, 1, 'int32');
  a.se_numunimg = fread(my_file, 1, 'int32');
  a.se_toarchcnt = fread(my_file, 1, 'int32');
  for id = 1 : 8
    a.long_padding(id) = fread(my_file, 1, 'int32');
  end
  a.se_datetime = fread(my_file, 1, 'int32');
  a.se_actual_dt = fread(my_file, 1, 'int32');
  a.position = fread(my_file, 1, 'int32');
  a.entry = fread(my_file, 1, 'int32');
  a.se_lndmrkcnt = fread(my_file, 1, 'int32');
  a.se_lastmod = fread(my_file, 1, 'int32');
  a.ExpType = fread(my_file, 1, 'int32');
  a.TrRest = fread(my_file, 1, 'int32');
  a.TrActive = fread(my_file, 1, 'int32');
  a.DumAcq = fread(my_file, 1, 'int32');
  a.ExptTimePts = fread(my_file, 1, 'int32');
  for id = 1 : 16
    a.int_padding(id) = fread(my_file, 1, 'int32');
  end
  a.se_exno = fread(my_file, 1, 'uint16');
  a.echo1_window = fread(my_file, 1, 'uint16');
  a.echo2_window = fread(my_file, 1, 'uint16');
  a.echo3_window = fread(my_file, 1, 'uint16');
  a.echo4_window = fread(my_file, 1, 'uint16');
  a.echo5_window = fread(my_file, 1, 'uint16');
  a.echo6_window = fread(my_file, 1, 'uint16');
  a.echo7_window = fread(my_file, 1, 'uint16');
  a.echo8_window = fread(my_file, 1, 'uint16');
  a.echo8_level = fread(my_file, 1, 'int16');
  a.echo7_level = fread(my_file, 1, 'int16');
  a.echo6_level = fread(my_file, 1, 'int16');
  a.echo5_level = fread(my_file, 1, 'int16');
  a.echo4_level = fread(my_file, 1, 'int16');
  a.echo3_level = fread(my_file, 1, 'int16');
  a.echo2_level = fread(my_file, 1, 'int16');
  a.echo1_level = fread(my_file, 1, 'int16');
  a.se_no = fread(my_file, 1, 'int16');
  a.se_typ = fread(my_file, 1, 'int16');
  a.se_source = fread(my_file, 1, 'int16');
  a.se_plane = fread(my_file, 1, 'int16');
  a.scan_type = fread(my_file, 1, 'int16');
  a.se_uniq = fread(my_file, 1, 'int16');
  a.se_contrast = fread(my_file, 1, 'int16');
  a.se_pseq = fread(my_file, 1, 'int16');
  a.se_sortorder = fread(my_file, 1, 'int16');
  a.se_nacq = fread(my_file, 1, 'int16');
  a.xbasest = fread(my_file, 1, 'int16');
  a.xbaseend = fread(my_file, 1, 'int16');
  a.xenhst = fread(my_file, 1, 'int16');
  a.xenhend = fread(my_file, 1, 'int16');
  a.table_entry = fread(my_file, 1, 'int16');
  a.SwingAngle = fread(my_file, 1, 'int16');
  a.LateralOffset = fread(my_file, 1, 'int16');
  a.GradientCoil = fread(my_file, 1, 'int16');
  a.se_subtype = fread(my_file, 1, 'int16');
  a.BWRT = fread(my_file, 1, 'int16');
  a.assetcal_serno = fread(my_file, 1, 'int16');
  a.assetcal_scnno = fread(my_file, 1, 'int16');
  a.content_qualifn = fread(my_file, 1, 'int16');
  a.purecal_serno = fread(my_file, 1, 'int16');
  a.purecal_scnno = fread(my_file, 1, 'int16');
  a.ideal = fread(my_file, 1, 'int16');
  for id = 1 : 25
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  for id = 1 : 2
    a.se_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.se_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.se_suid(id) = fread(my_file, 1, 'char');
  end
  a.se_alloc_key = freadc(my_file, 13);
  a.se_diskid = fread(my_file, 1, 'char');
  a.se_desc = freadc(my_file, 65);
  a.pr_sysid = freadc(my_file, 9);
  a.pansysid = freadc(my_file, 9);
  a.anref = freadc(my_file, 3);
  a.prtcl = freadc(my_file, 25);
  a.start_ras = fread(my_file, 1, 'char');
  a.end_ras = fread(my_file, 1, 'char');
  for id = 1 : 32
    a.series_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.landmark_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.equipmnt_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitval(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.schacitmea(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.schprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.perprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.perprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id1 = 1 : 4
    for id2 = 1 : 32
        a.refImgUID(id1,id2) = fread(my_file, 1, 'char');
    end
  end
  for id = 1 : 64
    a.PdgmStr(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 256
    a.PdgmDesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.PdgmUID(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplName(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplVer(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 12
    a.asset_appl(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_a(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_s(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_c(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.pure_cfg_params(id) = fread(my_file, 1, 'char');
  end
  a.operator_new = freadc(my_file, 65);
  for id = 1 : 150
    a.se_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 15.001
if rdbm_rev == 15.001 
  for id = 1 : 7
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.se_pds_a = fread(my_file, 1, 'float32');
  a.se_pds_c = fread(my_file, 1, 'float32');
  a.se_pds_u = fread(my_file, 1, 'float32');
  a.lmhor = fread(my_file, 1, 'float32');
  a.start_loc = fread(my_file, 1, 'float32');
  a.end_loc = fread(my_file, 1, 'float32');
  a.echo1_alpha = fread(my_file, 1, 'float32');
  a.echo1_beta = fread(my_file, 1, 'float32');
  a.echo2_alpha = fread(my_file, 1, 'float32');
  a.echo2_beta = fread(my_file, 1, 'float32');
  a.echo3_alpha = fread(my_file, 1, 'float32');
  a.echo3_beta = fread(my_file, 1, 'float32');
  a.echo4_alpha = fread(my_file, 1, 'float32');
  a.echo4_beta = fread(my_file, 1, 'float32');
  a.echo5_alpha = fread(my_file, 1, 'float32');
  a.echo5_beta = fread(my_file, 1, 'float32');
  a.echo6_alpha = fread(my_file, 1, 'float32');
  a.echo6_beta = fread(my_file, 1, 'float32');
  a.echo7_alpha = fread(my_file, 1, 'float32');
  a.echo7_beta = fread(my_file, 1, 'float32');
  a.echo8_alpha = fread(my_file, 1, 'float32');
  a.echo8_beta = fread(my_file, 1, 'float32');
  for id = 1 : 8
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.se_checksum = fread(my_file, 1, 'uint32');
  a.se_complete = fread(my_file, 1, 'int32');
  a.se_numarch = fread(my_file, 1, 'int32');
  a.se_imagect = fread(my_file, 1, 'int32');
  a.se_numimages = fread(my_file, 1, 'int32');
  a.se_delta_cnt = fread(my_file, 1, 'int32');
  a.se_numunimg = fread(my_file, 1, 'int32');
  a.se_toarchcnt = fread(my_file, 1, 'int32');
  for id = 1 : 8
    a.long_padding(id) = fread(my_file, 1, 'int32');
  end
  a.se_datetime = fread(my_file, 1, 'int32');
  a.se_actual_dt = fread(my_file, 1, 'int32');
  a.position = fread(my_file, 1, 'int32');
  a.entry = fread(my_file, 1, 'int32');
  a.se_lndmrkcnt = fread(my_file, 1, 'int32');
  a.se_lastmod = fread(my_file, 1, 'int32');
  a.ExpType = fread(my_file, 1, 'int32');
  a.TrRest = fread(my_file, 1, 'int32');
  a.TrActive = fread(my_file, 1, 'int32');
  a.DumAcq = fread(my_file, 1, 'int32');
  a.ExptTimePts = fread(my_file, 1, 'int32');
  for id = 1 : 16
    a.int_padding(id) = fread(my_file, 1, 'int32');
  end
  a.se_exno = fread(my_file, 1, 'uint16');
  a.echo1_window = fread(my_file, 1, 'uint16');
  a.echo2_window = fread(my_file, 1, 'uint16');
  a.echo3_window = fread(my_file, 1, 'uint16');
  a.echo4_window = fread(my_file, 1, 'uint16');
  a.echo5_window = fread(my_file, 1, 'uint16');
  a.echo6_window = fread(my_file, 1, 'uint16');
  a.echo7_window = fread(my_file, 1, 'uint16');
  a.echo8_window = fread(my_file, 1, 'uint16');
  a.echo8_level = fread(my_file, 1, 'int16');
  a.echo7_level = fread(my_file, 1, 'int16');
  a.echo6_level = fread(my_file, 1, 'int16');
  a.echo5_level = fread(my_file, 1, 'int16');
  a.echo4_level = fread(my_file, 1, 'int16');
  a.echo3_level = fread(my_file, 1, 'int16');
  a.echo2_level = fread(my_file, 1, 'int16');
  a.echo1_level = fread(my_file, 1, 'int16');
  a.se_no = fread(my_file, 1, 'int16');
  a.se_typ = fread(my_file, 1, 'int16');
  a.se_source = fread(my_file, 1, 'int16');
  a.se_plane = fread(my_file, 1, 'int16');
  a.scan_type = fread(my_file, 1, 'int16');
  a.se_uniq = fread(my_file, 1, 'int16');
  a.se_contrast = fread(my_file, 1, 'int16');
  a.se_pseq = fread(my_file, 1, 'int16');
  a.se_sortorder = fread(my_file, 1, 'int16');
  a.se_nacq = fread(my_file, 1, 'int16');
  a.xbasest = fread(my_file, 1, 'int16');
  a.xbaseend = fread(my_file, 1, 'int16');
  a.xenhst = fread(my_file, 1, 'int16');
  a.xenhend = fread(my_file, 1, 'int16');
  a.table_entry = fread(my_file, 1, 'int16');
  a.SwingAngle = fread(my_file, 1, 'int16');
  a.LateralOffset = fread(my_file, 1, 'int16');
  a.GradientCoil = fread(my_file, 1, 'int16');
  a.se_subtype = fread(my_file, 1, 'int16');
  a.BWRT = fread(my_file, 1, 'int16');
  a.assetcal_serno = fread(my_file, 1, 'int16');
  a.assetcal_scnno = fread(my_file, 1, 'int16');
  a.content_qualifn = fread(my_file, 1, 'int16');
  a.purecal_serno = fread(my_file, 1, 'int16');
  a.purecal_scnno = fread(my_file, 1, 'int16');
  a.ideal = fread(my_file, 1, 'int16');
  for id = 1 : 25
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  for id = 1 : 2
    a.se_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.se_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.se_suid(id) = fread(my_file, 1, 'char');
  end
  a.se_alloc_key = freadc(my_file, 13);
  a.se_diskid = fread(my_file, 1, 'char');
  a.se_desc = freadc(my_file, 65);
  a.pr_sysid = freadc(my_file, 9);
  a.pansysid = freadc(my_file, 9);
  a.anref = freadc(my_file, 3);
  a.prtcl = freadc(my_file, 25);
  a.start_ras = fread(my_file, 1, 'char');
  a.end_ras = fread(my_file, 1, 'char');
  for id = 1 : 32
    a.series_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.landmark_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.equipmnt_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitval(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.schacitmea(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.schprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.perprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.perprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id1 = 1 : 4
    for id2 = 1 : 32
        a.refImgUID(id1,id2) = fread(my_file, 1, 'char');
    end
  end
  for id = 1 : 64
    a.PdgmStr(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 256
    a.PdgmDesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.PdgmUID(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplName(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplVer(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 12
    a.asset_appl(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_a(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_s(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_c(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.pure_cfg_params(id) = fread(my_file, 1, 'char');
  end
  a.operator_new = freadc(my_file, 65);
  for id = 1 : 150
    a.se_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 16.000
if rdbm_rev == 16.000 
  for id = 1 : 7
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.se_pds_a = fread(my_file, 1, 'float32');
  a.se_pds_c = fread(my_file, 1, 'float32');
  a.se_pds_u = fread(my_file, 1, 'float32');
  a.lmhor = fread(my_file, 1, 'float32');
  a.start_loc = fread(my_file, 1, 'float32');
  a.end_loc = fread(my_file, 1, 'float32');
  a.echo1_alpha = fread(my_file, 1, 'float32');
  a.echo1_beta = fread(my_file, 1, 'float32');
  a.echo2_alpha = fread(my_file, 1, 'float32');
  a.echo2_beta = fread(my_file, 1, 'float32');
  a.echo3_alpha = fread(my_file, 1, 'float32');
  a.echo3_beta = fread(my_file, 1, 'float32');
  a.echo4_alpha = fread(my_file, 1, 'float32');
  a.echo4_beta = fread(my_file, 1, 'float32');
  a.echo5_alpha = fread(my_file, 1, 'float32');
  a.echo5_beta = fread(my_file, 1, 'float32');
  a.echo6_alpha = fread(my_file, 1, 'float32');
  a.echo6_beta = fread(my_file, 1, 'float32');
  a.echo7_alpha = fread(my_file, 1, 'float32');
  a.echo7_beta = fread(my_file, 1, 'float32');
  a.echo8_alpha = fread(my_file, 1, 'float32');
  a.echo8_beta = fread(my_file, 1, 'float32');
  for id = 1 : 8
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.se_checksum = fread(my_file, 1, 'uint32');
  a.se_complete = fread(my_file, 1, 'int32');
  a.se_numarch = fread(my_file, 1, 'int32');
  a.se_imagect = fread(my_file, 1, 'int32');
  a.se_numimages = fread(my_file, 1, 'int32');
  a.se_delta_cnt = fread(my_file, 1, 'int32');
  a.se_numunimg = fread(my_file, 1, 'int32');
  a.se_toarchcnt = fread(my_file, 1, 'int32');
  for id = 1 : 8
    a.long_padding(id) = fread(my_file, 1, 'int32');
  end
  a.se_datetime = fread(my_file, 1, 'int32');
  a.se_actual_dt = fread(my_file, 1, 'int32');
  a.position = fread(my_file, 1, 'int32');
  a.entry = fread(my_file, 1, 'int32');
  a.se_lndmrkcnt = fread(my_file, 1, 'int32');
  a.se_lastmod = fread(my_file, 1, 'int32');
  a.ExpType = fread(my_file, 1, 'int32');
  a.TrRest = fread(my_file, 1, 'int32');
  a.TrActive = fread(my_file, 1, 'int32');
  a.DumAcq = fread(my_file, 1, 'int32');
  a.ExptTimePts = fread(my_file, 1, 'int32');
  for id = 1 : 16
    a.int_padding(id) = fread(my_file, 1, 'int32');
  end
  a.se_exno = fread(my_file, 1, 'uint16');
  a.echo1_window = fread(my_file, 1, 'uint16');
  a.echo2_window = fread(my_file, 1, 'uint16');
  a.echo3_window = fread(my_file, 1, 'uint16');
  a.echo4_window = fread(my_file, 1, 'uint16');
  a.echo5_window = fread(my_file, 1, 'uint16');
  a.echo6_window = fread(my_file, 1, 'uint16');
  a.echo7_window = fread(my_file, 1, 'uint16');
  a.echo8_window = fread(my_file, 1, 'uint16');
  a.echo8_level = fread(my_file, 1, 'int16');
  a.echo7_level = fread(my_file, 1, 'int16');
  a.echo6_level = fread(my_file, 1, 'int16');
  a.echo5_level = fread(my_file, 1, 'int16');
  a.echo4_level = fread(my_file, 1, 'int16');
  a.echo3_level = fread(my_file, 1, 'int16');
  a.echo2_level = fread(my_file, 1, 'int16');
  a.echo1_level = fread(my_file, 1, 'int16');
  a.se_no = fread(my_file, 1, 'int16');
  a.se_typ = fread(my_file, 1, 'int16');
  a.se_source = fread(my_file, 1, 'int16');
  a.se_plane = fread(my_file, 1, 'int16');
  a.scan_type = fread(my_file, 1, 'int16');
  a.se_uniq = fread(my_file, 1, 'int16');
  a.se_contrast = fread(my_file, 1, 'int16');
  a.se_pseq = fread(my_file, 1, 'int16');
  a.se_sortorder = fread(my_file, 1, 'int16');
  a.se_nacq = fread(my_file, 1, 'int16');
  a.xbasest = fread(my_file, 1, 'int16');
  a.xbaseend = fread(my_file, 1, 'int16');
  a.xenhst = fread(my_file, 1, 'int16');
  a.xenhend = fread(my_file, 1, 'int16');
  a.table_entry = fread(my_file, 1, 'int16');
  a.SwingAngle = fread(my_file, 1, 'int16');
  a.LateralOffset = fread(my_file, 1, 'int16');
  a.GradientCoil = fread(my_file, 1, 'int16');
  a.se_subtype = fread(my_file, 1, 'int16');
  a.BWRT = fread(my_file, 1, 'int16');
  a.assetcal_serno = fread(my_file, 1, 'int16');
  a.assetcal_scnno = fread(my_file, 1, 'int16');
  a.content_qualifn = fread(my_file, 1, 'int16');
  a.purecal_serno = fread(my_file, 1, 'int16');
  a.purecal_scnno = fread(my_file, 1, 'int16');
  a.ideal = fread(my_file, 1, 'int16');
  for id = 1 : 25
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  for id = 1 : 2
    a.se_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.se_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.se_suid(id) = fread(my_file, 1, 'char');
  end
  a.se_alloc_key = freadc(my_file, 13);
  a.se_diskid = fread(my_file, 1, 'char');
  a.se_desc = freadc(my_file, 65);
  a.pr_sysid = freadc(my_file, 9);
  a.pansysid = freadc(my_file, 9);
  a.anref = freadc(my_file, 3);
  a.prtcl = freadc(my_file, 25);
  a.start_ras = fread(my_file, 1, 'char');
  a.end_ras = fread(my_file, 1, 'char');
  for id = 1 : 32
    a.series_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.landmark_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.equipmnt_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitval(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.schacitmea(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.schprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.perprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.perprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id1 = 1 : 4
    for id2 = 1 : 32
        a.refImgUID(id1,id2) = fread(my_file, 1, 'char');
    end
  end
  for id = 1 : 64
    a.PdgmStr(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 256
    a.PdgmDesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.PdgmUID(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplName(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplVer(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 12
    a.asset_appl(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_a(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_s(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_c(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.pure_cfg_params(id) = fread(my_file, 1, 'char');
  end
  a.operator_new = freadc(my_file, 65);
  for id = 1 : 150
    a.se_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 20.001
if rdbm_rev == 20.001 
  for id = 1 : 7
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.se_pds_a = fread(my_file, 1, 'float32');
  a.se_pds_c = fread(my_file, 1, 'float32');
  a.se_pds_u = fread(my_file, 1, 'float32');
  a.lmhor = fread(my_file, 1, 'float32');
  a.start_loc = fread(my_file, 1, 'float32');
  a.end_loc = fread(my_file, 1, 'float32');
  a.echo1_alpha = fread(my_file, 1, 'float32');
  a.echo1_beta = fread(my_file, 1, 'float32');
  a.echo2_alpha = fread(my_file, 1, 'float32');
  a.echo2_beta = fread(my_file, 1, 'float32');
  a.echo3_alpha = fread(my_file, 1, 'float32');
  a.echo3_beta = fread(my_file, 1, 'float32');
  a.echo4_alpha = fread(my_file, 1, 'float32');
  a.echo4_beta = fread(my_file, 1, 'float32');
  a.echo5_alpha = fread(my_file, 1, 'float32');
  a.echo5_beta = fread(my_file, 1, 'float32');
  a.echo6_alpha = fread(my_file, 1, 'float32');
  a.echo6_beta = fread(my_file, 1, 'float32');
  a.echo7_alpha = fread(my_file, 1, 'float32');
  a.echo7_beta = fread(my_file, 1, 'float32');
  a.echo8_alpha = fread(my_file, 1, 'float32');
  a.echo8_beta = fread(my_file, 1, 'float32');
  for id = 1 : 8
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.se_checksum = fread(my_file, 1, 'uint32');
  a.se_complete = fread(my_file, 1, 'int32');
  a.se_numarch = fread(my_file, 1, 'int32');
  a.se_imagect = fread(my_file, 1, 'int32');
  a.se_numimages = fread(my_file, 1, 'int32');
  a.se_delta_cnt = fread(my_file, 1, 'int32');
  a.se_numunimg = fread(my_file, 1, 'int32');
  a.se_toarchcnt = fread(my_file, 1, 'int32');
  for id = 1 : 8
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.se_datetime = fread(my_file, 1, 'int32');
  a.se_actual_dt = fread(my_file, 1, 'int32');
  a.position = fread(my_file, 1, 'int32');
  a.entry = fread(my_file, 1, 'int32');
  a.se_lndmrkcnt = fread(my_file, 1, 'int32');
  a.se_lastmod = fread(my_file, 1, 'int32');
  a.ExpType = fread(my_file, 1, 'int32');
  a.TrRest = fread(my_file, 1, 'int32');
  a.TrActive = fread(my_file, 1, 'int32');
  a.DumAcq = fread(my_file, 1, 'int32');
  a.ExptTimePts = fread(my_file, 1, 'int32');
  for id = 1 : 16
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.se_exno = fread(my_file, 1, 'uint16');
  a.echo1_window = fread(my_file, 1, 'uint16');
  a.echo2_window = fread(my_file, 1, 'uint16');
  a.echo3_window = fread(my_file, 1, 'uint16');
  a.echo4_window = fread(my_file, 1, 'uint16');
  a.echo5_window = fread(my_file, 1, 'uint16');
  a.echo6_window = fread(my_file, 1, 'uint16');
  a.echo7_window = fread(my_file, 1, 'uint16');
  a.echo8_window = fread(my_file, 1, 'uint16');
  a.echo8_level = fread(my_file, 1, 'int16');
  a.echo7_level = fread(my_file, 1, 'int16');
  a.echo6_level = fread(my_file, 1, 'int16');
  a.echo5_level = fread(my_file, 1, 'int16');
  a.echo4_level = fread(my_file, 1, 'int16');
  a.echo3_level = fread(my_file, 1, 'int16');
  a.echo2_level = fread(my_file, 1, 'int16');
  a.echo1_level = fread(my_file, 1, 'int16');
  a.se_no = fread(my_file, 1, 'int16');
  a.se_typ = fread(my_file, 1, 'int16');
  a.se_source = fread(my_file, 1, 'int16');
  a.se_plane = fread(my_file, 1, 'int16');
  a.scan_type = fread(my_file, 1, 'int16');
  a.se_uniq = fread(my_file, 1, 'int16');
  a.se_contrast = fread(my_file, 1, 'int16');
  a.se_pseq = fread(my_file, 1, 'int16');
  a.se_sortorder = fread(my_file, 1, 'int16');
  a.se_nacq = fread(my_file, 1, 'int16');
  a.xbasest = fread(my_file, 1, 'int16');
  a.xbaseend = fread(my_file, 1, 'int16');
  a.xenhst = fread(my_file, 1, 'int16');
  a.xenhend = fread(my_file, 1, 'int16');
  a.table_entry = fread(my_file, 1, 'int16');
  a.SwingAngle = fread(my_file, 1, 'int16');
  a.LateralOffset = fread(my_file, 1, 'int16');
  a.GradientCoil = fread(my_file, 1, 'int16');
  a.se_subtype = fread(my_file, 1, 'int16');
  a.BWRT = fread(my_file, 1, 'int16');
  a.assetcal_serno = fread(my_file, 1, 'int16');
  a.assetcal_scnno = fread(my_file, 1, 'int16');
  a.content_qualifn = fread(my_file, 1, 'int16');
  a.purecal_serno = fread(my_file, 1, 'int16');
  a.purecal_scnno = fread(my_file, 1, 'int16');
  for id = 1 : 26
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  for id = 1 : 2
    a.se_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.se_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.se_suid(id) = fread(my_file, 1, 'char');
  end
  a.se_alloc_key = freadc(my_file, 13);
  a.se_diskid = fread(my_file, 1, 'char');
  a.se_desc = freadc(my_file, 65);
  a.pr_sysid = freadc(my_file, 9);
  a.pansysid = freadc(my_file, 9);
  a.anref = freadc(my_file, 3);
  a.prtcl = freadc(my_file, 25);
  a.start_ras = fread(my_file, 1, 'char');
  a.end_ras = fread(my_file, 1, 'char');
  for id = 1 : 32
    a.series_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.landmark_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.equipmnt_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitval(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.schacitmea(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.schprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.perprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.perprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id1 = 1 : 4
    for id2 = 1 : 32
        a.refImgUID(id1,id2) = fread(my_file, 1, 'char');
    end
  end
  for id = 1 : 64
    a.PdgmStr(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 256
    a.PdgmDesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.PdgmUID(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplName(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplVer(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 12
    a.asset_appl(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_a(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_s(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_c(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.pure_cfg_params(id) = fread(my_file, 1, 'char');
  end
  a.operator_new = freadc(my_file, 65);
  for id = 1 : 150
    a.se_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 20.002
if rdbm_rev == 20.002 
  for id = 1 : 7
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.se_pds_a = fread(my_file, 1, 'float32');
  a.se_pds_c = fread(my_file, 1, 'float32');
  a.se_pds_u = fread(my_file, 1, 'float32');
  a.lmhor = fread(my_file, 1, 'float32');
  a.start_loc = fread(my_file, 1, 'float32');
  a.end_loc = fread(my_file, 1, 'float32');
  a.echo1_alpha = fread(my_file, 1, 'float32');
  a.echo1_beta = fread(my_file, 1, 'float32');
  a.echo2_alpha = fread(my_file, 1, 'float32');
  a.echo2_beta = fread(my_file, 1, 'float32');
  a.echo3_alpha = fread(my_file, 1, 'float32');
  a.echo3_beta = fread(my_file, 1, 'float32');
  a.echo4_alpha = fread(my_file, 1, 'float32');
  a.echo4_beta = fread(my_file, 1, 'float32');
  a.echo5_alpha = fread(my_file, 1, 'float32');
  a.echo5_beta = fread(my_file, 1, 'float32');
  a.echo6_alpha = fread(my_file, 1, 'float32');
  a.echo6_beta = fread(my_file, 1, 'float32');
  a.echo7_alpha = fread(my_file, 1, 'float32');
  a.echo7_beta = fread(my_file, 1, 'float32');
  a.echo8_alpha = fread(my_file, 1, 'float32');
  a.echo8_beta = fread(my_file, 1, 'float32');
  for id = 1 : 8
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.se_checksum = fread(my_file, 1, 'uint32');
  a.se_complete = fread(my_file, 1, 'int32');
  a.se_numarch = fread(my_file, 1, 'int32');
  a.se_imagect = fread(my_file, 1, 'int32');
  a.se_numimages = fread(my_file, 1, 'int32');
  a.se_delta_cnt = fread(my_file, 1, 'int32');
  a.se_numunimg = fread(my_file, 1, 'int32');
  a.se_toarchcnt = fread(my_file, 1, 'int32');
  for id = 1 : 8
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.se_datetime = fread(my_file, 1, 'int32');
  a.se_actual_dt = fread(my_file, 1, 'int32');
  a.position = fread(my_file, 1, 'int32');
  a.entry = fread(my_file, 1, 'int32');
  a.se_lndmrkcnt = fread(my_file, 1, 'int32');
  a.se_lastmod = fread(my_file, 1, 'int32');
  a.ExpType = fread(my_file, 1, 'int32');
  a.TrRest = fread(my_file, 1, 'int32');
  a.TrActive = fread(my_file, 1, 'int32');
  a.DumAcq = fread(my_file, 1, 'int32');
  a.ExptTimePts = fread(my_file, 1, 'int32');
  for id = 1 : 16
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.se_exno = fread(my_file, 1, 'uint16');
  a.echo1_window = fread(my_file, 1, 'uint16');
  a.echo2_window = fread(my_file, 1, 'uint16');
  a.echo3_window = fread(my_file, 1, 'uint16');
  a.echo4_window = fread(my_file, 1, 'uint16');
  a.echo5_window = fread(my_file, 1, 'uint16');
  a.echo6_window = fread(my_file, 1, 'uint16');
  a.echo7_window = fread(my_file, 1, 'uint16');
  a.echo8_window = fread(my_file, 1, 'uint16');
  a.echo8_level = fread(my_file, 1, 'int16');
  a.echo7_level = fread(my_file, 1, 'int16');
  a.echo6_level = fread(my_file, 1, 'int16');
  a.echo5_level = fread(my_file, 1, 'int16');
  a.echo4_level = fread(my_file, 1, 'int16');
  a.echo3_level = fread(my_file, 1, 'int16');
  a.echo2_level = fread(my_file, 1, 'int16');
  a.echo1_level = fread(my_file, 1, 'int16');
  a.se_no = fread(my_file, 1, 'int16');
  a.se_typ = fread(my_file, 1, 'int16');
  a.se_source = fread(my_file, 1, 'int16');
  a.se_plane = fread(my_file, 1, 'int16');
  a.scan_type = fread(my_file, 1, 'int16');
  a.se_uniq = fread(my_file, 1, 'int16');
  a.se_contrast = fread(my_file, 1, 'int16');
  a.se_pseq = fread(my_file, 1, 'int16');
  a.se_sortorder = fread(my_file, 1, 'int16');
  a.se_nacq = fread(my_file, 1, 'int16');
  a.xbasest = fread(my_file, 1, 'int16');
  a.xbaseend = fread(my_file, 1, 'int16');
  a.xenhst = fread(my_file, 1, 'int16');
  a.xenhend = fread(my_file, 1, 'int16');
  a.table_entry = fread(my_file, 1, 'int16');
  a.SwingAngle = fread(my_file, 1, 'int16');
  a.LateralOffset = fread(my_file, 1, 'int16');
  a.GradientCoil = fread(my_file, 1, 'int16');
  a.se_subtype = fread(my_file, 1, 'int16');
  a.BWRT = fread(my_file, 1, 'int16');
  a.assetcal_serno = fread(my_file, 1, 'int16');
  a.assetcal_scnno = fread(my_file, 1, 'int16');
  a.content_qualifn = fread(my_file, 1, 'int16');
  a.purecal_serno = fread(my_file, 1, 'int16');
  a.purecal_scnno = fread(my_file, 1, 'int16');
  for id = 1 : 26
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  for id = 1 : 2
    a.se_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.se_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.se_suid(id) = fread(my_file, 1, 'char');
  end
  a.se_alloc_key = freadc(my_file, 13);
  a.se_diskid = fread(my_file, 1, 'char');
  a.se_desc = freadc(my_file, 65);
  a.pr_sysid = freadc(my_file, 9);
  a.pansysid = freadc(my_file, 9);
  a.anref = freadc(my_file, 3);
  a.prtcl = freadc(my_file, 25);
  a.start_ras = fread(my_file, 1, 'char');
  a.end_ras = fread(my_file, 1, 'char');
  for id = 1 : 32
    a.series_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.landmark_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.equipmnt_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitval(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.schacitmea(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.schprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.perprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.perprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id1 = 1 : 4
    for id2 = 1 : 32
        a.refImgUID(id1,id2) = fread(my_file, 1, 'char');
    end
  end
  for id = 1 : 64
    a.PdgmStr(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 256
    a.PdgmDesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.PdgmUID(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplName(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplVer(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 12
    a.asset_appl(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_a(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_s(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_c(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.pure_cfg_params(id) = fread(my_file, 1, 'char');
  end
  a.operator_new = freadc(my_file, 65);
  for id = 1 : 150
    a.se_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 20.003
if rdbm_rev == 20.003 
  for id = 1 : 7
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.se_pds_a = fread(my_file, 1, 'float32');
  a.se_pds_c = fread(my_file, 1, 'float32');
  a.se_pds_u = fread(my_file, 1, 'float32');
  a.lmhor = fread(my_file, 1, 'float32');
  a.start_loc = fread(my_file, 1, 'float32');
  a.end_loc = fread(my_file, 1, 'float32');
  a.echo1_alpha = fread(my_file, 1, 'float32');
  a.echo1_beta = fread(my_file, 1, 'float32');
  a.echo2_alpha = fread(my_file, 1, 'float32');
  a.echo2_beta = fread(my_file, 1, 'float32');
  a.echo3_alpha = fread(my_file, 1, 'float32');
  a.echo3_beta = fread(my_file, 1, 'float32');
  a.echo4_alpha = fread(my_file, 1, 'float32');
  a.echo4_beta = fread(my_file, 1, 'float32');
  a.echo5_alpha = fread(my_file, 1, 'float32');
  a.echo5_beta = fread(my_file, 1, 'float32');
  a.echo6_alpha = fread(my_file, 1, 'float32');
  a.echo6_beta = fread(my_file, 1, 'float32');
  a.echo7_alpha = fread(my_file, 1, 'float32');
  a.echo7_beta = fread(my_file, 1, 'float32');
  a.echo8_alpha = fread(my_file, 1, 'float32');
  a.echo8_beta = fread(my_file, 1, 'float32');
  for id = 1 : 8
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.se_checksum = fread(my_file, 1, 'uint32');
  a.se_complete = fread(my_file, 1, 'int32');
  a.se_numarch = fread(my_file, 1, 'int32');
  a.se_imagect = fread(my_file, 1, 'int32');
  a.se_numimages = fread(my_file, 1, 'int32');
  a.se_delta_cnt = fread(my_file, 1, 'int32');
  a.se_numunimg = fread(my_file, 1, 'int32');
  a.se_toarchcnt = fread(my_file, 1, 'int32');
  for id = 1 : 8
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.se_datetime = fread(my_file, 1, 'int32');
  a.se_actual_dt = fread(my_file, 1, 'int32');
  a.position = fread(my_file, 1, 'int32');
  a.entry = fread(my_file, 1, 'int32');
  a.se_lndmrkcnt = fread(my_file, 1, 'int32');
  a.se_lastmod = fread(my_file, 1, 'int32');
  a.ExpType = fread(my_file, 1, 'int32');
  a.TrRest = fread(my_file, 1, 'int32');
  a.TrActive = fread(my_file, 1, 'int32');
  a.DumAcq = fread(my_file, 1, 'int32');
  a.ExptTimePts = fread(my_file, 1, 'int32');
  for id = 1 : 16
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.se_exno = fread(my_file, 1, 'uint16');
  a.echo1_window = fread(my_file, 1, 'uint16');
  a.echo2_window = fread(my_file, 1, 'uint16');
  a.echo3_window = fread(my_file, 1, 'uint16');
  a.echo4_window = fread(my_file, 1, 'uint16');
  a.echo5_window = fread(my_file, 1, 'uint16');
  a.echo6_window = fread(my_file, 1, 'uint16');
  a.echo7_window = fread(my_file, 1, 'uint16');
  a.echo8_window = fread(my_file, 1, 'uint16');
  a.echo8_level = fread(my_file, 1, 'int16');
  a.echo7_level = fread(my_file, 1, 'int16');
  a.echo6_level = fread(my_file, 1, 'int16');
  a.echo5_level = fread(my_file, 1, 'int16');
  a.echo4_level = fread(my_file, 1, 'int16');
  a.echo3_level = fread(my_file, 1, 'int16');
  a.echo2_level = fread(my_file, 1, 'int16');
  a.echo1_level = fread(my_file, 1, 'int16');
  a.se_no = fread(my_file, 1, 'int16');
  a.se_typ = fread(my_file, 1, 'int16');
  a.se_source = fread(my_file, 1, 'int16');
  a.se_plane = fread(my_file, 1, 'int16');
  a.scan_type = fread(my_file, 1, 'int16');
  a.se_uniq = fread(my_file, 1, 'int16');
  a.se_contrast = fread(my_file, 1, 'int16');
  a.se_pseq = fread(my_file, 1, 'int16');
  a.se_sortorder = fread(my_file, 1, 'int16');
  a.se_nacq = fread(my_file, 1, 'int16');
  a.xbasest = fread(my_file, 1, 'int16');
  a.xbaseend = fread(my_file, 1, 'int16');
  a.xenhst = fread(my_file, 1, 'int16');
  a.xenhend = fread(my_file, 1, 'int16');
  a.table_entry = fread(my_file, 1, 'int16');
  a.SwingAngle = fread(my_file, 1, 'int16');
  a.LateralOffset = fread(my_file, 1, 'int16');
  a.GradientCoil = fread(my_file, 1, 'int16');
  a.se_subtype = fread(my_file, 1, 'int16');
  a.BWRT = fread(my_file, 1, 'int16');
  a.assetcal_serno = fread(my_file, 1, 'int16');
  a.assetcal_scnno = fread(my_file, 1, 'int16');
  a.content_qualifn = fread(my_file, 1, 'int16');
  a.purecal_serno = fread(my_file, 1, 'int16');
  a.purecal_scnno = fread(my_file, 1, 'int16');
  a.ideal = fread(my_file, 1, 'int16');
  for id = 1 : 25
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  for id = 1 : 2
    a.se_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.se_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.se_suid(id) = fread(my_file, 1, 'char');
  end
  a.se_alloc_key = freadc(my_file, 13);
  a.se_diskid = fread(my_file, 1, 'char');
  a.se_desc = freadc(my_file, 65);
  a.pr_sysid = freadc(my_file, 9);
  a.pansysid = freadc(my_file, 9);
  a.anref = freadc(my_file, 3);
  a.prtcl = freadc(my_file, 25);
  a.start_ras = fread(my_file, 1, 'char');
  a.end_ras = fread(my_file, 1, 'char');
  for id = 1 : 32
    a.series_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.landmark_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.equipmnt_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitval(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.schacitmea(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.schprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.perprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.perprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id1 = 1 : 4
    for id2 = 1 : 32
        a.refImgUID(id1,id2) = fread(my_file, 1, 'char');
    end
  end
  for id = 1 : 64
    a.PdgmStr(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 256
    a.PdgmDesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.PdgmUID(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplName(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplVer(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 12
    a.asset_appl(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_a(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_s(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_c(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.pure_cfg_params(id) = fread(my_file, 1, 'char');
  end
  a.operator_new = freadc(my_file, 65);
  for id = 1 : 150
    a.se_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 20.004
if rdbm_rev == 20.004 
  for id = 1 : 7
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.se_pds_a = fread(my_file, 1, 'float32');
  a.se_pds_c = fread(my_file, 1, 'float32');
  a.se_pds_u = fread(my_file, 1, 'float32');
  a.lmhor = fread(my_file, 1, 'float32');
  a.start_loc = fread(my_file, 1, 'float32');
  a.end_loc = fread(my_file, 1, 'float32');
  a.echo1_alpha = fread(my_file, 1, 'float32');
  a.echo1_beta = fread(my_file, 1, 'float32');
  a.echo2_alpha = fread(my_file, 1, 'float32');
  a.echo2_beta = fread(my_file, 1, 'float32');
  a.echo3_alpha = fread(my_file, 1, 'float32');
  a.echo3_beta = fread(my_file, 1, 'float32');
  a.echo4_alpha = fread(my_file, 1, 'float32');
  a.echo4_beta = fread(my_file, 1, 'float32');
  a.echo5_alpha = fread(my_file, 1, 'float32');
  a.echo5_beta = fread(my_file, 1, 'float32');
  a.echo6_alpha = fread(my_file, 1, 'float32');
  a.echo6_beta = fread(my_file, 1, 'float32');
  a.echo7_alpha = fread(my_file, 1, 'float32');
  a.echo7_beta = fread(my_file, 1, 'float32');
  a.echo8_alpha = fread(my_file, 1, 'float32');
  a.echo8_beta = fread(my_file, 1, 'float32');
  for id = 1 : 8
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.se_checksum = fread(my_file, 1, 'uint32');
  a.se_complete = fread(my_file, 1, 'int32');
  a.se_numarch = fread(my_file, 1, 'int32');
  a.se_imagect = fread(my_file, 1, 'int32');
  a.se_numimages = fread(my_file, 1, 'int32');
  a.se_delta_cnt = fread(my_file, 1, 'int32');
  a.se_numunimg = fread(my_file, 1, 'int32');
  a.se_toarchcnt = fread(my_file, 1, 'int32');
  for id = 1 : 8
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.se_datetime = fread(my_file, 1, 'int32');
  a.se_actual_dt = fread(my_file, 1, 'int32');
  a.position = fread(my_file, 1, 'int32');
  a.entry = fread(my_file, 1, 'int32');
  a.se_lndmrkcnt = fread(my_file, 1, 'int32');
  a.se_lastmod = fread(my_file, 1, 'int32');
  a.ExpType = fread(my_file, 1, 'int32');
  a.TrRest = fread(my_file, 1, 'int32');
  a.TrActive = fread(my_file, 1, 'int32');
  a.DumAcq = fread(my_file, 1, 'int32');
  a.ExptTimePts = fread(my_file, 1, 'int32');
  for id = 1 : 16
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.se_exno = fread(my_file, 1, 'uint16');
  a.echo1_window = fread(my_file, 1, 'uint16');
  a.echo2_window = fread(my_file, 1, 'uint16');
  a.echo3_window = fread(my_file, 1, 'uint16');
  a.echo4_window = fread(my_file, 1, 'uint16');
  a.echo5_window = fread(my_file, 1, 'uint16');
  a.echo6_window = fread(my_file, 1, 'uint16');
  a.echo7_window = fread(my_file, 1, 'uint16');
  a.echo8_window = fread(my_file, 1, 'uint16');
  a.echo8_level = fread(my_file, 1, 'int16');
  a.echo7_level = fread(my_file, 1, 'int16');
  a.echo6_level = fread(my_file, 1, 'int16');
  a.echo5_level = fread(my_file, 1, 'int16');
  a.echo4_level = fread(my_file, 1, 'int16');
  a.echo3_level = fread(my_file, 1, 'int16');
  a.echo2_level = fread(my_file, 1, 'int16');
  a.echo1_level = fread(my_file, 1, 'int16');
  a.se_no = fread(my_file, 1, 'int16');
  a.se_typ = fread(my_file, 1, 'int16');
  a.se_source = fread(my_file, 1, 'int16');
  a.se_plane = fread(my_file, 1, 'int16');
  a.scan_type = fread(my_file, 1, 'int16');
  a.se_uniq = fread(my_file, 1, 'int16');
  a.se_contrast = fread(my_file, 1, 'int16');
  a.se_pseq = fread(my_file, 1, 'int16');
  a.se_sortorder = fread(my_file, 1, 'int16');
  a.se_nacq = fread(my_file, 1, 'int16');
  a.xbasest = fread(my_file, 1, 'int16');
  a.xbaseend = fread(my_file, 1, 'int16');
  a.xenhst = fread(my_file, 1, 'int16');
  a.xenhend = fread(my_file, 1, 'int16');
  a.table_entry = fread(my_file, 1, 'int16');
  a.SwingAngle = fread(my_file, 1, 'int16');
  a.LateralOffset = fread(my_file, 1, 'int16');
  a.GradientCoil = fread(my_file, 1, 'int16');
  a.se_subtype = fread(my_file, 1, 'int16');
  a.BWRT = fread(my_file, 1, 'int16');
  a.assetcal_serno = fread(my_file, 1, 'int16');
  a.assetcal_scnno = fread(my_file, 1, 'int16');
  a.content_qualifn = fread(my_file, 1, 'int16');
  a.purecal_serno = fread(my_file, 1, 'int16');
  a.purecal_scnno = fread(my_file, 1, 'int16');
  a.ideal = fread(my_file, 1, 'int16');
  for id = 1 : 25
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  for id = 1 : 2
    a.se_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.se_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.se_suid(id) = fread(my_file, 1, 'char');
  end
  a.se_alloc_key = freadc(my_file, 13);
  a.se_diskid = fread(my_file, 1, 'char');
  a.se_desc = freadc(my_file, 65);
  a.pr_sysid = freadc(my_file, 9);
  a.pansysid = freadc(my_file, 9);
  a.anref = freadc(my_file, 3);
  a.prtcl = freadc(my_file, 25);
  a.start_ras = fread(my_file, 1, 'char');
  a.end_ras = fread(my_file, 1, 'char');
  for id = 1 : 32
    a.series_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.landmark_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.equipmnt_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitval(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.schacitmea(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.schprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.perprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.perprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id1 = 1 : 4
    for id2 = 1 : 32
        a.refImgUID(id1,id2) = fread(my_file, 1, 'char');
    end
  end
  for id = 1 : 64
    a.PdgmStr(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 256
    a.PdgmDesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.PdgmUID(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplName(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplVer(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 12
    a.asset_appl(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_a(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_s(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_c(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.pure_cfg_params(id) = fread(my_file, 1, 'char');
  end
  a.operator_new = freadc(my_file, 65);
  for id = 1 : 150
    a.se_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 20.005
if rdbm_rev == 20.005 
  for id = 1 : 32
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.se_pds_a = fread(my_file, 1, 'float32');
  a.se_pds_c = fread(my_file, 1, 'float32');
  a.se_pds_u = fread(my_file, 1, 'float32');
  a.lmhor = fread(my_file, 1, 'float32');
  a.start_loc = fread(my_file, 1, 'float32');
  a.end_loc = fread(my_file, 1, 'float32');
  a.echo1_alpha = fread(my_file, 1, 'float32');
  a.echo1_beta = fread(my_file, 1, 'float32');
  a.echo2_alpha = fread(my_file, 1, 'float32');
  a.echo2_beta = fread(my_file, 1, 'float32');
  a.echo3_alpha = fread(my_file, 1, 'float32');
  a.echo3_beta = fread(my_file, 1, 'float32');
  a.echo4_alpha = fread(my_file, 1, 'float32');
  a.echo4_beta = fread(my_file, 1, 'float32');
  a.echo5_alpha = fread(my_file, 1, 'float32');
  a.echo5_beta = fread(my_file, 1, 'float32');
  a.echo6_alpha = fread(my_file, 1, 'float32');
  a.echo6_beta = fread(my_file, 1, 'float32');
  a.echo7_alpha = fread(my_file, 1, 'float32');
  a.echo7_beta = fread(my_file, 1, 'float32');
  a.echo8_alpha = fread(my_file, 1, 'float32');
  a.echo8_beta = fread(my_file, 1, 'float32');
  for id = 1 : 32
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.se_complete = fread(my_file, 1, 'int32');
  a.se_numarch = fread(my_file, 1, 'int32');
  a.se_imagect = fread(my_file, 1, 'int32');
  a.se_numimages = fread(my_file, 1, 'int32');
  a.se_delta_cnt = fread(my_file, 1, 'int32');
  a.se_numunimg = fread(my_file, 1, 'int32');
  a.se_toarchcnt = fread(my_file, 1, 'int32');
  for id = 1 : 33
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.se_datetime = fread(my_file, 1, 'int32');
  a.se_actual_dt = fread(my_file, 1, 'int32');
  a.position = fread(my_file, 1, 'int32');
  a.entry = fread(my_file, 1, 'int32');
  a.se_lndmrkcnt = fread(my_file, 1, 'int32');
  a.se_lastmod = fread(my_file, 1, 'int32');
  a.ExpType = fread(my_file, 1, 'int32');
  a.TrRest = fread(my_file, 1, 'int32');
  a.TrActive = fread(my_file, 1, 'int32');
  a.DumAcq = fread(my_file, 1, 'int32');
  a.ExptTimePts = fread(my_file, 1, 'int32');
  for id = 1 : 33
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.se_exno = fread(my_file, 1, 'uint16');
  a.echo1_window = fread(my_file, 1, 'uint16');
  a.echo2_window = fread(my_file, 1, 'uint16');
  a.echo3_window = fread(my_file, 1, 'uint16');
  a.echo4_window = fread(my_file, 1, 'uint16');
  a.echo5_window = fread(my_file, 1, 'uint16');
  a.echo6_window = fread(my_file, 1, 'uint16');
  a.echo7_window = fread(my_file, 1, 'uint16');
  a.echo8_window = fread(my_file, 1, 'uint16');
  a.echo8_level = fread(my_file, 1, 'int16');
  a.echo7_level = fread(my_file, 1, 'int16');
  a.echo6_level = fread(my_file, 1, 'int16');
  a.echo5_level = fread(my_file, 1, 'int16');
  a.echo4_level = fread(my_file, 1, 'int16');
  a.echo3_level = fread(my_file, 1, 'int16');
  a.echo2_level = fread(my_file, 1, 'int16');
  a.echo1_level = fread(my_file, 1, 'int16');
  a.se_no = fread(my_file, 1, 'int16');
  a.se_typ = fread(my_file, 1, 'int16');
  a.se_source = fread(my_file, 1, 'int16');
  a.se_plane = fread(my_file, 1, 'int16');
  a.scan_type = fread(my_file, 1, 'int16');
  a.se_uniq = fread(my_file, 1, 'int16');
  a.se_contrast = fread(my_file, 1, 'int16');
  a.se_pseq = fread(my_file, 1, 'int16');
  a.se_sortorder = fread(my_file, 1, 'int16');
  a.se_nacq = fread(my_file, 1, 'int16');
  a.xbasest = fread(my_file, 1, 'int16');
  a.xbaseend = fread(my_file, 1, 'int16');
  a.xenhst = fread(my_file, 1, 'int16');
  a.xenhend = fread(my_file, 1, 'int16');
  a.table_entry = fread(my_file, 1, 'int16');
  a.SwingAngle = fread(my_file, 1, 'int16');
  a.LateralOffset = fread(my_file, 1, 'int16');
  a.GradientCoil = fread(my_file, 1, 'int16');
  a.se_subtype = fread(my_file, 1, 'int16');
  a.BWRT = fread(my_file, 1, 'int16');
  a.assetcal_serno = fread(my_file, 1, 'int16');
  a.assetcal_scnno = fread(my_file, 1, 'int16');
  a.content_qualifn = fread(my_file, 1, 'int16');
  a.purecal_serno = fread(my_file, 1, 'int16');
  a.purecal_scnno = fread(my_file, 1, 'int16');
  a.ideal = fread(my_file, 1, 'int16');
  for id = 1 : 33
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  for id = 1 : 2
    a.se_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.se_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.se_suid(id) = fread(my_file, 1, 'char');
  end
  a.se_alloc_key = freadc(my_file, 13);
  a.se_diskid = fread(my_file, 1, 'char');
  a.se_desc = freadc(my_file, 65);
  a.pr_sysid = freadc(my_file, 9);
  a.pansysid = freadc(my_file, 9);
  a.anref = freadc(my_file, 3);
  a.prtcl = freadc(my_file, 25);
  a.start_ras = fread(my_file, 1, 'char');
  a.end_ras = fread(my_file, 1, 'char');
  for id = 1 : 32
    a.series_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.landmark_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.equipmnt_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitval(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.schacitmea(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.schprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.perprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.perprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id1 = 1 : 4
    for id2 = 1 : 32
        a.refImgUID(id1,id2) = fread(my_file, 1, 'char');
    end
  end
  for id = 1 : 64
    a.PdgmStr(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 256
    a.PdgmDesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.PdgmUID(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplName(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplVer(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 12
    a.asset_appl(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_a(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_s(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_c(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.pure_cfg_params(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 251
    a.se_padding(id) = fread(my_file, 1, 'char');
  end


end
% RDBM revision 20.006
if rdbm_rev == 20.006 
  for id = 1 : 32
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.se_pds_a = fread(my_file, 1, 'float32');
  a.se_pds_c = fread(my_file, 1, 'float32');
  a.se_pds_u = fread(my_file, 1, 'float32');
  a.lmhor = fread(my_file, 1, 'float32');
  a.start_loc = fread(my_file, 1, 'float32');
  a.end_loc = fread(my_file, 1, 'float32');
  a.echo1_alpha = fread(my_file, 1, 'float32');
  a.echo1_beta = fread(my_file, 1, 'float32');
  a.echo2_alpha = fread(my_file, 1, 'float32');
  a.echo2_beta = fread(my_file, 1, 'float32');
  a.echo3_alpha = fread(my_file, 1, 'float32');
  a.echo3_beta = fread(my_file, 1, 'float32');
  a.echo4_alpha = fread(my_file, 1, 'float32');
  a.echo4_beta = fread(my_file, 1, 'float32');
  a.echo5_alpha = fread(my_file, 1, 'float32');
  a.echo5_beta = fread(my_file, 1, 'float32');
  a.echo6_alpha = fread(my_file, 1, 'float32');
  a.echo6_beta = fread(my_file, 1, 'float32');
  a.echo7_alpha = fread(my_file, 1, 'float32');
  a.echo7_beta = fread(my_file, 1, 'float32');
  a.echo8_alpha = fread(my_file, 1, 'float32');
  a.echo8_beta = fread(my_file, 1, 'float32');
  a.landmark = fread(my_file, 1, 'float32');
  a.tablePosition = fread(my_file, 1, 'float32');
  a.pure_lambda = fread(my_file, 1, 'float32');
  a.pure_tuning_factor_surface = fread(my_file, 1, 'float32');
  a.pure_tuning_factor_body = fread(my_file, 1, 'float32');
  a.pure_derived_cal_fraction = fread(my_file, 1, 'float32');
  a.pure_derived_cal_reapodization = fread(my_file, 1, 'float32');
  for id = 1 : 25
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.se_complete = fread(my_file, 1, 'int32');
  a.se_numarch = fread(my_file, 1, 'int32');
  a.se_imagect = fread(my_file, 1, 'int32');
  a.se_numimages = fread(my_file, 1, 'int32');
  a.se_delta_cnt = fread(my_file, 1, 'int32');
  a.se_numunimg = fread(my_file, 1, 'int32');
  a.se_toarchcnt = fread(my_file, 1, 'int32');
  for id = 1 : 33
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.se_datetime = fread(my_file, 1, 'int32');
  a.se_actual_dt = fread(my_file, 1, 'int32');
  a.position = fread(my_file, 1, 'int32');
  a.entry = fread(my_file, 1, 'int32');
  a.se_lndmrkcnt = fread(my_file, 1, 'int32');
  a.se_lastmod = fread(my_file, 1, 'int32');
  a.ExpType = fread(my_file, 1, 'int32');
  a.TrRest = fread(my_file, 1, 'int32');
  a.TrActive = fread(my_file, 1, 'int32');
  a.DumAcq = fread(my_file, 1, 'int32');
  a.ExptTimePts = fread(my_file, 1, 'int32');
  a.cal_pass_set_vector = fread(my_file, 1, 'int32');
  a.cal_nex_vector = fread(my_file, 1, 'int32');
  a.cal_weight_vector = fread(my_file, 1, 'int32');
  a.pure_filtering_mode = fread(my_file, 1, 'int32');
  for id = 1 : 29
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.se_exno = fread(my_file, 1, 'uint16');
  a.echo1_window = fread(my_file, 1, 'uint16');
  a.echo2_window = fread(my_file, 1, 'uint16');
  a.echo3_window = fread(my_file, 1, 'uint16');
  a.echo4_window = fread(my_file, 1, 'uint16');
  a.echo5_window = fread(my_file, 1, 'uint16');
  a.echo6_window = fread(my_file, 1, 'uint16');
  a.echo7_window = fread(my_file, 1, 'uint16');
  a.echo8_window = fread(my_file, 1, 'uint16');
  a.echo8_level = fread(my_file, 1, 'int16');
  a.echo7_level = fread(my_file, 1, 'int16');
  a.echo6_level = fread(my_file, 1, 'int16');
  a.echo5_level = fread(my_file, 1, 'int16');
  a.echo4_level = fread(my_file, 1, 'int16');
  a.echo3_level = fread(my_file, 1, 'int16');
  a.echo2_level = fread(my_file, 1, 'int16');
  a.echo1_level = fread(my_file, 1, 'int16');
  a.se_no = fread(my_file, 1, 'int16');
  a.se_typ = fread(my_file, 1, 'int16');
  a.se_source = fread(my_file, 1, 'int16');
  a.se_plane = fread(my_file, 1, 'int16');
  a.scan_type = fread(my_file, 1, 'int16');
  a.se_uniq = fread(my_file, 1, 'int16');
  a.se_contrast = fread(my_file, 1, 'int16');
  a.se_pseq = fread(my_file, 1, 'int16');
  a.se_sortorder = fread(my_file, 1, 'int16');
  a.se_nacq = fread(my_file, 1, 'int16');
  a.xbasest = fread(my_file, 1, 'int16');
  a.xbaseend = fread(my_file, 1, 'int16');
  a.xenhst = fread(my_file, 1, 'int16');
  a.xenhend = fread(my_file, 1, 'int16');
  a.table_entry = fread(my_file, 1, 'int16');
  a.SwingAngle = fread(my_file, 1, 'int16');
  a.LateralOffset = fread(my_file, 1, 'int16');
  a.GradientCoil = fread(my_file, 1, 'int16');
  a.se_subtype = fread(my_file, 1, 'int16');
  a.BWRT = fread(my_file, 1, 'int16');
  a.assetcal_serno = fread(my_file, 1, 'int16');
  a.assetcal_scnno = fread(my_file, 1, 'int16');
  a.content_qualifn = fread(my_file, 1, 'int16');
  a.purecal_serno = fread(my_file, 1, 'int16');
  a.purecal_scnno = fread(my_file, 1, 'int16');
  a.ideal = fread(my_file, 1, 'int16');
  a.verify_corners = fread(my_file, 1, 'int16');
  a.asset_cal_type = fread(my_file, 1, 'int16');
  a.pure_compatible = fread(my_file, 1, 'int16');
  a.purecal_type = fread(my_file, 1, 'int16');
  for id = 1 : 29
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  for id = 1 : 2
    a.se_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.se_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.se_suid(id) = fread(my_file, 1, 'char');
  end
  a.se_alloc_key = freadc(my_file, 13);
  a.se_diskid = fread(my_file, 1, 'char');
  a.se_desc = freadc(my_file, 65);
  a.pr_sysid = freadc(my_file, 9);
  a.pansysid = freadc(my_file, 9);
  a.anref = freadc(my_file, 3);
  a.prtcl = freadc(my_file, 25);
  a.start_ras = fread(my_file, 1, 'char');
  a.end_ras = fread(my_file, 1, 'char');
  for id = 1 : 32
    a.series_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.landmark_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.equipmnt_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitval(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.schacitmea(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.schprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.perprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.perprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id1 = 1 : 4
    for id2 = 1 : 32
        a.refImgUID(id1,id2) = fread(my_file, 1, 'char');
    end
  end
  for id = 1 : 64
    a.PdgmStr(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 256
    a.PdgmDesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.PdgmUID(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplName(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplVer(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 12
    a.asset_appl(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_a(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_s(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_c(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.pure_cfg_params(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 251
    a.se_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 20.007
if rdbm_rev == 20.007 
  for id = 1 : 32
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.se_pds_a = fread(my_file, 1, 'float32');
  a.se_pds_c = fread(my_file, 1, 'float32');
  a.se_pds_u = fread(my_file, 1, 'float32');
  a.lmhor = fread(my_file, 1, 'float32');
  a.start_loc = fread(my_file, 1, 'float32');
  a.end_loc = fread(my_file, 1, 'float32');
  a.echo1_alpha = fread(my_file, 1, 'float32');
  a.echo1_beta = fread(my_file, 1, 'float32');
  a.echo2_alpha = fread(my_file, 1, 'float32');
  a.echo2_beta = fread(my_file, 1, 'float32');
  a.echo3_alpha = fread(my_file, 1, 'float32');
  a.echo3_beta = fread(my_file, 1, 'float32');
  a.echo4_alpha = fread(my_file, 1, 'float32');
  a.echo4_beta = fread(my_file, 1, 'float32');
  a.echo5_alpha = fread(my_file, 1, 'float32');
  a.echo5_beta = fread(my_file, 1, 'float32');
  a.echo6_alpha = fread(my_file, 1, 'float32');
  a.echo6_beta = fread(my_file, 1, 'float32');
  a.echo7_alpha = fread(my_file, 1, 'float32');
  a.echo7_beta = fread(my_file, 1, 'float32');
  a.echo8_alpha = fread(my_file, 1, 'float32');
  a.echo8_beta = fread(my_file, 1, 'float32');
  a.landmark = fread(my_file, 1, 'float32');
  a.tablePosition = fread(my_file, 1, 'float32');
  for id = 1 : 30
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.se_complete = fread(my_file, 1, 'int32');
  a.se_numarch = fread(my_file, 1, 'int32');
  a.se_imagect = fread(my_file, 1, 'int32');
  a.se_numimages = fread(my_file, 1, 'int32');
  a.se_delta_cnt = fread(my_file, 1, 'int32');
  a.se_numunimg = fread(my_file, 1, 'int32');
  a.se_toarchcnt = fread(my_file, 1, 'int32');
  for id = 1 : 33
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.se_datetime = fread(my_file, 1, 'int32');
  a.se_actual_dt = fread(my_file, 1, 'int32');
  a.position = fread(my_file, 1, 'int32');
  a.entry = fread(my_file, 1, 'int32');
  a.se_lndmrkcnt = fread(my_file, 1, 'int32');
  a.se_lastmod = fread(my_file, 1, 'int32');
  a.ExpType = fread(my_file, 1, 'int32');
  a.TrRest = fread(my_file, 1, 'int32');
  a.TrActive = fread(my_file, 1, 'int32');
  a.DumAcq = fread(my_file, 1, 'int32');
  a.ExptTimePts = fread(my_file, 1, 'int32');
  for id = 1 : 33
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.se_exno = fread(my_file, 1, 'uint16');
  a.echo1_window = fread(my_file, 1, 'uint16');
  a.echo2_window = fread(my_file, 1, 'uint16');
  a.echo3_window = fread(my_file, 1, 'uint16');
  a.echo4_window = fread(my_file, 1, 'uint16');
  a.echo5_window = fread(my_file, 1, 'uint16');
  a.echo6_window = fread(my_file, 1, 'uint16');
  a.echo7_window = fread(my_file, 1, 'uint16');
  a.echo8_window = fread(my_file, 1, 'uint16');
  a.echo8_level = fread(my_file, 1, 'int16');
  a.echo7_level = fread(my_file, 1, 'int16');
  a.echo6_level = fread(my_file, 1, 'int16');
  a.echo5_level = fread(my_file, 1, 'int16');
  a.echo4_level = fread(my_file, 1, 'int16');
  a.echo3_level = fread(my_file, 1, 'int16');
  a.echo2_level = fread(my_file, 1, 'int16');
  a.echo1_level = fread(my_file, 1, 'int16');
  a.se_no = fread(my_file, 1, 'int16');
  a.se_typ = fread(my_file, 1, 'int16');
  a.se_source = fread(my_file, 1, 'int16');
  a.se_plane = fread(my_file, 1, 'int16');
  a.scan_type = fread(my_file, 1, 'int16');
  a.se_uniq = fread(my_file, 1, 'int16');
  a.se_contrast = fread(my_file, 1, 'int16');
  a.se_pseq = fread(my_file, 1, 'int16');
  a.se_sortorder = fread(my_file, 1, 'int16');
  a.se_nacq = fread(my_file, 1, 'int16');
  a.xbasest = fread(my_file, 1, 'int16');
  a.xbaseend = fread(my_file, 1, 'int16');
  a.xenhst = fread(my_file, 1, 'int16');
  a.xenhend = fread(my_file, 1, 'int16');
  a.table_entry = fread(my_file, 1, 'int16');
  a.SwingAngle = fread(my_file, 1, 'int16');
  a.LateralOffset = fread(my_file, 1, 'int16');
  a.GradientCoil = fread(my_file, 1, 'int16');
  a.se_subtype = fread(my_file, 1, 'int16');
  a.BWRT = fread(my_file, 1, 'int16');
  a.assetcal_serno = fread(my_file, 1, 'int16');
  a.assetcal_scnno = fread(my_file, 1, 'int16');
  a.content_qualifn = fread(my_file, 1, 'int16');
  a.purecal_serno = fread(my_file, 1, 'int16');
  a.purecal_scnno = fread(my_file, 1, 'int16');
  a.ideal = fread(my_file, 1, 'int16');
  a.verify_corners = fread(my_file, 1, 'int16');
  for id = 1 : 32
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  for id = 1 : 2
    a.se_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.se_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.se_suid(id) = fread(my_file, 1, 'char');
  end
  a.se_alloc_key = freadc(my_file, 13);
  a.se_diskid = fread(my_file, 1, 'char');
  a.se_desc = freadc(my_file, 65);
  a.pr_sysid = freadc(my_file, 9);
  a.pansysid = freadc(my_file, 9);
  a.anref = freadc(my_file, 3);
  a.prtcl = freadc(my_file, 25);
  a.start_ras = fread(my_file, 1, 'char');
  a.end_ras = fread(my_file, 1, 'char');
  for id = 1 : 32
    a.series_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.landmark_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.equipmnt_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitval(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.schacitmea(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.schprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.perprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.perprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id1 = 1 : 4
    for id2 = 1 : 32
        a.refImgUID(id1,id2) = fread(my_file, 1, 'char');
    end
  end
  for id = 1 : 64
    a.PdgmStr(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 256
    a.PdgmDesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.PdgmUID(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplName(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplVer(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 12
    a.asset_appl(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_a(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_s(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_c(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.pure_cfg_params(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 251
    a.se_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 24.000
if rdbm_rev == 24.000 
  for id = 1 : 32
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.se_pds_a = fread(my_file, 1, 'float32');
  a.se_pds_c = fread(my_file, 1, 'float32');
  a.se_pds_u = fread(my_file, 1, 'float32');
  a.lmhor = fread(my_file, 1, 'float32');
  a.start_loc = fread(my_file, 1, 'float32');
  a.end_loc = fread(my_file, 1, 'float32');
  a.echo1_alpha = fread(my_file, 1, 'float32');
  a.echo1_beta = fread(my_file, 1, 'float32');
  a.echo2_alpha = fread(my_file, 1, 'float32');
  a.echo2_beta = fread(my_file, 1, 'float32');
  a.echo3_alpha = fread(my_file, 1, 'float32');
  a.echo3_beta = fread(my_file, 1, 'float32');
  a.echo4_alpha = fread(my_file, 1, 'float32');
  a.echo4_beta = fread(my_file, 1, 'float32');
  a.echo5_alpha = fread(my_file, 1, 'float32');
  a.echo5_beta = fread(my_file, 1, 'float32');
  a.echo6_alpha = fread(my_file, 1, 'float32');
  a.echo6_beta = fread(my_file, 1, 'float32');
  a.echo7_alpha = fread(my_file, 1, 'float32');
  a.echo7_beta = fread(my_file, 1, 'float32');
  a.echo8_alpha = fread(my_file, 1, 'float32');
  a.echo8_beta = fread(my_file, 1, 'float32');
  a.landmark = fread(my_file, 1, 'float32');
  a.tablePosition = fread(my_file, 1, 'float32');
  a.pure_lambda = fread(my_file, 1, 'float32');
  a.pure_tuning_factor_surface = fread(my_file, 1, 'float32');
  a.pure_tuning_factor_body = fread(my_file, 1, 'float32');
  a.pure_derived_cal_fraction = fread(my_file, 1, 'float32');
  a.pure_derived_cal_reapodization = fread(my_file, 1, 'float32');
  for id = 1 : 25
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.se_complete = fread(my_file, 1, 'int32');
  a.se_numarch = fread(my_file, 1, 'int32');
  a.se_imagect = fread(my_file, 1, 'int32');
  a.se_numimages = fread(my_file, 1, 'int32');
  a.se_delta_cnt = fread(my_file, 1, 'int32');
  a.se_numunimg = fread(my_file, 1, 'int32');
  a.se_toarchcnt = fread(my_file, 1, 'int32');
  for id = 1 : 33
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.se_datetime = fread(my_file, 1, 'int32');
  a.se_actual_dt = fread(my_file, 1, 'int32');
  a.position = fread(my_file, 1, 'int32');
  a.entry = fread(my_file, 1, 'int32');
  a.se_lndmrkcnt = fread(my_file, 1, 'int32');
  a.se_lastmod = fread(my_file, 1, 'int32');
  a.ExpType = fread(my_file, 1, 'int32');
  a.TrRest = fread(my_file, 1, 'int32');
  a.TrActive = fread(my_file, 1, 'int32');
  a.DumAcq = fread(my_file, 1, 'int32');
  a.ExptTimePts = fread(my_file, 1, 'int32');
  a.cal_pass_set_vector = fread(my_file, 1, 'int32');
  a.cal_nex_vector = fread(my_file, 1, 'int32');
  a.cal_weight_vector = fread(my_file, 1, 'int32');
  a.pure_filtering_mode = fread(my_file, 1, 'int32');
  a.isoVectorZ = fread(my_file, 1, 'int32');
  a.isMRAC = fread(my_file, 1, 'int32');
  for id = 1 : 27
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.se_exno = fread(my_file, 1, 'uint16');
  a.echo1_window = fread(my_file, 1, 'uint16');
  a.echo2_window = fread(my_file, 1, 'uint16');
  a.echo3_window = fread(my_file, 1, 'uint16');
  a.echo4_window = fread(my_file, 1, 'uint16');
  a.echo5_window = fread(my_file, 1, 'uint16');
  a.echo6_window = fread(my_file, 1, 'uint16');
  a.echo7_window = fread(my_file, 1, 'uint16');
  a.echo8_window = fread(my_file, 1, 'uint16');
  a.echo8_level = fread(my_file, 1, 'int16');
  a.echo7_level = fread(my_file, 1, 'int16');
  a.echo6_level = fread(my_file, 1, 'int16');
  a.echo5_level = fread(my_file, 1, 'int16');
  a.echo4_level = fread(my_file, 1, 'int16');
  a.echo3_level = fread(my_file, 1, 'int16');
  a.echo2_level = fread(my_file, 1, 'int16');
  a.echo1_level = fread(my_file, 1, 'int16');
  a.se_no = fread(my_file, 1, 'int16');
  a.se_typ = fread(my_file, 1, 'int16');
  a.se_source = fread(my_file, 1, 'int16');
  a.se_plane = fread(my_file, 1, 'int16');
  a.scan_type = fread(my_file, 1, 'int16');
  a.se_uniq = fread(my_file, 1, 'int16');
  a.se_contrast = fread(my_file, 1, 'int16');
  a.se_pseq = fread(my_file, 1, 'int16');
  a.se_sortorder = fread(my_file, 1, 'int16');
  a.se_nacq = fread(my_file, 1, 'int16');
  a.xbasest = fread(my_file, 1, 'int16');
  a.xbaseend = fread(my_file, 1, 'int16');
  a.xenhst = fread(my_file, 1, 'int16');
  a.xenhend = fread(my_file, 1, 'int16');
  a.table_entry = fread(my_file, 1, 'int16');
  a.SwingAngle = fread(my_file, 1, 'int16');
  a.LateralOffset = fread(my_file, 1, 'int16');
  a.GradientCoil = fread(my_file, 1, 'int16');
  a.se_subtype = fread(my_file, 1, 'int16');
  a.BWRT = fread(my_file, 1, 'int16');
  a.assetcal_serno = fread(my_file, 1, 'int16');
  a.assetcal_scnno = fread(my_file, 1, 'int16');
  a.content_qualifn = fread(my_file, 1, 'int16');
  a.purecal_serno = fread(my_file, 1, 'int16');
  a.purecal_scnno = fread(my_file, 1, 'int16');
  a.ideal = fread(my_file, 1, 'int16');
  a.verify_corners = fread(my_file, 1, 'int16');
  a.asset_cal_type = fread(my_file, 1, 'int16');
  a.pure_compatible = fread(my_file, 1, 'int16');
  a.purecal_type = fread(my_file, 1, 'int16');
  a.locMode = fread(my_file, 1, 'int16');
  for id = 1 : 28
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  for id = 1 : 2
    a.se_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.se_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.se_suid(id) = fread(my_file, 1, 'char');
  end
  a.se_alloc_key = freadc(my_file, 13);
  a.se_diskid = fread(my_file, 1, 'char');
  a.se_desc = freadc(my_file, 65);
  a.pr_sysid = freadc(my_file, 9);
  a.pansysid = freadc(my_file, 9);
  a.anref = freadc(my_file, 3);
  a.prtcl = freadc(my_file, 25);
  a.start_ras = fread(my_file, 1, 'char');
  a.end_ras = fread(my_file, 1, 'char');
  for id = 1 : 32
    a.series_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.landmark_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.equipmnt_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitval(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.schacitmea(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.schprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.perprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.perprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id1 = 1 : 4
    for id2 = 1 : 32
        a.refImgUID(id1,id2) = fread(my_file, 1, 'char');
    end
  end
  for id = 1 : 64
    a.PdgmStr(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 256
    a.PdgmDesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.PdgmUID(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplName(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplVer(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 12
    a.asset_appl(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_a(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_s(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_c(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.pure_cfg_params(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 30
    a.dzPETMR(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 221
    a.se_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 25.001
if rdbm_rev == 25.001 
  for id = 1 : 32
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.se_pds_a = fread(my_file, 1, 'float32');
  a.se_pds_c = fread(my_file, 1, 'float32');
  a.se_pds_u = fread(my_file, 1, 'float32');
  a.lmhor = fread(my_file, 1, 'float32');
  a.start_loc = fread(my_file, 1, 'float32');
  a.end_loc = fread(my_file, 1, 'float32');
  a.echo1_alpha = fread(my_file, 1, 'float32');
  a.echo1_beta = fread(my_file, 1, 'float32');
  a.echo2_alpha = fread(my_file, 1, 'float32');
  a.echo2_beta = fread(my_file, 1, 'float32');
  a.echo3_alpha = fread(my_file, 1, 'float32');
  a.echo3_beta = fread(my_file, 1, 'float32');
  a.echo4_alpha = fread(my_file, 1, 'float32');
  a.echo4_beta = fread(my_file, 1, 'float32');
  a.echo5_alpha = fread(my_file, 1, 'float32');
  a.echo5_beta = fread(my_file, 1, 'float32');
  a.echo6_alpha = fread(my_file, 1, 'float32');
  a.echo6_beta = fread(my_file, 1, 'float32');
  a.echo7_alpha = fread(my_file, 1, 'float32');
  a.echo7_beta = fread(my_file, 1, 'float32');
  a.echo8_alpha = fread(my_file, 1, 'float32');
  a.echo8_beta = fread(my_file, 1, 'float32');
  a.landmark = fread(my_file, 1, 'float32');
  a.tablePosition = fread(my_file, 1, 'float32');
  a.pure_lambda = fread(my_file, 1, 'float32');
  a.pure_tuning_factor_surface = fread(my_file, 1, 'float32');
  a.pure_tuning_factor_body = fread(my_file, 1, 'float32');
  a.pure_derived_cal_fraction = fread(my_file, 1, 'float32');
  a.pure_derived_cal_reapodization = fread(my_file, 1, 'float32');
  for id = 1 : 25
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.se_complete = fread(my_file, 1, 'int32');
  a.se_numarch = fread(my_file, 1, 'int32');
  a.se_imagect = fread(my_file, 1, 'int32');
  a.se_numimages = fread(my_file, 1, 'int32');
  a.se_delta_cnt = fread(my_file, 1, 'int32');
  a.se_numunimg = fread(my_file, 1, 'int32');
  a.se_toarchcnt = fread(my_file, 1, 'int32');
  for id = 1 : 33
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.se_datetime = fread(my_file, 1, 'int32');
  a.se_actual_dt = fread(my_file, 1, 'int32');
  a.position = fread(my_file, 1, 'int32');
  a.entry = fread(my_file, 1, 'int32');
  a.se_lndmrkcnt = fread(my_file, 1, 'int32');
  a.se_lastmod = fread(my_file, 1, 'int32');
  a.ExpType = fread(my_file, 1, 'int32');
  a.TrRest = fread(my_file, 1, 'int32');
  a.TrActive = fread(my_file, 1, 'int32');
  a.DumAcq = fread(my_file, 1, 'int32');
  a.ExptTimePts = fread(my_file, 1, 'int32');
  a.cal_pass_set_vector = fread(my_file, 1, 'int32');
  a.cal_nex_vector = fread(my_file, 1, 'int32');
  a.cal_weight_vector = fread(my_file, 1, 'int32');
  a.pure_filtering_mode = fread(my_file, 1, 'int32');
  a.isoVectorZ = fread(my_file, 1, 'int32');
  a.isMRAC = fread(my_file, 1, 'int32');
  for id = 1 : 27
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.se_exno = fread(my_file, 1, 'uint16');
  a.echo1_window = fread(my_file, 1, 'uint16');
  a.echo2_window = fread(my_file, 1, 'uint16');
  a.echo3_window = fread(my_file, 1, 'uint16');
  a.echo4_window = fread(my_file, 1, 'uint16');
  a.echo5_window = fread(my_file, 1, 'uint16');
  a.echo6_window = fread(my_file, 1, 'uint16');
  a.echo7_window = fread(my_file, 1, 'uint16');
  a.echo8_window = fread(my_file, 1, 'uint16');
  a.echo8_level = fread(my_file, 1, 'int16');
  a.echo7_level = fread(my_file, 1, 'int16');
  a.echo6_level = fread(my_file, 1, 'int16');
  a.echo5_level = fread(my_file, 1, 'int16');
  a.echo4_level = fread(my_file, 1, 'int16');
  a.echo3_level = fread(my_file, 1, 'int16');
  a.echo2_level = fread(my_file, 1, 'int16');
  a.echo1_level = fread(my_file, 1, 'int16');
  a.se_no = fread(my_file, 1, 'int16');
  a.se_typ = fread(my_file, 1, 'int16');
  a.se_source = fread(my_file, 1, 'int16');
  a.se_plane = fread(my_file, 1, 'int16');
  a.scan_type = fread(my_file, 1, 'int16');
  a.se_uniq = fread(my_file, 1, 'int16');
  a.se_contrast = fread(my_file, 1, 'int16');
  a.se_pseq = fread(my_file, 1, 'int16');
  a.se_sortorder = fread(my_file, 1, 'int16');
  a.se_nacq = fread(my_file, 1, 'int16');
  a.xbasest = fread(my_file, 1, 'int16');
  a.xbaseend = fread(my_file, 1, 'int16');
  a.xenhst = fread(my_file, 1, 'int16');
  a.xenhend = fread(my_file, 1, 'int16');
  a.table_entry = fread(my_file, 1, 'int16');
  a.SwingAngle = fread(my_file, 1, 'int16');
  a.LateralOffset = fread(my_file, 1, 'int16');
  a.GradientCoil = fread(my_file, 1, 'int16');
  a.se_subtype = fread(my_file, 1, 'int16');
  a.BWRT = fread(my_file, 1, 'int16');
  a.assetcal_serno = fread(my_file, 1, 'int16');
  a.assetcal_scnno = fread(my_file, 1, 'int16');
  a.content_qualifn = fread(my_file, 1, 'int16');
  a.purecal_serno = fread(my_file, 1, 'int16');
  a.purecal_scnno = fread(my_file, 1, 'int16');
  a.ideal = fread(my_file, 1, 'int16');
  a.verify_corners = fread(my_file, 1, 'int16');
  a.asset_cal_type = fread(my_file, 1, 'int16');
  a.pure_compatible = fread(my_file, 1, 'int16');
  a.purecal_type = fread(my_file, 1, 'int16');
  a.locMode = fread(my_file, 1, 'int16');
  for id = 1 : 28
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  for id = 1 : 2
    a.se_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.se_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.se_suid(id) = fread(my_file, 1, 'char');
  end
  a.se_alloc_key = freadc(my_file, 13);
  a.se_diskid = fread(my_file, 1, 'char');
  a.se_desc = freadc(my_file, 65);
  a.pr_sysid = freadc(my_file, 9);
  a.pansysid = freadc(my_file, 9);
  a.anref = freadc(my_file, 3);
  a.prtcl = freadc(my_file, 25);
  a.start_ras = fread(my_file, 1, 'char');
  a.end_ras = fread(my_file, 1, 'char');
  for id = 1 : 32
    a.series_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.landmark_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.equipmnt_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitval(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.schacitmea(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.schprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.perprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.perprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id1 = 1 : 4
    for id2 = 1 : 32
        a.refImgUID(id1,id2) = fread(my_file, 1, 'char');
    end
  end
  for id = 1 : 64
    a.PdgmStr(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 256
    a.PdgmDesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.PdgmUID(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplName(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplVer(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 12
    a.asset_appl(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_a(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_s(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_c(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.pure_cfg_params(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 30
    a.dzPETMR(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 221
    a.se_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 25.002
if rdbm_rev == 25.002 
  for id = 1 : 32
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.se_pds_a = fread(my_file, 1, 'float32');
  a.se_pds_c = fread(my_file, 1, 'float32');
  a.se_pds_u = fread(my_file, 1, 'float32');
  a.lmhor = fread(my_file, 1, 'float32');
  a.start_loc = fread(my_file, 1, 'float32');
  a.end_loc = fread(my_file, 1, 'float32');
  a.echo1_alpha = fread(my_file, 1, 'float32');
  a.echo1_beta = fread(my_file, 1, 'float32');
  a.echo2_alpha = fread(my_file, 1, 'float32');
  a.echo2_beta = fread(my_file, 1, 'float32');
  a.echo3_alpha = fread(my_file, 1, 'float32');
  a.echo3_beta = fread(my_file, 1, 'float32');
  a.echo4_alpha = fread(my_file, 1, 'float32');
  a.echo4_beta = fread(my_file, 1, 'float32');
  a.echo5_alpha = fread(my_file, 1, 'float32');
  a.echo5_beta = fread(my_file, 1, 'float32');
  a.echo6_alpha = fread(my_file, 1, 'float32');
  a.echo6_beta = fread(my_file, 1, 'float32');
  a.echo7_alpha = fread(my_file, 1, 'float32');
  a.echo7_beta = fread(my_file, 1, 'float32');
  a.echo8_alpha = fread(my_file, 1, 'float32');
  a.echo8_beta = fread(my_file, 1, 'float32');
  a.landmark = fread(my_file, 1, 'float32');
  a.tablePosition = fread(my_file, 1, 'float32');
  a.pure_lambda = fread(my_file, 1, 'float32');
  a.pure_tuning_factor_surface = fread(my_file, 1, 'float32');
  a.pure_tuning_factor_body = fread(my_file, 1, 'float32');
  a.pure_derived_cal_fraction = fread(my_file, 1, 'float32');
  a.pure_derived_cal_reapodization = fread(my_file, 1, 'float32');
  for id = 1 : 25
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.se_complete = fread(my_file, 1, 'int32');
  a.se_numarch = fread(my_file, 1, 'int32');
  a.se_imagect = fread(my_file, 1, 'int32');
  a.se_numimages = fread(my_file, 1, 'int32');
  a.se_delta_cnt = fread(my_file, 1, 'int32');
  a.se_numunimg = fread(my_file, 1, 'int32');
  a.se_toarchcnt = fread(my_file, 1, 'int32');
  for id = 1 : 33
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.se_datetime = fread(my_file, 1, 'int32');
  a.se_actual_dt = fread(my_file, 1, 'int32');
  a.position = fread(my_file, 1, 'int32');
  a.entry = fread(my_file, 1, 'int32');
  a.se_lndmrkcnt = fread(my_file, 1, 'int32');
  a.se_lastmod = fread(my_file, 1, 'int32');
  a.ExpType = fread(my_file, 1, 'int32');
  a.TrRest = fread(my_file, 1, 'int32');
  a.TrActive = fread(my_file, 1, 'int32');
  a.DumAcq = fread(my_file, 1, 'int32');
  a.ExptTimePts = fread(my_file, 1, 'int32');
  a.cal_pass_set_vector = fread(my_file, 1, 'int32');
  a.cal_nex_vector = fread(my_file, 1, 'int32');
  a.cal_weight_vector = fread(my_file, 1, 'int32');
  a.pure_filtering_mode = fread(my_file, 1, 'int32');
  a.isoVectorZ = fread(my_file, 1, 'int32');
  a.isMRAC = fread(my_file, 1, 'int32');
  for id = 1 : 27
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.se_exno = fread(my_file, 1, 'uint16');
  a.echo1_window = fread(my_file, 1, 'uint16');
  a.echo2_window = fread(my_file, 1, 'uint16');
  a.echo3_window = fread(my_file, 1, 'uint16');
  a.echo4_window = fread(my_file, 1, 'uint16');
  a.echo5_window = fread(my_file, 1, 'uint16');
  a.echo6_window = fread(my_file, 1, 'uint16');
  a.echo7_window = fread(my_file, 1, 'uint16');
  a.echo8_window = fread(my_file, 1, 'uint16');
  a.echo8_level = fread(my_file, 1, 'int16');
  a.echo7_level = fread(my_file, 1, 'int16');
  a.echo6_level = fread(my_file, 1, 'int16');
  a.echo5_level = fread(my_file, 1, 'int16');
  a.echo4_level = fread(my_file, 1, 'int16');
  a.echo3_level = fread(my_file, 1, 'int16');
  a.echo2_level = fread(my_file, 1, 'int16');
  a.echo1_level = fread(my_file, 1, 'int16');
  a.se_no = fread(my_file, 1, 'int16');
  a.se_typ = fread(my_file, 1, 'int16');
  a.se_source = fread(my_file, 1, 'int16');
  a.se_plane = fread(my_file, 1, 'int16');
  a.scan_type = fread(my_file, 1, 'int16');
  a.se_uniq = fread(my_file, 1, 'int16');
  a.se_contrast = fread(my_file, 1, 'int16');
  a.se_pseq = fread(my_file, 1, 'int16');
  a.se_sortorder = fread(my_file, 1, 'int16');
  a.se_nacq = fread(my_file, 1, 'int16');
  a.xbasest = fread(my_file, 1, 'int16');
  a.xbaseend = fread(my_file, 1, 'int16');
  a.xenhst = fread(my_file, 1, 'int16');
  a.xenhend = fread(my_file, 1, 'int16');
  a.table_entry = fread(my_file, 1, 'int16');
  a.SwingAngle = fread(my_file, 1, 'int16');
  a.LateralOffset = fread(my_file, 1, 'int16');
  a.GradientCoil = fread(my_file, 1, 'int16');
  a.se_subtype = fread(my_file, 1, 'int16');
  a.BWRT = fread(my_file, 1, 'int16');
  a.assetcal_serno = fread(my_file, 1, 'int16');
  a.assetcal_scnno = fread(my_file, 1, 'int16');
  a.content_qualifn = fread(my_file, 1, 'int16');
  a.purecal_serno = fread(my_file, 1, 'int16');
  a.purecal_scnno = fread(my_file, 1, 'int16');
  a.ideal = fread(my_file, 1, 'int16');
  a.verify_corners = fread(my_file, 1, 'int16');
  a.asset_cal_type = fread(my_file, 1, 'int16');
  a.pure_compatible = fread(my_file, 1, 'int16');
  a.purecal_type = fread(my_file, 1, 'int16');
  a.locMode = fread(my_file, 1, 'int16');
  for id = 1 : 28
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  for id = 1 : 2
    a.se_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.se_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.se_suid(id) = fread(my_file, 1, 'char');
  end
  a.se_alloc_key = freadc(my_file, 13);
  a.se_diskid = fread(my_file, 1, 'char');
  a.se_desc = freadc(my_file, 65);
  a.pr_sysid = freadc(my_file, 9);
  a.pansysid = freadc(my_file, 9);
  a.anref = freadc(my_file, 3);
  a.prtcl = freadc(my_file, 25);
  a.start_ras = fread(my_file, 1, 'char');
  a.end_ras = fread(my_file, 1, 'char');
  for id = 1 : 32
    a.series_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.landmark_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.equipmnt_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitval(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.schacitmea(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.schprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.perprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.perprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id1 = 1 : 4
    for id2 = 1 : 32
        a.refImgUID(id1,id2) = fread(my_file, 1, 'char');
    end
  end
  for id = 1 : 64
    a.PdgmStr(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 256
    a.PdgmDesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.PdgmUID(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplName(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplVer(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 12
    a.asset_appl(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_a(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_s(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_c(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.pure_cfg_params(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 30
    a.dzPETMR(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 221
    a.se_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 25.003
if rdbm_rev == 25.003 
  for id = 1 : 32
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.se_pds_a = fread(my_file, 1, 'float32');
  a.se_pds_c = fread(my_file, 1, 'float32');
  a.se_pds_u = fread(my_file, 1, 'float32');
  a.lmhor = fread(my_file, 1, 'float32');
  a.start_loc = fread(my_file, 1, 'float32');
  a.end_loc = fread(my_file, 1, 'float32');
  a.echo1_alpha = fread(my_file, 1, 'float32');
  a.echo1_beta = fread(my_file, 1, 'float32');
  a.echo2_alpha = fread(my_file, 1, 'float32');
  a.echo2_beta = fread(my_file, 1, 'float32');
  a.echo3_alpha = fread(my_file, 1, 'float32');
  a.echo3_beta = fread(my_file, 1, 'float32');
  a.echo4_alpha = fread(my_file, 1, 'float32');
  a.echo4_beta = fread(my_file, 1, 'float32');
  a.echo5_alpha = fread(my_file, 1, 'float32');
  a.echo5_beta = fread(my_file, 1, 'float32');
  a.echo6_alpha = fread(my_file, 1, 'float32');
  a.echo6_beta = fread(my_file, 1, 'float32');
  a.echo7_alpha = fread(my_file, 1, 'float32');
  a.echo7_beta = fread(my_file, 1, 'float32');
  a.echo8_alpha = fread(my_file, 1, 'float32');
  a.echo8_beta = fread(my_file, 1, 'float32');
  a.landmark = fread(my_file, 1, 'float32');
  a.tablePosition = fread(my_file, 1, 'float32');
  a.pure_lambda = fread(my_file, 1, 'float32');
  a.pure_tuning_factor_surface = fread(my_file, 1, 'float32');
  a.pure_tuning_factor_body = fread(my_file, 1, 'float32');
  a.pure_derived_cal_fraction = fread(my_file, 1, 'float32');
  a.pure_derived_cal_reapodization = fread(my_file, 1, 'float32');
  for id = 1 : 25
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.se_complete = fread(my_file, 1, 'int32');
  a.se_numarch = fread(my_file, 1, 'int32');
  a.se_imagect = fread(my_file, 1, 'int32');
  a.se_numimages = fread(my_file, 1, 'int32');
  a.se_delta_cnt = fread(my_file, 1, 'int32');
  a.se_numunimg = fread(my_file, 1, 'int32');
  a.se_toarchcnt = fread(my_file, 1, 'int32');
  for id = 1 : 33
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.se_datetime = fread(my_file, 1, 'int32');
  a.se_actual_dt = fread(my_file, 1, 'int32');
  a.position = fread(my_file, 1, 'int32');
  a.entry = fread(my_file, 1, 'int32');
  a.se_lndmrkcnt = fread(my_file, 1, 'int32');
  a.se_lastmod = fread(my_file, 1, 'int32');
  a.ExpType = fread(my_file, 1, 'int32');
  a.TrRest = fread(my_file, 1, 'int32');
  a.TrActive = fread(my_file, 1, 'int32');
  a.DumAcq = fread(my_file, 1, 'int32');
  a.ExptTimePts = fread(my_file, 1, 'int32');
  a.cal_pass_set_vector = fread(my_file, 1, 'int32');
  a.cal_nex_vector = fread(my_file, 1, 'int32');
  a.cal_weight_vector = fread(my_file, 1, 'int32');
  a.pure_filtering_mode = fread(my_file, 1, 'int32');
  a.isoVectorZ = fread(my_file, 1, 'int32');
  a.isMRAC = fread(my_file, 1, 'int32');
  for id = 1 : 27
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.se_exno = fread(my_file, 1, 'uint16');
  a.echo1_window = fread(my_file, 1, 'uint16');
  a.echo2_window = fread(my_file, 1, 'uint16');
  a.echo3_window = fread(my_file, 1, 'uint16');
  a.echo4_window = fread(my_file, 1, 'uint16');
  a.echo5_window = fread(my_file, 1, 'uint16');
  a.echo6_window = fread(my_file, 1, 'uint16');
  a.echo7_window = fread(my_file, 1, 'uint16');
  a.echo8_window = fread(my_file, 1, 'uint16');
  a.echo8_level = fread(my_file, 1, 'int16');
  a.echo7_level = fread(my_file, 1, 'int16');
  a.echo6_level = fread(my_file, 1, 'int16');
  a.echo5_level = fread(my_file, 1, 'int16');
  a.echo4_level = fread(my_file, 1, 'int16');
  a.echo3_level = fread(my_file, 1, 'int16');
  a.echo2_level = fread(my_file, 1, 'int16');
  a.echo1_level = fread(my_file, 1, 'int16');
  a.se_no = fread(my_file, 1, 'int16');
  a.se_typ = fread(my_file, 1, 'int16');
  a.se_source = fread(my_file, 1, 'int16');
  a.se_plane = fread(my_file, 1, 'int16');
  a.scan_type = fread(my_file, 1, 'int16');
  a.se_uniq = fread(my_file, 1, 'int16');
  a.se_contrast = fread(my_file, 1, 'int16');
  a.se_pseq = fread(my_file, 1, 'int16');
  a.se_sortorder = fread(my_file, 1, 'int16');
  a.se_nacq = fread(my_file, 1, 'int16');
  a.xbasest = fread(my_file, 1, 'int16');
  a.xbaseend = fread(my_file, 1, 'int16');
  a.xenhst = fread(my_file, 1, 'int16');
  a.xenhend = fread(my_file, 1, 'int16');
  a.table_entry = fread(my_file, 1, 'int16');
  a.SwingAngle = fread(my_file, 1, 'int16');
  a.LateralOffset = fread(my_file, 1, 'int16');
  a.GradientCoil = fread(my_file, 1, 'int16');
  a.se_subtype = fread(my_file, 1, 'int16');
  a.BWRT = fread(my_file, 1, 'int16');
  a.assetcal_serno = fread(my_file, 1, 'int16');
  a.assetcal_scnno = fread(my_file, 1, 'int16');
  a.content_qualifn = fread(my_file, 1, 'int16');
  a.purecal_serno = fread(my_file, 1, 'int16');
  a.purecal_scnno = fread(my_file, 1, 'int16');
  a.ideal = fread(my_file, 1, 'int16');
  a.verify_corners = fread(my_file, 1, 'int16');
  a.asset_cal_type = fread(my_file, 1, 'int16');
  a.pure_compatible = fread(my_file, 1, 'int16');
  a.purecal_type = fread(my_file, 1, 'int16');
  a.locMode = fread(my_file, 1, 'int16');
  for id = 1 : 28
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  for id = 1 : 2
    a.se_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.se_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.se_suid(id) = fread(my_file, 1, 'char');
  end
  a.se_alloc_key = freadc(my_file, 13);
  a.se_diskid = fread(my_file, 1, 'char');
  a.se_desc = freadc(my_file, 65);
  a.pr_sysid = freadc(my_file, 9);
  a.pansysid = freadc(my_file, 9);
  a.anref = freadc(my_file, 3);
  a.prtcl = freadc(my_file, 25);
  a.start_ras = fread(my_file, 1, 'char');
  a.end_ras = fread(my_file, 1, 'char');
  for id = 1 : 32
    a.series_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.landmark_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.equipmnt_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitval(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.schacitmea(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.schprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.perprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.perprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id1 = 1 : 4
    for id2 = 1 : 32
        a.refImgUID(id1,id2) = fread(my_file, 1, 'char');
    end
  end
  for id = 1 : 64
    a.PdgmStr(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 256
    a.PdgmDesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.PdgmUID(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplName(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplVer(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 12
    a.asset_appl(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_a(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_s(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_c(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.pure_cfg_params(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 30
    a.dzPETMR(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 221
    a.se_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 25.004
if rdbm_rev == 25.004 
  for id = 1 : 32
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.se_pds_a = fread(my_file, 1, 'float32');
  a.se_pds_c = fread(my_file, 1, 'float32');
  a.se_pds_u = fread(my_file, 1, 'float32');
  a.lmhor = fread(my_file, 1, 'float32');
  a.start_loc = fread(my_file, 1, 'float32');
  a.end_loc = fread(my_file, 1, 'float32');
  a.echo1_alpha = fread(my_file, 1, 'float32');
  a.echo1_beta = fread(my_file, 1, 'float32');
  a.echo2_alpha = fread(my_file, 1, 'float32');
  a.echo2_beta = fread(my_file, 1, 'float32');
  a.echo3_alpha = fread(my_file, 1, 'float32');
  a.echo3_beta = fread(my_file, 1, 'float32');
  a.echo4_alpha = fread(my_file, 1, 'float32');
  a.echo4_beta = fread(my_file, 1, 'float32');
  a.echo5_alpha = fread(my_file, 1, 'float32');
  a.echo5_beta = fread(my_file, 1, 'float32');
  a.echo6_alpha = fread(my_file, 1, 'float32');
  a.echo6_beta = fread(my_file, 1, 'float32');
  a.echo7_alpha = fread(my_file, 1, 'float32');
  a.echo7_beta = fread(my_file, 1, 'float32');
  a.echo8_alpha = fread(my_file, 1, 'float32');
  a.echo8_beta = fread(my_file, 1, 'float32');
  a.landmark = fread(my_file, 1, 'float32');
  a.tablePosition = fread(my_file, 1, 'float32');
  a.pure_lambda = fread(my_file, 1, 'float32');
  a.pure_tuning_factor_surface = fread(my_file, 1, 'float32');
  a.pure_tuning_factor_body = fread(my_file, 1, 'float32');
  a.pure_derived_cal_fraction = fread(my_file, 1, 'float32');
  a.pure_derived_cal_reapodization = fread(my_file, 1, 'float32');
  a.pure_blur = fread(my_file, 1, 'float32');
  for id = 1 : 24
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.se_complete = fread(my_file, 1, 'int32');
  a.se_numarch = fread(my_file, 1, 'int32');
  a.se_imagect = fread(my_file, 1, 'int32');
  a.se_numimages = fread(my_file, 1, 'int32');
  a.se_delta_cnt = fread(my_file, 1, 'int32');
  a.se_numunimg = fread(my_file, 1, 'int32');
  a.se_toarchcnt = fread(my_file, 1, 'int32');
  for id = 1 : 33
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.se_datetime = fread(my_file, 1, 'int32');
  a.se_actual_dt = fread(my_file, 1, 'int32');
  a.position = fread(my_file, 1, 'int32');
  a.entry = fread(my_file, 1, 'int32');
  a.se_lndmrkcnt = fread(my_file, 1, 'int32');
  a.se_lastmod = fread(my_file, 1, 'int32');
  a.ExpType = fread(my_file, 1, 'int32');
  a.TrRest = fread(my_file, 1, 'int32');
  a.TrActive = fread(my_file, 1, 'int32');
  a.DumAcq = fread(my_file, 1, 'int32');
  a.ExptTimePts = fread(my_file, 1, 'int32');
  a.cal_pass_set_vector = fread(my_file, 1, 'int32');
  a.cal_nex_vector = fread(my_file, 1, 'int32');
  a.cal_weight_vector = fread(my_file, 1, 'int32');
  a.pure_filtering_mode = fread(my_file, 1, 'int32');
  a.isoVectorZ = fread(my_file, 1, 'int32');
  a.isMRAC = fread(my_file, 1, 'int32');
  a.pure_blur_enable = fread(my_file, 1, 'int32');
  for id = 1 : 26
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.se_exno = fread(my_file, 1, 'uint16');
  a.echo1_window = fread(my_file, 1, 'uint16');
  a.echo2_window = fread(my_file, 1, 'uint16');
  a.echo3_window = fread(my_file, 1, 'uint16');
  a.echo4_window = fread(my_file, 1, 'uint16');
  a.echo5_window = fread(my_file, 1, 'uint16');
  a.echo6_window = fread(my_file, 1, 'uint16');
  a.echo7_window = fread(my_file, 1, 'uint16');
  a.echo8_window = fread(my_file, 1, 'uint16');
  a.echo8_level = fread(my_file, 1, 'int16');
  a.echo7_level = fread(my_file, 1, 'int16');
  a.echo6_level = fread(my_file, 1, 'int16');
  a.echo5_level = fread(my_file, 1, 'int16');
  a.echo4_level = fread(my_file, 1, 'int16');
  a.echo3_level = fread(my_file, 1, 'int16');
  a.echo2_level = fread(my_file, 1, 'int16');
  a.echo1_level = fread(my_file, 1, 'int16');
  a.se_no = fread(my_file, 1, 'int16');
  a.se_typ = fread(my_file, 1, 'int16');
  a.se_source = fread(my_file, 1, 'int16');
  a.se_plane = fread(my_file, 1, 'int16');
  a.scan_type = fread(my_file, 1, 'int16');
  a.se_uniq = fread(my_file, 1, 'int16');
  a.se_contrast = fread(my_file, 1, 'int16');
  a.se_pseq = fread(my_file, 1, 'int16');
  a.se_sortorder = fread(my_file, 1, 'int16');
  a.se_nacq = fread(my_file, 1, 'int16');
  a.xbasest = fread(my_file, 1, 'int16');
  a.xbaseend = fread(my_file, 1, 'int16');
  a.xenhst = fread(my_file, 1, 'int16');
  a.xenhend = fread(my_file, 1, 'int16');
  a.table_entry = fread(my_file, 1, 'int16');
  a.SwingAngle = fread(my_file, 1, 'int16');
  a.LateralOffset = fread(my_file, 1, 'int16');
  a.GradientCoil = fread(my_file, 1, 'int16');
  a.se_subtype = fread(my_file, 1, 'int16');
  a.BWRT = fread(my_file, 1, 'int16');
  a.assetcal_serno = fread(my_file, 1, 'int16');
  a.assetcal_scnno = fread(my_file, 1, 'int16');
  a.content_qualifn = fread(my_file, 1, 'int16');
  a.purecal_serno = fread(my_file, 1, 'int16');
  a.purecal_scnno = fread(my_file, 1, 'int16');
  a.ideal = fread(my_file, 1, 'int16');
  a.verify_corners = fread(my_file, 1, 'int16');
  a.asset_cal_type = fread(my_file, 1, 'int16');
  a.pure_compatible = fread(my_file, 1, 'int16');
  a.purecal_type = fread(my_file, 1, 'int16');
  a.locMode = fread(my_file, 1, 'int16');
  for id = 1 : 28
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  for id = 1 : 2
    a.se_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.se_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.se_suid(id) = fread(my_file, 1, 'char');
  end
  a.se_alloc_key = freadc(my_file, 13);
  a.se_diskid = fread(my_file, 1, 'char');
  a.se_desc = freadc(my_file, 65);
  a.pr_sysid = freadc(my_file, 9);
  a.pansysid = freadc(my_file, 9);
  a.anref = freadc(my_file, 3);
  a.prtcl = freadc(my_file, 25);
  a.start_ras = fread(my_file, 1, 'char');
  a.end_ras = fread(my_file, 1, 'char');
  for id = 1 : 32
    a.series_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.landmark_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.equipmnt_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitval(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.schacitmea(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.schprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.perprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.perprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id1 = 1 : 4
    for id2 = 1 : 32
        a.refImgUID(id1,id2) = fread(my_file, 1, 'char');
    end
  end
  for id = 1 : 64
    a.PdgmStr(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 256
    a.PdgmDesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.PdgmUID(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplName(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplVer(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 12
    a.asset_appl(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_a(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_s(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_c(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.pure_cfg_params(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 30
    a.dzPETMR(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 221
    a.se_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 26.000
if rdbm_rev == 26.000 
  for id = 1 : 32
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.se_pds_a = fread(my_file, 1, 'float32');
  a.se_pds_c = fread(my_file, 1, 'float32');
  a.se_pds_u = fread(my_file, 1, 'float32');
  a.lmhor = fread(my_file, 1, 'float32');
  a.start_loc = fread(my_file, 1, 'float32');
  a.end_loc = fread(my_file, 1, 'float32');
  a.echo1_alpha = fread(my_file, 1, 'float32');
  a.echo1_beta = fread(my_file, 1, 'float32');
  a.echo2_alpha = fread(my_file, 1, 'float32');
  a.echo2_beta = fread(my_file, 1, 'float32');
  a.echo3_alpha = fread(my_file, 1, 'float32');
  a.echo3_beta = fread(my_file, 1, 'float32');
  a.echo4_alpha = fread(my_file, 1, 'float32');
  a.echo4_beta = fread(my_file, 1, 'float32');
  a.echo5_alpha = fread(my_file, 1, 'float32');
  a.echo5_beta = fread(my_file, 1, 'float32');
  a.echo6_alpha = fread(my_file, 1, 'float32');
  a.echo6_beta = fread(my_file, 1, 'float32');
  a.echo7_alpha = fread(my_file, 1, 'float32');
  a.echo7_beta = fread(my_file, 1, 'float32');
  a.echo8_alpha = fread(my_file, 1, 'float32');
  a.echo8_beta = fread(my_file, 1, 'float32');
  a.landmark = fread(my_file, 1, 'float32');
  a.tablePosition = fread(my_file, 1, 'float32');
  a.pure_lambda = fread(my_file, 1, 'float32');
  a.pure_tuning_factor_surface = fread(my_file, 1, 'float32');
  a.pure_tuning_factor_body = fread(my_file, 1, 'float32');
  a.pure_derived_cal_fraction = fread(my_file, 1, 'float32');
  a.pure_derived_cal_reapodization = fread(my_file, 1, 'float32');
  a.pure_blur = fread(my_file, 1, 'float32');
  a.pure_mix_lambda = fread(my_file, 1, 'float32');
  a.pure_mix_tuning_factor_surface = fread(my_file, 1, 'float32');
  a.pure_mix_tuning_factor_body = fread(my_file, 1, 'float32');
  a.pure_mix_blur = fread(my_file, 1, 'float32');
  a.pure_mix_alpha = fread(my_file, 1, 'float32');
  a.pure_mix_exp_wt = fread(my_file, 1, 'float32');
  for id = 1 : 18
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.se_complete = fread(my_file, 1, 'int32');
  a.se_numarch = fread(my_file, 1, 'int32');
  a.se_imagect = fread(my_file, 1, 'int32');
  a.se_numimages = fread(my_file, 1, 'int32');
  a.se_delta_cnt = fread(my_file, 1, 'int32');
  a.se_numunimg = fread(my_file, 1, 'int32');
  a.se_toarchcnt = fread(my_file, 1, 'int32');
  for id = 1 : 33
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.se_datetime = fread(my_file, 1, 'int32');
  a.se_actual_dt = fread(my_file, 1, 'int32');
  a.position = fread(my_file, 1, 'int32');
  a.entry = fread(my_file, 1, 'int32');
  a.se_lndmrkcnt = fread(my_file, 1, 'int32');
  a.se_lastmod = fread(my_file, 1, 'int32');
  a.ExpType = fread(my_file, 1, 'int32');
  a.TrRest = fread(my_file, 1, 'int32');
  a.TrActive = fread(my_file, 1, 'int32');
  a.DumAcq = fread(my_file, 1, 'int32');
  a.ExptTimePts = fread(my_file, 1, 'int32');
  a.cal_pass_set_vector = fread(my_file, 1, 'int32');
  a.cal_nex_vector = fread(my_file, 1, 'int32');
  a.cal_weight_vector = fread(my_file, 1, 'int32');
  a.pure_filtering_mode = fread(my_file, 1, 'int32');
  a.isoVectorZ = fread(my_file, 1, 'int32');
  a.isMRAC = fread(my_file, 1, 'int32');
  a.pure_blur_enable = fread(my_file, 1, 'int32');
  a.pure_mix_blur_enable = fread(my_file, 1, 'int32');
  a.pure_mix_otsu_class_qty = fread(my_file, 1, 'int32');
  a.pure_mix_erode_dist = fread(my_file, 1, 'int32');
  a.pure_mix_dilate_dist = fread(my_file, 1, 'int32');
  a.pure_mix_aniso_blur = fread(my_file, 1, 'int32');
  a.pure_mix_aniso_erode_dist = fread(my_file, 1, 'int32');
  a.pure_mix_aniso_dilate_dist = fread(my_file, 1, 'int32');
  for id = 1 : 19
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.se_exno = fread(my_file, 1, 'uint16');
  a.echo1_window = fread(my_file, 1, 'uint16');
  a.echo2_window = fread(my_file, 1, 'uint16');
  a.echo3_window = fread(my_file, 1, 'uint16');
  a.echo4_window = fread(my_file, 1, 'uint16');
  a.echo5_window = fread(my_file, 1, 'uint16');
  a.echo6_window = fread(my_file, 1, 'uint16');
  a.echo7_window = fread(my_file, 1, 'uint16');
  a.echo8_window = fread(my_file, 1, 'uint16');
  a.echo8_level = fread(my_file, 1, 'int16');
  a.echo7_level = fread(my_file, 1, 'int16');
  a.echo6_level = fread(my_file, 1, 'int16');
  a.echo5_level = fread(my_file, 1, 'int16');
  a.echo4_level = fread(my_file, 1, 'int16');
  a.echo3_level = fread(my_file, 1, 'int16');
  a.echo2_level = fread(my_file, 1, 'int16');
  a.echo1_level = fread(my_file, 1, 'int16');
  a.se_no = fread(my_file, 1, 'int16');
  a.se_typ = fread(my_file, 1, 'int16');
  a.se_source = fread(my_file, 1, 'int16');
  a.se_plane = fread(my_file, 1, 'int16');
  a.scan_type = fread(my_file, 1, 'int16');
  a.se_uniq = fread(my_file, 1, 'int16');
  a.se_contrast = fread(my_file, 1, 'int16');
  a.se_pseq = fread(my_file, 1, 'int16');
  a.se_sortorder = fread(my_file, 1, 'int16');
  a.se_nacq = fread(my_file, 1, 'int16');
  a.xbasest = fread(my_file, 1, 'int16');
  a.xbaseend = fread(my_file, 1, 'int16');
  a.xenhst = fread(my_file, 1, 'int16');
  a.xenhend = fread(my_file, 1, 'int16');
  a.table_entry = fread(my_file, 1, 'int16');
  a.SwingAngle = fread(my_file, 1, 'int16');
  a.LateralOffset = fread(my_file, 1, 'int16');
  a.GradientCoil = fread(my_file, 1, 'int16');
  a.se_subtype = fread(my_file, 1, 'int16');
  a.BWRT = fread(my_file, 1, 'int16');
  a.assetcal_serno = fread(my_file, 1, 'int16');
  a.assetcal_scnno = fread(my_file, 1, 'int16');
  a.content_qualifn = fread(my_file, 1, 'int16');
  a.purecal_serno = fread(my_file, 1, 'int16');
  a.purecal_scnno = fread(my_file, 1, 'int16');
  a.ideal = fread(my_file, 1, 'int16');
  a.verify_corners = fread(my_file, 1, 'int16');
  a.asset_cal_type = fread(my_file, 1, 'int16');
  a.pure_compatible = fread(my_file, 1, 'int16');
  a.purecal_type = fread(my_file, 1, 'int16');
  a.locMode = fread(my_file, 1, 'int16');
  for id = 1 : 28
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  for id = 1 : 2
    a.se_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.se_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.se_suid(id) = fread(my_file, 1, 'char');
  end
  a.se_alloc_key = freadc(my_file, 13);
  a.se_diskid = fread(my_file, 1, 'char');
  a.se_desc = freadc(my_file, 65);
  a.pr_sysid = freadc(my_file, 9);
  a.pansysid = freadc(my_file, 9);
  a.anref = freadc(my_file, 3);
  a.prtcl = freadc(my_file, 25);
  a.start_ras = fread(my_file, 1, 'char');
  a.end_ras = fread(my_file, 1, 'char');
  for id = 1 : 32
    a.series_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.landmark_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.equipmnt_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitval(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.schacitmea(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.schprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.perprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.perprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id1 = 1 : 4
    for id2 = 1 : 32
        a.refImgUID(id1,id2) = fread(my_file, 1, 'char');
    end
  end
  for id = 1 : 64
    a.PdgmStr(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 256
    a.PdgmDesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.PdgmUID(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplName(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplVer(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 12
    a.asset_appl(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_a(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_s(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_c(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.pure_cfg_params(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 30
    a.dzPETMR(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 221
    a.se_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 26.001
if rdbm_rev == 26.001 
  for id = 1 : 32
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.se_pds_a = fread(my_file, 1, 'float32');
  a.se_pds_c = fread(my_file, 1, 'float32');
  a.se_pds_u = fread(my_file, 1, 'float32');
  a.lmhor = fread(my_file, 1, 'float32');
  a.start_loc = fread(my_file, 1, 'float32');
  a.end_loc = fread(my_file, 1, 'float32');
  a.echo1_alpha = fread(my_file, 1, 'float32');
  a.echo1_beta = fread(my_file, 1, 'float32');
  a.echo2_alpha = fread(my_file, 1, 'float32');
  a.echo2_beta = fread(my_file, 1, 'float32');
  a.echo3_alpha = fread(my_file, 1, 'float32');
  a.echo3_beta = fread(my_file, 1, 'float32');
  a.echo4_alpha = fread(my_file, 1, 'float32');
  a.echo4_beta = fread(my_file, 1, 'float32');
  a.echo5_alpha = fread(my_file, 1, 'float32');
  a.echo5_beta = fread(my_file, 1, 'float32');
  a.echo6_alpha = fread(my_file, 1, 'float32');
  a.echo6_beta = fread(my_file, 1, 'float32');
  a.echo7_alpha = fread(my_file, 1, 'float32');
  a.echo7_beta = fread(my_file, 1, 'float32');
  a.echo8_alpha = fread(my_file, 1, 'float32');
  a.echo8_beta = fread(my_file, 1, 'float32');
  a.landmark = fread(my_file, 1, 'float32');
  a.tablePosition = fread(my_file, 1, 'float32');
  a.pure_lambda = fread(my_file, 1, 'float32');
  a.pure_tuning_factor_surface = fread(my_file, 1, 'float32');
  a.pure_tuning_factor_body = fread(my_file, 1, 'float32');
  a.pure_derived_cal_fraction = fread(my_file, 1, 'float32');
  a.pure_derived_cal_reapodization = fread(my_file, 1, 'float32');
  a.pure_blur = fread(my_file, 1, 'float32');
  a.pure_mix_lambda = fread(my_file, 1, 'float32');
  a.pure_mix_tuning_factor_surface = fread(my_file, 1, 'float32');
  a.pure_mix_tuning_factor_body = fread(my_file, 1, 'float32');
  a.pure_mix_blur = fread(my_file, 1, 'float32');
  a.pure_mix_alpha = fread(my_file, 1, 'float32');
  a.pure_mix_exp_wt = fread(my_file, 1, 'float32');
  for id = 1 : 18
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.se_complete = fread(my_file, 1, 'int32');
  a.se_numarch = fread(my_file, 1, 'int32');
  a.se_imagect = fread(my_file, 1, 'int32');
  a.se_numimages = fread(my_file, 1, 'int32');
  a.se_delta_cnt = fread(my_file, 1, 'int32');
  a.se_numunimg = fread(my_file, 1, 'int32');
  a.se_toarchcnt = fread(my_file, 1, 'int32');
  for id = 1 : 33
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.se_datetime = fread(my_file, 1, 'int32');
  a.se_actual_dt = fread(my_file, 1, 'int32');
  a.position = fread(my_file, 1, 'int32');
  a.entry = fread(my_file, 1, 'int32');
  a.se_lndmrkcnt = fread(my_file, 1, 'int32');
  a.se_lastmod = fread(my_file, 1, 'int32');
  a.ExpType = fread(my_file, 1, 'int32');
  a.TrRest = fread(my_file, 1, 'int32');
  a.TrActive = fread(my_file, 1, 'int32');
  a.DumAcq = fread(my_file, 1, 'int32');
  a.ExptTimePts = fread(my_file, 1, 'int32');
  a.cal_pass_set_vector = fread(my_file, 1, 'int32');
  a.cal_nex_vector = fread(my_file, 1, 'int32');
  a.cal_weight_vector = fread(my_file, 1, 'int32');
  a.pure_filtering_mode = fread(my_file, 1, 'int32');
  a.isoVectorZ = fread(my_file, 1, 'int32');
  a.isMRAC = fread(my_file, 1, 'int32');
  a.pure_blur_enable = fread(my_file, 1, 'int32');
  a.pure_mix_blur_enable = fread(my_file, 1, 'int32');
  a.pure_mix_otsu_class_qty = fread(my_file, 1, 'int32');
  a.pure_mix_erode_dist = fread(my_file, 1, 'int32');
  a.pure_mix_dilate_dist = fread(my_file, 1, 'int32');
  a.pure_mix_aniso_blur = fread(my_file, 1, 'int32');
  a.pure_mix_aniso_erode_dist = fread(my_file, 1, 'int32');
  a.pure_mix_aniso_dilate_dist = fread(my_file, 1, 'int32');
  for id = 1 : 19
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.se_exno = fread(my_file, 1, 'uint16');
  a.echo1_window = fread(my_file, 1, 'uint16');
  a.echo2_window = fread(my_file, 1, 'uint16');
  a.echo3_window = fread(my_file, 1, 'uint16');
  a.echo4_window = fread(my_file, 1, 'uint16');
  a.echo5_window = fread(my_file, 1, 'uint16');
  a.echo6_window = fread(my_file, 1, 'uint16');
  a.echo7_window = fread(my_file, 1, 'uint16');
  a.echo8_window = fread(my_file, 1, 'uint16');
  a.echo8_level = fread(my_file, 1, 'int16');
  a.echo7_level = fread(my_file, 1, 'int16');
  a.echo6_level = fread(my_file, 1, 'int16');
  a.echo5_level = fread(my_file, 1, 'int16');
  a.echo4_level = fread(my_file, 1, 'int16');
  a.echo3_level = fread(my_file, 1, 'int16');
  a.echo2_level = fread(my_file, 1, 'int16');
  a.echo1_level = fread(my_file, 1, 'int16');
  a.se_no = fread(my_file, 1, 'int16');
  a.se_typ = fread(my_file, 1, 'int16');
  a.se_source = fread(my_file, 1, 'int16');
  a.se_plane = fread(my_file, 1, 'int16');
  a.scan_type = fread(my_file, 1, 'int16');
  a.se_uniq = fread(my_file, 1, 'int16');
  a.se_contrast = fread(my_file, 1, 'int16');
  a.se_pseq = fread(my_file, 1, 'int16');
  a.se_sortorder = fread(my_file, 1, 'int16');
  a.se_nacq = fread(my_file, 1, 'int16');
  a.xbasest = fread(my_file, 1, 'int16');
  a.xbaseend = fread(my_file, 1, 'int16');
  a.xenhst = fread(my_file, 1, 'int16');
  a.xenhend = fread(my_file, 1, 'int16');
  a.table_entry = fread(my_file, 1, 'int16');
  a.SwingAngle = fread(my_file, 1, 'int16');
  a.LateralOffset = fread(my_file, 1, 'int16');
  a.GradientCoil = fread(my_file, 1, 'int16');
  a.se_subtype = fread(my_file, 1, 'int16');
  a.BWRT = fread(my_file, 1, 'int16');
  a.assetcal_serno = fread(my_file, 1, 'int16');
  a.assetcal_scnno = fread(my_file, 1, 'int16');
  a.content_qualifn = fread(my_file, 1, 'int16');
  a.purecal_serno = fread(my_file, 1, 'int16');
  a.purecal_scnno = fread(my_file, 1, 'int16');
  a.ideal = fread(my_file, 1, 'int16');
  a.verify_corners = fread(my_file, 1, 'int16');
  a.asset_cal_type = fread(my_file, 1, 'int16');
  a.pure_compatible = fread(my_file, 1, 'int16');
  a.purecal_type = fread(my_file, 1, 'int16');
  a.locMode = fread(my_file, 1, 'int16');
  for id = 1 : 28
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  for id = 1 : 2
    a.se_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.se_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.se_suid(id) = fread(my_file, 1, 'char');
  end
  a.se_alloc_key = freadc(my_file, 13);
  a.se_diskid = fread(my_file, 1, 'char');
  a.se_desc = freadc(my_file, 65);
  a.pr_sysid = freadc(my_file, 9);
  a.pansysid = freadc(my_file, 9);
  a.anref = freadc(my_file, 3);
  a.prtcl = freadc(my_file, 25);
  a.start_ras = fread(my_file, 1, 'char');
  a.end_ras = fread(my_file, 1, 'char');
  for id = 1 : 32
    a.series_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.landmark_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.equipmnt_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitval(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.schacitmea(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.schprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.perprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.perprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id1 = 1 : 4
    for id2 = 1 : 32
        a.refImgUID(id1,id2) = fread(my_file, 1, 'char');
    end
  end
  for id = 1 : 64
    a.PdgmStr(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 256
    a.PdgmDesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.PdgmUID(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplName(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplVer(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 12
    a.asset_appl(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_a(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_s(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_c(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.pure_cfg_params(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 30
    a.dzPETMR(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 221
    a.se_padding(id) = fread(my_file, 1, 'char');
  end


end

% RDBM revision 26.002
if rdbm_rev == 26.002 
  for id = 1 : 32
    a.double_padding(id) = fread(my_file, 1, 'float64');
  end
  a.se_pds_a = fread(my_file, 1, 'float32');
  a.se_pds_c = fread(my_file, 1, 'float32');
  a.se_pds_u = fread(my_file, 1, 'float32');
  a.lmhor = fread(my_file, 1, 'float32');
  a.start_loc = fread(my_file, 1, 'float32');
  a.end_loc = fread(my_file, 1, 'float32');
  a.echo1_alpha = fread(my_file, 1, 'float32');
  a.echo1_beta = fread(my_file, 1, 'float32');
  a.echo2_alpha = fread(my_file, 1, 'float32');
  a.echo2_beta = fread(my_file, 1, 'float32');
  a.echo3_alpha = fread(my_file, 1, 'float32');
  a.echo3_beta = fread(my_file, 1, 'float32');
  a.echo4_alpha = fread(my_file, 1, 'float32');
  a.echo4_beta = fread(my_file, 1, 'float32');
  a.echo5_alpha = fread(my_file, 1, 'float32');
  a.echo5_beta = fread(my_file, 1, 'float32');
  a.echo6_alpha = fread(my_file, 1, 'float32');
  a.echo6_beta = fread(my_file, 1, 'float32');
  a.echo7_alpha = fread(my_file, 1, 'float32');
  a.echo7_beta = fread(my_file, 1, 'float32');
  a.echo8_alpha = fread(my_file, 1, 'float32');
  a.echo8_beta = fread(my_file, 1, 'float32');
  a.landmark = fread(my_file, 1, 'float32');
  a.tablePosition = fread(my_file, 1, 'float32');
  a.pure_lambda = fread(my_file, 1, 'float32');
  a.pure_tuning_factor_surface = fread(my_file, 1, 'float32');
  a.pure_tuning_factor_body = fread(my_file, 1, 'float32');
  a.pure_derived_cal_fraction = fread(my_file, 1, 'float32');
  a.pure_derived_cal_reapodization = fread(my_file, 1, 'float32');
  a.pure_blur = fread(my_file, 1, 'float32');
  a.pure_mix_lambda = fread(my_file, 1, 'float32');
  a.pure_mix_tuning_factor_surface = fread(my_file, 1, 'float32');
  a.pure_mix_tuning_factor_body = fread(my_file, 1, 'float32');
  a.pure_mix_blur = fread(my_file, 1, 'float32');
  a.pure_mix_alpha = fread(my_file, 1, 'float32');
  a.pure_mix_exp_wt = fread(my_file, 1, 'float32');
  a.topOfHead = fread(my_file, 1, 'float32');
  a.zLoc = fread(my_file, 1, 'float32');
  for id = 1 : 16
    a.float_padding(id) = fread(my_file, 1, 'float32');
  end
  a.se_complete = fread(my_file, 1, 'int32');
  a.se_numarch = fread(my_file, 1, 'int32');
  a.se_imagect = fread(my_file, 1, 'int32');
  a.se_numimages = fread(my_file, 1, 'int32');
  a.se_delta_cnt = fread(my_file, 1, 'int32');
  a.se_numunimg = fread(my_file, 1, 'int32');
  a.se_toarchcnt = fread(my_file, 1, 'int32');
  a.topOfHeadValid = fread(my_file, 1, 'int32');
  for id = 1 : 32
    a.int_padding1(id) = fread(my_file, 1, 'int32');
  end
  a.se_datetime = fread(my_file, 1, 'int32');
  a.se_actual_dt = fread(my_file, 1, 'int32');
  a.position = fread(my_file, 1, 'int32');
  a.entry = fread(my_file, 1, 'int32');
  a.se_lndmrkcnt = fread(my_file, 1, 'int32');
  a.se_lastmod = fread(my_file, 1, 'int32');
  a.ExpType = fread(my_file, 1, 'int32');
  a.TrRest = fread(my_file, 1, 'int32');
  a.TrActive = fread(my_file, 1, 'int32');
  a.DumAcq = fread(my_file, 1, 'int32');
  a.ExptTimePts = fread(my_file, 1, 'int32');
  a.cal_pass_set_vector = fread(my_file, 1, 'int32');
  a.cal_nex_vector = fread(my_file, 1, 'int32');
  a.cal_weight_vector = fread(my_file, 1, 'int32');
  a.pure_filtering_mode = fread(my_file, 1, 'int32');
  a.isoVectorZ = fread(my_file, 1, 'int32');
  a.isMRAC = fread(my_file, 1, 'int32');
  a.pure_blur_enable = fread(my_file, 1, 'int32');
  a.pure_mix_blur_enable = fread(my_file, 1, 'int32');
  a.pure_mix_otsu_class_qty = fread(my_file, 1, 'int32');
  a.pure_mix_erode_dist = fread(my_file, 1, 'int32');
  a.pure_mix_dilate_dist = fread(my_file, 1, 'int32');
  a.pure_mix_aniso_blur = fread(my_file, 1, 'int32');
  a.pure_mix_aniso_erode_dist = fread(my_file, 1, 'int32');
  a.pure_mix_aniso_dilate_dist = fread(my_file, 1, 'int32');
  a.ePure_enable = fread(my_file, 1, 'int32');
  a.se_no = fread(my_file, 1, 'int32');
  a.defineFilter_noice_reduction = fread(my_file, 1, 'int32');
  a.defineFilter_sharpen = fread(my_file, 1, 'int32');
  for id = 1 : 15
    a.int_padding2(id) = fread(my_file, 1, 'int32');
  end
  a.se_exno = fread(my_file, 1, 'uint16');
  a.echo1_window = fread(my_file, 1, 'uint16');
  a.echo2_window = fread(my_file, 1, 'uint16');
  a.echo3_window = fread(my_file, 1, 'uint16');
  a.echo4_window = fread(my_file, 1, 'uint16');
  a.echo5_window = fread(my_file, 1, 'uint16');
  a.echo6_window = fread(my_file, 1, 'uint16');
  a.echo7_window = fread(my_file, 1, 'uint16');
  a.echo8_window = fread(my_file, 1, 'uint16');
  a.echo8_level = fread(my_file, 1, 'int16');
  a.echo7_level = fread(my_file, 1, 'int16');
  a.echo6_level = fread(my_file, 1, 'int16');
  a.echo5_level = fread(my_file, 1, 'int16');
  a.echo4_level = fread(my_file, 1, 'int16');
  a.echo3_level = fread(my_file, 1, 'int16');
  a.echo2_level = fread(my_file, 1, 'int16');
  a.echo1_level = fread(my_file, 1, 'int16');
  a.se_typ = fread(my_file, 1, 'int16');
  a.se_source = fread(my_file, 1, 'int16');
  a.se_plane = fread(my_file, 1, 'int16');
  a.scan_type = fread(my_file, 1, 'int16');
  a.se_uniq = fread(my_file, 1, 'int16');
  a.se_contrast = fread(my_file, 1, 'int16');
  a.se_pseq = fread(my_file, 1, 'int16');
  a.se_sortorder = fread(my_file, 1, 'int16');
  a.se_nacq = fread(my_file, 1, 'int16');
  a.xbasest = fread(my_file, 1, 'int16');
  a.xbaseend = fread(my_file, 1, 'int16');
  a.xenhst = fread(my_file, 1, 'int16');
  a.xenhend = fread(my_file, 1, 'int16');
  a.table_entry = fread(my_file, 1, 'int16');
  a.SwingAngle = fread(my_file, 1, 'int16');
  a.LateralOffset = fread(my_file, 1, 'int16');
  a.GradientCoil = fread(my_file, 1, 'int16');
  a.se_subtype = fread(my_file, 1, 'int16');
  a.BWRT = fread(my_file, 1, 'int16');
  a.assetcal_serno = fread(my_file, 1, 'int16');
  a.assetcal_scnno = fread(my_file, 1, 'int16');
  a.content_qualifn = fread(my_file, 1, 'int16');
  a.purecal_serno = fread(my_file, 1, 'int16');
  a.purecal_scnno = fread(my_file, 1, 'int16');
  a.ideal = fread(my_file, 1, 'int16');
  a.verify_corners = fread(my_file, 1, 'int16');
  a.asset_cal_type = fread(my_file, 1, 'int16');
  a.pure_compatible = fread(my_file, 1, 'int16');
  a.purecal_type = fread(my_file, 1, 'int16');
  a.locMode = fread(my_file, 1, 'int16');
  for id = 1 : 29
    a.short_padding(id) = fread(my_file, 1, 'int16');
  end
  for id = 1 : 2
    a.se_verscre(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 2
    a.se_verscur(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 4
    a.se_suid(id) = fread(my_file, 1, 'char');
  end
  a.se_alloc_key = freadc(my_file, 13);
  a.se_diskid = fread(my_file, 1, 'char');
  a.se_desc = freadc(my_file, 65);
  a.pr_sysid = freadc(my_file, 9);
  a.pansysid = freadc(my_file, 9);
  a.anref = freadc(my_file, 3);
  a.prtcl = freadc(my_file, 25);
  a.start_ras = fread(my_file, 1, 'char');
  a.end_ras = fread(my_file, 1, 'char');
  a.defineFilter_name = freadc(my_file, 20);
  a.defineFilter_description = freadc(my_file, 30);
  for id = 1 : 32
    a.series_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.landmark_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.equipmnt_uid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopcuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.refsopiuids(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitval(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schacitdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.schacitmea(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.schprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.perprocstid(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 65
    a.perprocstdesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.reqprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid2(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.schprocstid3(id) = fread(my_file, 1, 'char');
  end
  for id1 = 1 : 4
    for id2 = 1 : 32
        a.refImgUID(id1,id2) = fread(my_file, 1, 'char');
    end
  end
  for id = 1 : 64
    a.PdgmStr(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 256
    a.PdgmDesc(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.PdgmUID(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplName(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 16
    a.ApplVer(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 12
    a.asset_appl(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_a(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_s(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 32
    a.scic_c(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 64
    a.pure_cfg_params(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 30
    a.dzPETMR(id) = fread(my_file, 1, 'char');
  end
  for id = 1 : 171
    a.se_padding(id) = fread(my_file, 1, 'char');
  end


end

