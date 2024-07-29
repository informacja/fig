function openInEditorPSW(varargin)
% Open important files in editor

% without extension! string array

% Pomysł
% if no param open only called file.m and make avtive

% TODO UPDATE for array(list) as one param;

% is open in editor?
%
% [p,name,ext] = fileparts(fullfile(strcat(pwd,'/',mfilename('name'),'.m')))
% matlab.desktop.editor.isOpen(strcat(p,'/',name,ext))
x=[];
for(i=1:numel(varargin))
    % varargin{i}
    x = [x; varargin{i}];
end

openFilenamesInEditor = x;
% filesInEditor = matlab.desktop.editor.getAll;
% for(i = 1:numel(filesInEditor))
%     [name,ext] = fileparts(filesInEditor.Filename(i));
%     X = [X; strcat(name,'.',ext)];
% end
if(inMobileRuned)1 % on mobile app
    return
end
activeFileBeforeOpeningProcedure = matlab.desktop.editor.getActiveFilename; % on mobile not working

for(i = 1:size(openFilenamesInEditor,1))
    [p,name,ext] = fileparts(fullfile(strcat(pwd,"/",openFilenamesInEditor(i,:),".m")));
    s = strcat(p,'/',name,ext);
    x = matlab.desktop.editor.isOpen(s);
    if(~x) if(exist(s, "file")) open(s); else warning(sprintf("File %s not exist", s)); end
    end

    if(~ismissing(activeFileBeforeOpeningProcedure))
        open(activeFileBeforeOpeningProcedure);
    end
end
end