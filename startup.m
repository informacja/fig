
% edit(fullfile(userpath,'startup.m'))

% install script version  0.0.0.1
cd(fullfile(userpath));

% try catch, webwrite
if ~isfile('figPSW.m')
 path(1) = urlwrite ('https://raw.githubusercontent.com/informacja/MTF/main/figPSW.m', 'figPSW.m');
end

if ~isfile('figPW.m')
 path(2) = urlwrite ('https://raw.githubusercontent.com/informacja/MTF/main/figPW1.m', 'figPW.m')
end

if ~isfile('figP.m')
 path(3) = urlwrite ('https://raw.githubusercontent.com/informacja/MTF/main/figP.m', 'figP.m');
end

addpath(fullfile(userpath))
savepath
