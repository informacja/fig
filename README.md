# fig 💽
Simple saving figures library for Matlab

### Library installation
Copy and paste this in your MATLAB console
```matlab
proj_path = pwd;
cd(fullfile(userpath));
urlwrite ('https://raw.githubusercontent.com/informacja/fig/main/startup.m', 'startup.m');
 urlwrite ('https://raw.githubusercontent.com/informacja/fig/main/figPSW.m', 'figPSW.m');
  urlwrite ('https://raw.githubusercontent.com/informacja/fig/main/figPW.m', 'figPW.m');
   urlwrite ('https://raw.githubusercontent.com/informacja/fig/main/figP.m', 'figP.m');
urlwrite ('https://raw.githubusercontent.com/informacja/fig/main/eps2pdf.m', 'eps2pdf.m');
startup;
cd(proj_path);
fprintf(1,'Now you can type here "figPW" or figPW("svg") to save last figure. If you want save all opened figures just run "figPSW".\nIf you add an extension as a first parmeter timestamp will be added to filename\n')
```

## For saving figures without margin to pdf

Install Ghostscript (only for Win or Linux).
