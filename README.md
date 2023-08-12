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
 urlwrite ('https://raw.githubusercontent.com/informacja/fig/main/finder.m', 'finder.m');
startup;
cd(proj_path);
clc; fprintf(1,'Now you can type here "help figPW".\nIf you want save all opened figures just run "figPSW".\n')
```

## For saving figures without margin to pdf

```matlab
figPW("exportPdf", 1 ,"openFolder", 1, "TNR", 0) % disable automatic Times New Roman font changing
```

*Install Ghostscript (works only for Win or Linux)*
