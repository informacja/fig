function save4article(s)
    sourcePath = "figBase/"; 
    exportPath = "article/fig/";
    prefix = "";  filename = ""; postfix = ""; 
    
    PL = 1; EN = 2;
    if(nargin == 0)
        s.lang = EN;
    end

    if(isfield(s,"figPath")) sourcePath = s.figPath; end
    if(isfield(s,"exportPath")) exportPath = s.exportPath; end
    if(isfield(s,"lang")) lang = s.lang; end
    if(isfield(s,"prefix")) prefix = s.prefix; end
    if(isfield(s,"postfix")) postfix = s.postfix; end
    if(isfield(s,"filename")) filename = s.filename; end
  
    
    % załaduj z pliku zamiast liczyć
    figFilenames = dir(strcat(sourcePath,"*.fig"));
    
    cetroidsFigNr = 0;
    fig503M = 0;
    fig509E = 0;
    stylL = 0;
    skipUpTo = length( dir([strcat(exportPath, '*.pdf')])); % USE THIS insead of index in for loop
    % skipUpTo = 0;
    
    for(i = 1:length(figFilenames))
        [~,name,~] = fileparts(figFilenames(i).name);
        pos = find(name == '_', 1, 'last');
        figFilenames(i).figNr = str2num(name(pos+1:end));
    end
    
    % [~,ind]=sort({figFilenames.date}); % by fig save date
    [~,ind]=sort([figFilenames.figNr]); % by fig nr
    
    if(~isempty(figFilenames)) % jeśli w katalogu są pliki *.fig
        % close all force
        for (i = 1:length(figFilenames))        
            if(i<=skipUpTo) figure(i); continue; end
            i = ind(i);
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
    
        % filePattern = '*.*';
        % files = dir(filePattern);
        % [~,idx] = sort(string({figFilenames.name}),2,'ascend');
        % for fileLoop=idx
        % % do something with files like print the names in order
        %     fprintf('File: %d, %s\n', fileLoop, files(fileLoop).name)
        % end
    
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

    postfix = char('a'-1+skipUpTo);
    PL = 1; EN = 2;
    if(lang == PL) fontFamily = "Verdana"; else fontFamily = "Helvetica"; end
    for (i = toSave')
        if(i<=skipUpTo) continue;  end % for crashing matlab problem and reopen
        figure(i);
        
        mnoznik = 1;
        sVal = 0; style = "stylePiotr"; 
        if( (i == cetroidsFigNr) ) mnoznik = 1.6; end
        if(i == fig503M) mnoznik = 1.8;  end
        if(i == fig509E) mnoznik = 2.2;  end
        if(i == stylL) style = "styleGrid"; sVal = 1; end
        % refresh
        % postfix = strcat("P",string(Parseval));
        postfix = char(postfix + 1);
        if(isempty(filename)) filename = string(i); end
        % sP = char(sourcePath);
        % if(1) prefix = strcat(sP(8:end),prefix); end
        
        figPW("path", exportPath, "exportPDF", 1, "openFolder", 1, "TNR", 1, ...
            "saveCopyFig", 0, "skipSaveAs", 1, "scale", mnoznik, style, sVal, ...
            "fileName", strcat(prefix, filename, postfix),'font',fontFamily);
        close(i);
    end
end