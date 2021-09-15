function  a = read_ctt_header(my_file, rdbm_rev)
% RDBM revision 25.001
if rdbm_rev == 25.001 
  for id = 1 : 4
    a.cttentry(id).logicalCoilName = fread(my_file, 128, 'char')';
    a.cttentry(id).clinicalCoilName = fread(my_file, 32, 'char')';
    a.cttentry(id).configUID = fread(my_file, 1, 'uint32');
    a.cttentry(id).coilConnector = fread(my_file, 1, 'int32');
    a.cttentry(id).isActiveConfig = fread(my_file, 1, 'uint32');
    for rec = 1 : 256
        a.cttentry(id).channelTranslationMap(rec).receiverID = fread(my_file, 1, 'uint32')';
        a.cttentry(id).channelTranslationMap(rec).receiverChannel = fread(my_file, 1, 'uint32')';
    end
    a.cttentry(id).numChannels = fread(my_file, 1, 'uint32');
  end


end

% RDBM revision 25.002
if rdbm_rev == 25.002 
  for id = 1 : 4
    a.cttentry(id).logicalCoilName = fread(my_file, 128, 'char')';
    a.cttentry(id).clinicalCoilName = fread(my_file, 32, 'char')';
    a.cttentry(id).configUID = fread(my_file, 1, 'uint32');
    a.cttentry(id).coilConnector = fread(my_file, 1, 'int32');
    a.cttentry(id).isActiveConfig = fread(my_file, 1, 'uint32');
    for rec = 1 : 256
        a.cttentry(id).channelTranslationMap(rec).receiverID = fread(my_file, 1, 'uint32')';
        a.cttentry(id).channelTranslationMap(rec).receiverChannel = fread(my_file, 1, 'uint32')';
    end
    a.cttentry(id).numChannels = fread(my_file, 1, 'uint32');
  end


end

% RDBM revision 25.003
if rdbm_rev == 25.003 
  for id = 1 : 4
    a.cttentry(id).logicalCoilName = fread(my_file, 128, 'char')';
    a.cttentry(id).clinicalCoilName = fread(my_file, 32, 'char')';
    a.cttentry(id).configUID = fread(my_file, 1, 'uint32');
    a.cttentry(id).coilConnector = fread(my_file, 1, 'int32');
    a.cttentry(id).isActiveConfig = fread(my_file, 1, 'uint32');
    for rec = 1 : 256
        a.cttentry(id).channelTranslationMap(rec).receiverID = fread(my_file, 1, 'uint32')';
        a.cttentry(id).channelTranslationMap(rec).receiverChannel = fread(my_file, 1, 'uint32')';
    end
    a.cttentry(id).numChannels = fread(my_file, 1, 'uint32');
  end


end

% RDBM revision 25.004
if rdbm_rev == 25.004 
  for id = 1 : 4
    a.cttentry(id).logicalCoilName = fread(my_file, 128, 'char')';
    a.cttentry(id).clinicalCoilName = fread(my_file, 32, 'char')';
    a.cttentry(id).configUID = fread(my_file, 1, 'uint32');
    a.cttentry(id).coilConnector = fread(my_file, 1, 'int32');
    a.cttentry(id).isActiveConfig = fread(my_file, 1, 'uint32');
    for rec = 1 : 256
        a.cttentry(id).channelTranslationMap(rec).receiverID = fread(my_file, 1, 'uint32')';
        a.cttentry(id).channelTranslationMap(rec).receiverChannel = fread(my_file, 1, 'uint32')';
    end
    a.cttentry(id).numChannels = fread(my_file, 1, 'uint32');
  end


end

