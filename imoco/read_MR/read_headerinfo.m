function hdr_szs = read_headerinfo(textfile,rdbm_rev)
%read_headerinfo - Read raw data header information
%
%  hdr_szs = read_headerinfo(textfile,rdbm_rev)
%    textfile - Header information file
%    rdbm_rev - raw header (RDBM) revision number
%    hdr_szs
%        hdr_szs(1) - rdbm revision
%        hdr_szs(2) - Total size of header (bytes)
%        hdr_szs(3:end) - size of each header section (bytes)
%  Returns -1 if the specified rdbm_rev is not found   
%
%  Assumes the following format for textfile
%  #REVNUM
%  headersize
%  offset1
%  offset2
%  offset3
%  ...
%  #end
%
%  Any text prior to the matching #REVNUM and the subsequent #end is
%  ignored.  Blank lines between #REVNUM and #end are ignored.

% Copyright (c) 2012 by General Electric Company. All rights reserved.

% Revision History:
% Charles Michelich, 2008-05-11, Updated to support UNIX or DOS end-of-line

error(nargchk(2, 2, nargin));
error(nargchk(0, 1, nargout));
if ~ischar(textfile)
    error('textfile must be a string');
end
if ~isnumeric(rdbm_rev) || ~isscalar(rdbm_rev)
    error('rdbm_rev must be a single number');
end

hdr_szs = -1;
[fid, msg] = fopen(textfile,'r');
if fid == -1
    error('read_headerinfo:fopen','Unable to open "%s"\n%s', textfile, msg);
end

foundRev = false;
complete = false;
while ~complete && ~feof(fid)
    str = fgetl(fid);

    if foundRev
        % Parsing data for requested revision
        if strncmp(str, '#end', 4)
            % Done reading header offsets
            complete = true;
        elseif ~isempty(str) && ~all(isspace(str))
            % Read sizes
            hdr_szs(end+1) = str2double(str);
        end
        
    elseif strncmp(str, '#', 1) && ~strncmp(str, '#end', 4)
        % Found a line with #REVNUM ... read it
        rev = str2double(str(2:length(str)));        
        if rev == rdbm_rev
            % Found the matching revision
            hdr_szs = rev;
            foundRev = true;
        end
    end
end

fclose(fid);

% Confirm that the sizes were valid and #end was found
if foundRev && (any(isnan(hdr_szs)) || ~complete)
    error('read_headerinfo:fileFormat', ...
        '%s contains invalid data for revision %f', textfile, rdbm_rev);
end
