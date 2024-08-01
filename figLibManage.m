% Install/uninstall figLib 
% if warnings (on Windows) try run MATLAB as admin
% % Change log
% 
% 0.0.0.0 - simple urlwrite donwload 3 file and add to path
% 0.0.0.1 - 5 files download 
% 0.0.0.2 - check existance before download file
% 0.0.1.0 - added unistallation option
% 0.0.1.1 - listOfFiles in loop implementation
% 0.1.0.0 - figLib/extras folders init                                      20.07.24
% 1.0.0.0 - figLib manage (download & uninstall) by gitclone                29.07.24


% TODO try catch, webwrite
installFigLib = 1; % 0 to uninstall
% edit(fullfile(userpath,'startupFigPSW.m')) % install script version  0.0.1.1

% after first release, git clone will be replaced by versioned package
listOfFiles = [
    "https://raw.githubusercontent.com/informacja/fig/main/ver.zip", "ZIP"; 
    ];

cd(fullfile(userpath));

for(i = 1:length(listOfFiles))
    if(all([~isfile(listOfFiles(i,2)), installFigLib]))
        urlwrite(listOfFiles(i,1), listOfFiles(i,2));  
    end
    if(all([isfile(listOfFiles(i,2)), ~installFigLib])) delete(listOfFiles(i,2));  end
end

if(~installFigLib) 
    disp("Fig library is uninstalled");
    rmpath
else
    addpath(fullfile(userpath)) 
    addpath(strcat(fullfile(userpath),"/figLib/extras"))
    savepath
end


