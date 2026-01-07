function save4article(s)
% Automation with params to save fig for article

% on macOS load from file (for reliability)

    PL = 1; EN = 2;
    if(nargin == 0) s.lang = EN; lang=EN; 
    elseif(isfield(s,"lang")) lang = s.lang; 
    else lang=EN; end

    sourcePath = "figBase/"; 
    exportPath = "article/fig/";
    if(lang==PL) exportPath = "article/figPL/"; end

    prefix = "";  filename = ""; postfix = ""; 
    saveFigNr = 1; % use true when save directly, whithout load form fig file [nameing convention]
    inch3dot25 = -1;
    timeout = 10;

    if(isfield(s,"figPath")) sourcePath = s.figPath; end
    if(isfield(s,"exportPath")) exportPath = s.exportPath; end
    if(isfield(s,"prefix")) prefix = s.prefix; end
    if(isfield(s,"postfix")) postfix = s.postfix; end
    if(isfield(s,"filename")) filename = s.filename; end
    % if(strcmp(exportPath, "article/fi/")) inch3dot25 = -1.618; end % negative scale for article column
    inch3dot25 = 0;
    if(isfield(s,"inch3dot25")) inch3dot25 = s.inch3dot25; end
    if(isfield(s,"timeout")) timeout = s.timeout; end
    if(isfield(s,"figNrList")) figNrList = s.figNrList; end
    if(isfield(s,"figNrGridSize")) figNrGridSize = s.figNrGridSize; end
    
    if(saveFigNr)ePchar=char(exportPath); exportPath=ePchar(1:end-1)+"Nr/"; end
   
    if(~isempty(ismember(findall(0,'type','figure'),groot))) % jeśli są otwarte figury, to je eksportuj     
        F = findobj('Type', 'figure'); postfix = char('a'-1);
        for(i=1:numel(F))
            if(exist("figNrList", "var") && isempty(find(figNrList==F(i)))) continue; end
            figure(F(i))
            mnoznik = 1;
            sVal = 1; style = "stylePiotr"; 
            % style = "styleGrid"; sVal = 1; 
            if(saveFigNr)
            postfix = F(i).Number;
            else
            postfix = char(postfix + 1);
            end
            if(isempty(filename)) filename = string(i); end
            fontFamily = "Helvetica";
            % 
            % set(gcf,'WindowStyle','normal')
            % width = 13; % inches
            % hight =  6.5000;
            % 
            % if(exist("figNrGridSize","var"))
            %     rowNr = find(gcf().Number==cell2mat(figNrGridSize(:,1)));
            %     if(~isempty(rowNr))
            %         dim = figNrGridSize(rowNr,2:3);
            %         set(gcf,'Units','inches');                        % jednostka wymiarowania okna
            %         set(gcf,'Position', [0 0 width*2*dim{1} hight*2*dim{2}]); % wymiary okna: (x,y,dx,dy), (x,y)- lewy dolny
            %     end                
            % else                 
                % if(~exist("gcf().Children.GridSize","var"))
                %     if(gcf().Number==25) figNum = figConvert(gcf().Number,2,2,2,4); figure(figNum); 
                %         set(gcf,'Units','inches');                        % jednostka wymiarowania okna
                %         set(gcf,'Position', [0 0 width*2 hight*2]); % wymiary okna: (x,y,dx,dy), (x,y)- lewy dolny
                %     end
                % else           
                %     set(gcf,'Units','inches');                        % jednostka wymiarowania okna
                %     set(gcf,'Position', [0 0 width*gcf().Children.GridSize(1) hight*gcf().Children.GridSize(2)]); % wymiary okna: (x,y,dx,dy), (x,y)- lewy dolny
                % end
            % end



            figPW("path", exportPath, "exportPDF", 1, 'vectorReplacedByTIFFigBytes', 10e9, "openFolder", 1, "TNR", 0, ... 
            "saveCopyFig", 0, "skipSaveAs", 1,... %"scale", mnoznik, style, sVal, ...
            "fileName", strcat(prefix, filename, string(postfix)));%,'font',fontFamily, ...
            % 'goldenRatio', inch3dot25, "interpreter", 'tex');
        end
        return
    end
    
    nbrfig = 1;
    handle = findobj(allchild(groot), 'flat', 'type', 'figure', 'number', nbrfig);

    if(~isempty(handle)) %disp("Some figures are open, do you wana continue? [Enter]"); pause
        fprintf(1,"\nIn %d seconds, all figures will be forced to close! ", timeout);
       
        for( i = timeout:-1:0 )
            fprintf(1,"%d ", i); pause(1);           
        end
        close all force
        fprintf(1,"\n")
        % fprintf(1,"\n", timeout);
    end
    
    % załaduj z pliku zamiast liczyć
    figFilenames = dir(strcat(sourcePath,"*.fig"));
    
    cetroidsFigNr = 0;
    fig503M = 0;
    fig509E = 0;
    stylL = 0;
    % skipUpTo = length( dir([strcat(exportPath, '*.pdf')])); % USE THIS insead of index in for loop
    % skipUpTo = 0;
    
    for(i = 1:length(figFilenames))
        [~,name,~] = fileparts(figFilenames(i).name);
        pos = find(name == '_', 1, 'last');
        figFilenames(i).figNr = str2num(name(pos+1:end));
    end
    
    % [~,ind]=sort({figFilenames.date}); % by fig save date
    if(isfield(figFilenames, "figNr"))
        [~,ind]=sort([figFilenames.figNr]); % by fig nr
    end
    if(~isempty(figFilenames)) % jeśli w katalogu są pliki *.fig
        % close all force
        for (i = 1:length(figFilenames))        
            if(exist("skipUpTo", "var"))
                if(i<=skipUpTo) figure(i); continue; end
            end
            if(exist('ind','var'))
                i = ind(i);
            end
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
        saveFigNr = 1;
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
        % if(num(i) is in opened figures in save2folder )
        toSave = [toSave; num(i)];
    end
       
    if(exist("skipUpTo", "var")) postfix = char('a'-1+skipUpTo); 
    else postfix = char('a'-1); end
    PL = 1; EN = 2;
    if(lang == PL) fontFamily = "Verdana"; else fontFamily = "Helvetica"; end
    for (i = toSave')
        if(exist("skipUpTo", "var")) if(i<=skipUpTo) continue;  end; end% for crashing matlab problem and reopen
        figure(i);
        
        mnoznik = 1;
        sVal = 1; style = "stylePiotr"; 
        % if( (i == cetroidsFigNr) ) mnoznik = 1.6; end
        % if(i == fig503M) mnoznik = 1.8;  end
        % if(i == fig509E) mnoznik = 2.2;  end
        if(i == stylL) style = "styleGrid"; sVal = 1; end
        % refresh
        if(saveFigNr)
            postfix = i;
        else
            % postfix = strcat("P",string(Parseval));
            postfix = char(postfix + 1);
        end
        if(isempty(filename)) filename = string(i); end
        % sP = char(sourcePath);
        % if(1) prefix = strcat(sP(8:end),prefix); end
        
        figPW("path", exportPath, "exportPDF", 1, "openFolder", 1, "TNR", 1, ... 
            "saveCopyFig", 0, "skipSaveAs", 1, "scale", mnoznik, style, sVal, ...
            "fileName", strcat(prefix, filename, string(postfix)),'font',fontFamily, ...
            'goldenRatio', inch3dot25, "interpreter", 'tex');
        % close(i);
    end
end