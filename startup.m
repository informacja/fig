
% edit(fullfile(userpath,'startup.m'))

% install script version  0.0.0.2
cd(fullfile(userpath));

% TODO try catch, webwrite
if ~isfile('figPSW.m')
    urlwrite ('https://github.com/informacja/fig/blob/main/figPSW.m', 'figPSW.m')
end

if ~isfile('figPW.m')
    urlwrite ('https://github.com/informacja/fig/blob/main/figPW.m', 'figPW.m')
end

if ~isfile('figP.m')
    urlwrite ('https://github.com/informacja/fig/blob/main/figP.m', 'figP.m')
end

addpath(fullfile(userpath)) 
savepath % if warnings try run MATLAB as admin
