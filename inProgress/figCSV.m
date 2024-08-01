function [outputArg1, outputArg2] = figCSV(varargin)
%figCSV function saves named arguments to CSV file.
%   Detailed explanation goes here
%   Path - path

    if(numel(varargin) < 1) warning('No arguments. Use help command'); end

    saveFolder = mfilename('name'); if(~exist(saveFolder,"dir")) mkdir(saveFolder); end
    % check file exist if not add header
    var1name = inputname(1); createFileAddHeader = 0; fnameNotSpecified = 0;
    fname = strcat(saveFolder,'/',var1name,".csv");
    if(length(var1name) < 1) fname = strcat(saveFolder,'/',"tmp.csv"); fnameNotSpecified = 1; end
    fid = fopen(fname,'r');
    if(fid > 0) fclose(fid);
    else createFileAddHeader = true;  end
        
    fid = fopen(fname,'a');

    if(createFileAddHeader)
        if(fnameNotSpecified) fprintf("No first param name specified, saving to %s file\n", fname); end
        for( i = 1:numel(varargin) )
            iname = inputname(i);
            if(length(iname) < 1) fprintf(fid, "\tvar_%d", i);        
            else fprintf(fid, "\t%s", iname); end
        end
        fprintf(fid, "\n");
    end
    for( i = 1:numel(varargin) )
        fprintf(fid, "\t%g", varargin{i});        
    end
    fprintf(fid, "\n");
    fclose(fid);
end