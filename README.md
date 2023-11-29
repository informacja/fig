# fig 💽
Simple saving figures library for Matlab. Auto generate saved vector graphic (eg. PDF) filename [exampleCode](exampleCode.m)

### Library installation
Copy and paste this in your MATLAB console, if you want to update use [overwrite](overwrite.md) command or [uninstall](uninstall.md)
```matlab
proj_path = pwd;
cd(fullfile(userpath));
urlwrite ('https://raw.githubusercontent.com/informacja/fig/main/startupFigPSW.m', 'startupFigPSW.m');
startupFigPSW;
cd(proj_path);
clc; fprintf(1,'Now you can type here "help figPW".\nIf you want save all opened figures just run "figPSW".\n')
```

<!-- urlwrite ('https://raw.githubusercontent.com/informacja/fig/main/figPSW.m', 'figPSW.m');
  urlwrite ('https://raw.githubusercontent.com/informacja/fig/main/figPW.m', 'figPW.m');
   urlwrite ('https://raw.githubusercontent.com/informacja/fig/main/figP.m', 'figP.m');
urlwrite ('https://raw.githubusercontent.com/informacja/fig/main/eps2pdf.m', 'eps2pdf.m');
 urlwrite ('https://raw.githubusercontent.com/informacja/fig/main/finder.m', 'finder.m');

 -->
## For saving figures without margin to pdf

```matlab
figPW("exportPdf", 1, "overwrite", 1, "openFolder", 1, "TNR", 0) % disable automatic Times New Roman font changing
```
<!-- 
*Install Ghostscript (works only for Win or Linux) *
 -->

 
*If you have deleted or permission error, check you have opened file in PDF reader*
