function save2folder(s)
    
    figPath = "figBase/"; 
    
    figNrList = [
        251
        253
        % 501
        % 502 % done by shringking
        503
        509
        1013
        1023
        2005
        2059
        2069
        2078
        4001
        4002
        4003
    ];    
    if(isfield(s,"figNrList")) figNrList = s.figNrList; end
    if(isfield(s,"exportPath")) figPath = s.figPath; end
    % if(isfield(s,"skipSavedFig")) skipSavedFig = s.skipSavedFig; end
    
    figFilenames = dir(strcat(figPath,"*.fig"));
        
    figHandles = findobj('Type', 'figure');
    num = [];
    for(i = 1:length(figHandles))
        num = [num; figHandles(i).Number];
    end
    num = sort(num); % figNr
    
    toSave = [];
    for(i = figNrList')
        i = find(num==i);
        toSave = [toSave; num(i)]; 
    end
    if(isempty(toSave))
        disp("No figures on list")
    end
    toSave = num;
    
    c = 0;
    for (i = toSave') 
        c = c+1;
        if(numel(figFilenames)>= c) continue; end
        figure(i);   
        figPW("path", figPath, "exportPDF", 0,"openFolder",1,"saveCopyFig", 1,"skipSaveAs", 1, "TNR", 0);
        close(i);
    end
end