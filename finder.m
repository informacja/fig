function finder(foo,root)
%FINDER - Opens a separate file explorer window
%
% finder(target)
%
% opens a new file explorer window at the given target
% Windows: explorer window
% Mac osx: finder window
% Unix:    xterm window (not tested, don't have unix)
%
% target may be a folder or filename
% throws an error if the specified folder or file cannot be found
%
% finder(target,true)
% If the second input is true:
% in windows, this will open explorer with the folder hierachy visible
% in mac and unix, this does nothing
%
% Examples:
%   finder(pwd,1)
%   finder peaks
%   finder /home
%
% See Also:
% cd, GetFullPath
% https://uk.mathworks.com/matlabcentral/fileexchange/28249-getfullpath

%parse input
if nargin<2
    root = 0;
    if nargin<1
        foo = pwd;
    end
end

allow_sub = false;
%allow subfolders that start with file separators
%off by default, because that's what people expect
%If set to true, finder('/home') will additionally allow the
%pwd/home folder to be found
%otherwise, will only allow /home as a valid target

%does this exist as a folder ? if so, that's the target
isfile = false;
found = exist(foo,'dir');

%are we allowed to search subfolders, and does it exist as a folder ?
if ~found && allow_sub && exist(fullfile(pwd,foo),'dir')
    foo = fullfile(pwd,foo);
    found = true;
end

if ~found && exist(foo,'file')
    if ~isempty(which(foo))
        foo = which(foo);
    end
    found = true;
    isfile = true;
end

%if not found, throw an error and stop
if ~found; error('Could not find: %s',foo); end

%if we have got this far, have a valid target
%The following three sections are one per operating system

%PC/windows
%This is Malcolm Wood's original
if ispc
    % Get just the directory part of the file name.
    if isfile; foo = fileparts(foo); end
    if root
        % Open the Explorer window with the Folders tree visible and
        % with this directory as the root
        command = ['explorer.exe /e,/root,' foo];
    else
        % Just open an Explorer window without the Folders tree
        command = ['explorer.exe ' foo];
    end
    
%     [~,b] = dos(command);
    winopen(foo)
%     if ~isempty(b)
%         error('Error starting Windows Explorer: %s', b);
%     end
    return
end
 
%MAC / OSX
%this is the bit I added
if ismac %command syntax if under mac
    %the -R flag will reveal (highlight) the item if it is a file
    %the & creates a separate process, so matlab isn't halted until
    %the new window closes
%     if isfile
%         system(['open -R ' foo ' &'])
        [status, results] = system(['open -a finder ' foo ]);
        if(any(status) || any(results))
          [status, results]
        end
%     else
%         system(['open ' foo ' &']);
%     end
    return %this is needed, because mac systems also have isunix=1, so
    %would run the part below as well
end

%UNIX / LINUX : untested
%This I can't test, because I don't have unix :\
if isunix
    warning('the author doesn''t have unix - I''d love to hear from you if this works');
    
    %the below ought to open an xterm window
    
    %get just the directory
    foo = fileparts(foo);
    %opens a new xterm window
    %unix('xterm &');
    %opens a new xterm window cd to the specified folder
    unix(['xterm  -e cd ' foo ' &']);
end

end
% version 2018.11.22 by C. Pedersen. next changes 2023
% Acknowledgements:
% Based on 'explorer' by Malcolm Wood, from:
% http://www.mathworks.com/matlabcentral/fileexchange/11064-explorer-m-quick-access-to-the-windows-explorer
% Thanks "Jan" for feedback full pat & subfolders
%https://uk.mathworks.com/matlabcentral/profile/authors/869888-jan 