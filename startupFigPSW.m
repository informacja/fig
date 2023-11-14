installFigPSW = 1; % 0 to uninstall
% edit(fullfile(userpath,'startup.m')) % install script version  0.0.1.1

listOfFiles = [
    "https://raw.githubusercontent.com/informacja/fig/main/figPSW.m", "figPSW.m"; 
    "https://raw.githubusercontent.com/informacja/fig/main/figPW.m",  "figPW.m"; 
    "https://raw.githubusercontent.com/informacja/fig/main/figP.m",   "figP.m";
%     "https://raw.githubusercontent.com/informacja/fig/main/eps2pdf.m","eps2pdf.m";
    "https://raw.githubusercontent.com/informacja/fig/main/finder.m", "finder.m";
    ];

cd(fullfile(userpath));

for(i = 1:length(listOfFiles))
    if(all([~isfile(listOfFiles(i,2)), installFigPSW]))
        urlwrite(listOfFiles(i,1), listOfFiles(i,2));  
    end
    if(all([isfile(listOfFiles(i,2)), ~installFigPSW])) delete(listOfFiles(i,2));  end
end

if(~installFigPSW) 
    disp("Fig library is uninstalled");
else
    addpath(fullfile(userpath)) 
end
savepath % if warnings try run MATLAB as admin

% % Change log
% 
% 0.0.0.0 - simple urlwrite donwload 3 file and add to path
% 0.0.0.1 - 5 files download 
% 0.0.0.2 - check existance before download file
% 0.0.1.0 - added unistallation option
% 0.0.1.1 - listOfFiles in loop implementation

% TODO try catch, webwrite
