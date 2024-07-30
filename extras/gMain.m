function [fileContent] = gMain (dataDirFilenames)
% Generate main.m
%  Optional param "dataDir" to data, will make a comment about dataset
% Example 1
%   gMain("data")
% Example 2
%   gMain(dir)

figLibInitializerName = "figLib";
DispLimit = 700; % of files signed by dot, print(".") per file while processing
mainMfileName = "main.m"; % create name
commentStr = '%';

fileContent = []; infoAboutDirs = []; infoAboutExt = []; showInfoAboutFiles = 0;
if(nargin == 0)
    % templateMain.m to file, mayby without gen date?
else
    if(isstruct(dataDirFilenames))
        if(isfield(dataDirFilenames,"name"))
            DirFilenames = [dataDirFilenames.name " "];
        end
    elseif(isText(dataDirFilenames))
        DirFilenames = string(dataDirFilenames);
    else
        % untested
        DirFilenames = dataDirFilenames;
    end

    for(d = DirFilenames)
        if(d == '.' || d == "..") continue; end
        if(~exist(d,"dir")) %fprintf('Non existing dir "%s"\n', d);
            if(exist(d,"file") ) showInfoAboutFiles = showInfoAboutFiles+1; end
            continue;
        end
        fprintf("\nGetting info about %s", d);
        % filesExt = dir(fullfile(d,'**/*.*'))
        filesWithoutExt = dir(fullfile(d,'**/*'));
        i = 1; remainingIndex = numel(filesWithoutExt);
        while(( i <= remainingIndex))
            if(filesWithoutExt(i).isdir) filesWithoutExt(i) = [];
            else [~,~,filesWithoutExt(i).ext] = fileparts(filesWithoutExt(i).name); i = i + 1; end
            remainingIndex = numel(filesWithoutExt);
        end
        tabExt = [filesWithoutExt.ext " "]; tabExt(find(tabExt==" ")) = [];

        infoAboutCurrDir = sprintf('\n%s\tDirectory "%s" contains:',commentStr, d);
        ext = unique(tabExt); infoAboutExt = [];
        for( e = 1:numel(ext))
            currExt = ext(e);
            ind = find(tabExt==currExt);
            filesToCheck = numel(ind);
            fprintf(1 ,"\n\t%s",string(currExt));
            if(DispLimit < filesToCheck) fprintf(1,", contains %d files, progresbar (DispLimit = %d) in percentage (1 dot per 1%% point", filesToCheck, DispLimit); else fprintf(1, " (%d files)\t", filesToCheck); end
            bytesOfFilesWithExt = 0;
            for(i = 1:filesToCheck)
                if(~(DispLimit < filesToCheck)) fprintf(1,"."); else if(percentPoit) fprintf(1,"."); end; end
                bytesOfFile = fileSize(strcat(filesWithoutExt(i).folder, "/", filesWithoutExt(i).name));
                if(bytesOfFile)
                    bytesOfFilesWithExt = bytesOfFilesWithExt + bytesOfFile;
                else
                    warning("file have 0 bytes filesize")
                end
            end
            infoAboutExt = strcat(infoAboutExt, sprintf('\n%s\t\t%s\t %d files \t%.2g MB\n', commentStr, currExt, filesToCheck, bytesOfFilesWithExt/2^10/2^10));
        end
        infoAboutDirs = strcat(infoAboutDirs,infoAboutCurrDir, infoAboutExt );%sprintf('\n%s\t\t%s',);
    end
end
if(showInfoAboutFiles) fprintf('\n%d files in current folder skipped. (To include souce files put them in subfoler eg. name "data")', showInfoAboutFiles); 

genTime = datetime('now','TimeZone','local','Format','d-MM-y HH:mm:ss Z');
infoGen = sprintf('\n\n%s This file was generated by "gMain" extras of "figLib" at %s\n', commentStr, genTime);

t = fileread('templateMain.m');
pos = strfind(t,figLibInitializerName);
tBeging = t(1:pos);
if(contains(tBeging,newline))
    pos = regexp(tBeging, '[\n]');
    pos = pos(end); % if more than 1
end
b = t(1:pos); e = t(pos:end);

fileContent = strcat(b, infoAboutDirs, infoGen, e);
if(exist(mainMfileName,"file"))
    tx = sprintf("\nFile %s/%s exist. To overwrite type yes, or any other key [Enter] to skip.", pwd, mainMfileName);
    in = input(tx, "s");
    if(~strcmp (in, "y") && ~strcmp (in, "yes"))
        fprintf(1, "Skipped\n"); return;
    end
    fprintf(1, "Overwriting file %s/%s\n", pwd, mainMfileName);
end
[fid,msg] = fopen(mainMfileName,'wt');
assert(fid>=3, msg)
fprintf(fid,'%s',fileContent);
fclose(fid);
open(mainMfileName);
end