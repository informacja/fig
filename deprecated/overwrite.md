### Library update
Copy and paste this in your MATLAB console to update  
```matlab
proj_path = pwd;
cd(fullfile(userpath));
urlwrite ('https://raw.githubusercontent.com/informacja/fig/main/startupFigPSW.m', 'startupFigPSW.m');
 urlwrite ('https://raw.githubusercontent.com/informacja/fig/main/figPSW.m', 'figPSW.m');
  urlwrite ('https://raw.githubusercontent.com/informacja/fig/main/figPW.m', 'figPW.m');
   urlwrite ('https://raw.githubusercontent.com/informacja/fig/main/figP.m', 'figP.m');
urlwrite ('https://raw.githubusercontent.com/informacja/fig/main/eps2pdf.m', 'eps2pdf.m');
 urlwrite ('https://raw.githubusercontent.com/informacja/fig/main/finder.m', 'finder.m');
startupFigPSW;
cd(proj_path);
clc; fprintf(1,'Now you can type here "help figPW".\nIf you want save all opened figures just run "figPSW".\n')
```
