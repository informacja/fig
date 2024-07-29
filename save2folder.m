function save2folder(s)
% todo: if no param, example use of struct
    
    figPath = "figBase/"; 
    
    figNrList = [
        251
        253
        % 501
        % 502 % done by shrinking
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
    if(isfield(s,"figPath")) figPath = s.figPath; end
    % if(isfield(s,"skipSavedFig")) skipSavedFig = s.skipSavedFig; end
    
    figFilenames = dir(strcat(figPath,"*.fig"));
        
    figHandles = findobj('Type', 'figure');
    num = [];
    for(i = 1:length(figHandles))
        num = [num; figHandles(i).Number];
    end
    num = sort(num); % figNr
    
    i = [];
    toSave = [];
    if(iscolumn(figNrList))
        figNrList = figNrList';
    end
    for(i = figNrList)
        j = find(num==i);
        toSave = [toSave; num(j)]; 
    end
    if(isempty(toSave))
        disp("No figures on list")
    end
    % toSave = num; % save all
    
    c = 0;
    for (i = toSave') 
        c = c+1;
        if(numel(figFilenames)>= c && numel(figFilenames) <= numel(toSave)) continue; end
        figure(i);   
        figPW("path", figPath, "exportPDF", 0,"openFolder",1,"saveCopyFig", 1,"skipSaveAs", 1, "TNR", 0);
        close(i);
    end
end