% RDBM revision 26.000
if rdbm_rev == 26.000 
  for id = 1 : 4
    a.cttentry(id).logicalCoilName = fread(my_file, 128, 'char')';
    a.cttentry(id).clinicalCoilName = fread(my_file, 32, 'char')';
    a.cttentry(id).configUID = fread(my_file, 1, 'uint32');
    a.cttentry(id).coilConnector = fread(my_file, 1, 'int32');
    a.cttentry(id).isActiveConfig = fread(my_file, 1, 'uint32');
    for rec = 1 : 256
        a.cttentry(id).channelTranslationMap(rec).receiverID = fread(my_file, 1, 'uint8')';
        a.cttentry(id).channelTranslationMap(rec).receiverChannel = fread(my_file, 1, 'uint8')';
        a.cttentry(id).channelTranslationMap(rec).entryMask = fread(my_file, 1, 'uint16')';
    end
    for rec = 1 : 16
        a.cttentry(id).quadVolReceiveWeights(rec).receiverID = fread(my_file, 1, 'uint8')';
        a.cttentry(id).quadVolReceiveWeights(rec).receiverChannel = fread(my_file, 1, 'uint8')';
        a.cttentry(id).quadVolReceiveWeights(rec).padding = fread(my_file, 2, 'uint8')';
        a.cttentry(id).quadVolReceiveWeights(rec).recWeight = fread(my_file, 1, 'float32')';
        a.cttentry(id).quadVolReceiveWeights(rec).recPhaseDeg = fread(my_file, 1, 'float32')';
    end
    a.cttentry(id).numChannels = fread(my_file, 1, 'uint32');
  end


end

% RDBM revision 26.001
if rdbm_rev == 26.001 
  for id = 1 : 4
    a.cttentry(id).logicalCoilName = fread(my_file, 128, 'char')';
    a.cttentry(id).clinicalCoilName = fread(my_file, 32, 'char')';
    a.cttentry(id).configUID = fread(my_file, 1, 'uint32');
    a.cttentry(id).coilConnector = fread(my_file, 1, 'int32');
    a.cttentry(id).isActiveConfig = fread(my_file, 1, 'uint32');
    for rec = 1 : 256
        a.cttentry(id).channelTranslationMap(rec).receiverID = fread(my_file, 1, 'uint8')';
        a.cttentry(id).channelTranslationMap(rec).receiverChannel = fread(my_file, 1, 'uint8')';
        a.cttentry(id).channelTranslationMap(rec).entryMask = fread(my_file, 1, 'uint16')';
    end
    for rec = 1 : 16
        a.cttentry(id).quadVolReceiveWeights(rec).receiverID = fread(my_file, 1, 'uint8')';
        a.cttentry(id).quadVolReceiveWeights(rec).receiverChannel = fread(my_file, 1, 'uint8')';
        a.cttentry(id).quadVolReceiveWeights(rec).padding = fread(my_file, 2, 'uint8')';
        a.cttentry(id).quadVolReceiveWeights(rec).recWeight = fread(my_file, 1, 'float32')';
        a.cttentry(id).quadVolReceiveWeights(rec).recPhaseDeg = fread(my_file, 1, 'float32')';
    end
    a.cttentry(id).numChannels = fread(my_file, 1, 'uint32');
  end


end

% RDBM revision 26.002
if rdbm_rev == 26.002 
  for id = 1 : 4
    a.cttentry(id).logicalCoilName = fread(my_file, 128, 'char')';
    a.cttentry(id).clinicalCoilName = fread(my_file, 32, 'char')';
    a.cttentry(id).configUID = fread(my_file, 1, 'uint32');
    a.cttentry(id).coilConnector = fread(my_file, 1, 'int32');
    a.cttentry(id).isActiveConfig = fread(my_file, 1, 'uint32');
    for rec = 1 : 256
        a.cttentry(id).channelTranslationMap(rec).receiverID = fread(my_file, 1, 'uint8')';
        a.cttentry(id).channelTranslationMap(rec).receiverChannel = fread(my_file, 1, 'uint8')';
        a.cttentry(id).channelTranslationMap(rec).entryMask = fread(my_file, 1, 'uint16')';
    end
    for rec = 1 : 16
        a.cttentry(id).quadVolReceiveWeights(rec).receiverID = fread(my_file, 1, 'uint8')';
        a.cttentry(id).quadVolReceiveWeights(rec).receiverChannel = fread(my_file, 1, 'uint8')';
        a.cttentry(id).quadVolReceiveWeights(rec).padding = fread(my_file, 2, 'uint8')';
        a.cttentry(id).quadVolReceiveWeights(rec).recWeight = fread(my_file, 1, 'float32')';
        a.cttentry(id).quadVolReceiveWeights(rec).recPhaseDeg = fread(my_file, 1, 'float32')';
    end
    a.cttentry(id).numChannels = fread(my_file, 1, 'uint32');
  end


end

