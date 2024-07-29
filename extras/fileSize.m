function [bytes] = fileSize(path)
% Returns file size in bytes
%   for MB just: filesizeInBytes/2^10/2^10;

[fid,msg] = fopen(path); bytes = 0;
assert(fid>=3,msg)
fseek(fid, 0, 'eof');
filesize = ftell(fid);
fclose(fid);
bytes = filesize;
end