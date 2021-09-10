% 
% read_psc_header.m
%
% Copyright (c) 2012 The General Electric Company
%
%
function  a = read_psc_header( my_file,rdbm_rev )
if rdbm_rev >= 25.003
 a.command = fread(my_file, 1, 'int32');
 a.mps_r1 = fread(my_file, 1, 'int32');
 a.mps_r2 = fread(my_file, 1, 'int32');
 a.mps_tg = fread(my_file, 1, 'int32');
 a.mps_freq = fread(my_file, 1, 'uint32');
 a.aps_r1 = fread(my_file, 1, 'int32');
 a.aps_r2 = fread(my_file, 1, 'int32');
 a.aps_tg = fread(my_file, 1, 'int32');
 a.aps_freq = fread(my_file, 1, 'uint32');
 a.scalei = fread(my_file, 1, 'float32');
 a.scaleq = fread(my_file, 1, 'float32');
 a.snr_warning = fread(my_file, 1, 'int32');
 a.aps_or_mps = fread(my_file, 1, 'int32');
 a.mps_bitmap = fread(my_file, 1, 'int32');
 for id = 1:256
  a.powerspec(id) = fread(my_file, 1, 'char');
 end
 a.filler1 = fread(my_file, 1, 'int32');
 a.filler2 = fread(my_file, 1, 'int32');
 a.xshim = fread(my_file, 1, 'int16');
 a.yshim = fread(my_file, 1, 'int16');
 a.zshim = fread(my_file, 1, 'int16');
 a.recon_enable = fread(my_file, 1, 'int16');
 a.autoshim_status = fread(my_file, 1, 'int32'); 
 for id = 1 : 256
  a.rec_std(id) = fread(my_file, 1, 'float32');
 end
 for id = 1 : 256
  a.rec_mean(id) = fread(my_file, 1, 'float32');
 end
 a.line_width = fread(my_file, 1, 'int32');
 a.ws_flip = fread(my_file, 1, 'int32');
 a.supp_lvl = fread(my_file, 1, 'int32');
 a.psc_reuse = fread(my_file, 1, 'int32');
 for id = 1:52
  a.psc_reuse_string(id) = fread(my_file, 1, 'char');
 end 
 a.psc_ta = fread(my_file, 1, 'int32');
 a.phase_correction_status = fread(my_file, 1, 'int32');
 a.broad_band_select = fread(my_file, 1, 'int32');
 a.dd_q_phase_delay_qd = fread(my_file, 1, 'float32');      
 a.dd_q_phase_delay_from_qd = fread(my_file, 1, 'float32');
 a.dd_q_ta_offset_qd = fread(my_file, 1, 'int16');      
 a.dd_q_ta_offset_from_qd = fread(my_file, 1, 'int16');
 a.dd_mode = fread(my_file, 1, 'int16');              
 a.dummy_for_32bit_align = fread(my_file, 1, 'int16');
 for id = 1:48
  a.buffer(id) = fread(my_file, 1, 'char');
 end
elseif rdbm_rev >= 20.006
 a.command = fread(my_file, 1, 'int32');
 a.mps_r1 = fread(my_file, 1, 'int32');
 a.mps_r2 = fread(my_file, 1, 'int32');
 a.mps_tg = fread(my_file, 1, 'int32');
 a.mps_freq = fread(my_file, 1, 'uint32');
 a.aps_r1 = fread(my_file, 1, 'int32');
 a.aps_r2 = fread(my_file, 1, 'int32');
 a.aps_tg = fread(my_file, 1, 'int32');
 a.aps_freq = fread(my_file, 1, 'uint32');
 a.scalei = fread(my_file, 1, 'float32');
 a.scaleq = fread(my_file, 1, 'float32');
 a.snr_warning = fread(my_file, 1, 'int32');
 a.aps_or_mps = fread(my_file, 1, 'int32');
 a.mps_bitmap = fread(my_file, 1, 'int32');
 for id = 1:256
  a.powerspec(id) = fread(my_file, 1, 'char');
 end
 a.filler1 = fread(my_file, 1, 'int32');
 a.filler2 = fread(my_file, 1, 'int32');
 a.xshim = fread(my_file, 1, 'int16');
 a.yshim = fread(my_file, 1, 'int16');
 a.zshim = fread(my_file, 1, 'int16');
 a.recon_enable = fread(my_file, 1, 'int16');
 a.autoshim_status = fread(my_file, 1, 'int32'); 
 for id = 1 : 128
  a.rec_std(id) = fread(my_file, 1, 'float32');
 end
 for id = 1 : 128
  a.rec_mean(id) = fread(my_file, 1, 'float32');
 end
 a.line_width = fread(my_file, 1, 'int32');
 a.ws_flip = fread(my_file, 1, 'int32');
 a.supp_lvl = fread(my_file, 1, 'int32');
 a.psc_reuse = fread(my_file, 1, 'int32');
 for id = 1:52
  a.psc_reuse_string(id) = fread(my_file, 1, 'char');
 end 
 a.psc_ta = fread(my_file, 1, 'int32');
 a.phase_correction_status = fread(my_file, 1, 'int32');
 a.broad_band_select = fread(my_file, 1, 'int32');
 a.dd_q_phase_delay_qd = fread(my_file, 1, 'float32');      
 a.dd_q_phase_delay_from_qd = fread(my_file, 1, 'float32');
 a.dd_q_ta_offset_qd = fread(my_file, 1, 'int16');      
 a.dd_q_ta_offset_from_qd = fread(my_file, 1, 'int16');
 a.dd_mode = fread(my_file, 1, 'int16');              
 a.dummy_for_32bit_align = fread(my_file, 1, 'int16');
 for id = 1:48
  a.buffer(id) = fread(my_file, 1, 'char');
 end
else
 a = [];
end
