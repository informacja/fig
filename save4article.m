sourcePath = "./"; 
exportPath = "fig4Article/";
% załaduj z pliku zamiast liczyć
figFilenames = dir(strcat(sourcePath,"*.fig"));

cetroidsFigNr = 0;
fig503M = 0;
fig509E = 0;
stylL = 0;
skipUpTo = length( dir([strcat(exportPath, '*.pdf')])); % USE THIS insead of index in for loop

if(~isempty(figFilenames)) % jeśli w katalogu są pliki *.fig
    close all force
    for (i = 1:length(figFilenames))        
        if(i<=skipUpTo) figure(i); continue; end
        [filepath,name,ext] = fileparts(figFilenames(i).name);
        pos = find(name == '_', 1, 'last');
        a = openfig(strcat(figFilenames(i).folder,"/",figFilenames(i).name));
        if(strfind(figFilenames(i).name,"1023")) cetroidsFigNr = i; end
        if(strfind(figFilenames(i).name,"503")) fig503M = i; end
        if(strfind(figFilenames(i).name,"509")) fig509E = i; end
        if(strfind(figFilenames(i).name,"555")) stylL = i; end
        % if(i==6) break; end
    end
    backup = 0;
else
    fprintf(1,"In folder '%s' any *.fig file not found\nContinue? Save all figure opened in matlab. (Enter)", sourcePath); pause
end

figHandles = findobj('Type', 'figure');
num = [];
for(i = 1:length(figHandles))
    num = [num; figHandles(i).Number];
end
num = sort(num); % figNr

toSave = [];
for(i = 1:length(num))
    toSave = [toSave; num(i)];
end

for (i = toSave')
    if(i<=skipUpTo) continue;  end % for crashing matlab problem and reopen
    figure(i);
    
    mnoznik = 1;
    style = "styleLudwin";%stylePiotr";
    if( (i == cetroidsFigNr) ) mnoznik = 1.6; end
    if(i == fig503M) mnoznik = 1.8;  end;
    if(i == fig509E) mnoznik = 2.2;  end;
    if(i == stylL) style = "styleLudwin"; end
    % refresh
    style = "stylePiotr";
    mnoznik = 2.2; 
    figPW("path", exportPath, "exportPDF", 1, "openFolder", 1, "TNR", 0, ...
        "saveCopyFig", 0, "skipSaveAs", 1, "scale", mnoznik, style, 1);
end
