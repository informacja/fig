# figLib 💽
Library created for saving figures in Matlab. 

### Library installation
Copy and paste this in your MATLAB console, if you want to update use _git pull_ command
```matlab
proj_path = pwd; cd(fullfile(userpath)); if(exist("figLib","dir")) rmdir("figLib", 's'); end
gitclone("https://github.com/informacja/fig", "figLib", Depth=1);
addpath(strcat(fullfile(userpath),"/figLib")); addpath(strcat(fullfile(userpath),"/figLib/extras")); savepath;
cd(proj_path); clc; fprintf(1,'To save current figure, just type here "figPW" (if not exist, empty will be created)\nAfter that you can type "help figPW" for more information about function arguments.\nIf you want save all opened figures just run "figPSW". For more information about whole library type "help fig"\n')
```

### Library uninstallation
Copy and paste this in your MATLAB console
```matlab
proj_path = pwd; cd(fullfile(userpath)); fprintf(1,'Uninstalling ... "figLib"\n'); if(exist("figLib","dir")) rmdir("figLib", 's'); end
rmpath(strcat(fullfile(userpath),"/figLib")); rmpath(strcat(fullfile(userpath),"/figLib/extras")); savepath;
cd(proj_path); fprintf(1,'Succesfully uninstalled "figLib"\n')
```
## For saving figures without margin to pdf (for article)

```matlab
figPW art % paste and run in Command Window
```
 
*If you have deleted or permission error, check you have opened file in PDF reader*

### Article data flow proposed to use with figLib
![](./Article%20data%20flow%20proposed%20to%20use%20with%20figLib.png)
