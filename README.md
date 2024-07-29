# fig 💽
Simple saving figures library for Matlab. Auto generate saved vector graphic (eg. PDF) filename [exampleCode](exampleCode.m)

### Library installation
Copy and paste this in your MATLAB console, if you want to update use _git pull_ command
```matlab
proj_path = pwd; cd(fullfile(userpath)); 
if(exist("figLib","dir")) rmdir("figLib", 's'); end
gitclone("https://github.com/informacja/fig", "figLib", Depth=1);
addpath(strcat(fullfile(userpath),"/figLib")); addpath(strcat(fullfile(userpath),"/figLib/extras"))
cd(proj_path);
clc; fprintf(1,'To save current figure, just type here "figPW" (if not exist, empty will be created)\nAfter that you can type "help figPW" for more information about function arguments.\nIf you want save all opened figures just run "figPSW". For more about whole library type "help fig"\n')
```

## For saving figures without margin to pdf (for article)

```matlab
figPW art % paste and run in Command Window
```
<!-- 
*Install Ghostscript (works only for Win or Linux) *
 -->

 
*If you have deleted or permission error, check you have opened file in PDF reader*
