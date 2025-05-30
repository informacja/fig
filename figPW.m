function figPW(varargin)% FigType, ext, katalog)
% Saves current figure, main part of figLib.
% Central part of 3 functions: figP, figPW and figPSW. Use the last one to save many figures.
%
% Usage:
%       figPW("copy", 1) % Figure will be copied to clipboard
%       figPW copy       % short version, with auto setting parameters 
% or just (fast version) save current figure to file with timestamp in filename
%       figPW
%
% Function gets pair of arguments. (as "copy" above), if not specified
%   second argument enable or disable functionality
%
% Example params (true or false, second pair param):
%   copy - get your figure without margin, into clipboard and past into your document,
%   maxF - maximize current figure before saving,
%   exportPdf - export wector graphics figure to PDF file (main option of lib),
%   openFolder - open exported file directory,
%   argOpenFile - open file in system default program,
%   tileSpacing - if is posible apply of this: "loose" (default) | "compact" | "tight" | "none"
%   tilePadding - "none" (default) | "loose" | "compact" | "tight"
%   overwrite - delete file before exportig, to avoid permission confilct on Windows
%   timestamp - add date and time to exported filename
%   hqPNG - export high quality png file,
%   axis - add param for axis, eg. figPW("axis", "tight"),
%   hLegend - horizontal legend,
%   Interpreter - eg. figPW("Interpreter", "latex")
%   styleLudwin - predefined figure style, to enable (1) | (0) to disable
%   stylePiotr - predefined figure style, to enable (1) | (0) to disable
%   noMargin - deprecated, replaced by "copy" or "exportPDF"
%   TNR - automatic Times New Roman font changing
%   saveCopyFig - defalut = true (backup file)
%   argSkipSaveAs - doesn't save default file, default = false
%   nrF - just select figure you want to save
%   vectorReplacedByTIFFigBytes - size of figure, default = 50 000, 
%       only for export fig argument
%   scale - set the scalar, default = 1
%   valScaleX - scale horizontally
%   valScaleY - scale vertically
%   fileName - set output files before extension text
%   styleGrid - add grid scale
%   font - Familly fontName (eg. "Verdana")
%   plotContur - black contur (true)
%   goldenRatio - default = 1, if none zero, use as floating point scalar
%       pixels, if negative scalar value use as 3.25 inch article column size
% 
%  Example optioal params with value
%   path - specyfy output file prefix of folder (with slash at end) path
%   ext - extension for files
% 
% Args are compared case insensitive
%
% Example 1: % for PhD students
%       figPW("exportPdf", 1, "openFolder", 1, "TNR", 0, "styleLudwin", 1, "overwrite", 1)
% 
% Example 2: 
%       figPW("path", exportPath, "exportPDF", 1,"openFolder",1,"saveCopyFig", ...
%              backup,"skipSaveAs",1, "scale", mnoznik);
% Example 3:
%       figPW art

% TODO 
% h = figure(1); h.Position = [1        1        1000*1.618033      1000  ]; 
% overlafGithubLimit = 50 MB for files

% schowek do pdfa no margin
% size legend
% open filo
% instal ghostscript link


% if file exist timestamp add
%  "figPW(ext = 'png', FigType = 0 do 4, katalog = 'figury/')",...
%0 fast
% overwrite flag
%     "figPW('svg', 4, 'figury/')"); -2 dbstack? if figPSW
% if( nargin==1 && length(dbstack(1)) == 0 ) % if only one param & not runed from console
%     fprintf('%s\n%s\n',...
%     "figPW(ext = 'png', FigType = 0 do 4, katalog = 'figury/')",...
%     "figPW('svg', 4, 'figury/')");
% end
% parse multiple arg
% arguments (Repeating)
%     varargin string
% end
% set(0,'DefaultAxesFontName','CMU Serif Roman') 

if nargin == 1
    % inName = inputname(1) % not working
  while 1 % used to skip section of code statement by break; keyword 
    if(isnumeric( varargin{1} ))
        FigType = varargin{1}; % change to fig nr
    elseif(isText( varargin{1} ))
        if( strcmpi(varargin{1}, "art") || strcmpi(varargin{1}, '"art"') ) % set default for article arguments
            c=1; 
            varargin{c} = "exportPDF";  c=c+1; varargin{c} = 1; c=c+1; 
            % varargin{c} = "maxF";       c=c+1; varargin{c} = 1; c=c+1;
            % varargin{c} = "goldenRatio";c=c+1; varargin{c} = -2; c=c+1;
            varargin{c} = "openFolder"; c=c+1; varargin{c} = 1; c=c+1;
            varargin{c} = "skipSaveAs"; c=c+1; varargin{c} = 1; c=c+1; 
            varargin{c} = "vectorReplacedByTIFFigBytes"; c=c+1; varargin{c} = 2^30; c=c+1;            
            % varargin{5} = "stylePiotr"; varargin{6} = 1;
            % varargin{c} = "maxF";       c=c+1; varargin{c} = 1; c=c+1;
            % nargin = numel(varargin)
            % varargin{1} = "maxoveleaf50";
        elseif( strcmpi(varargin{1}, "hq") || strcmpi(varargin{1}, '"hq"') ) % set default for article arguments
            c=1; 
            varargin{c} = "hqpng";      c=c+1; varargin{c} = 1; c=c+1;
            varargin{c} = "openFolder"; c=c+1; varargin{c} = 1; c=c+1;
            varargin{c} = "goldenRatio";c=c+1; varargin{c} = 0; c=c+1;
            varargin{c} = "saveCopyFig";c=c+1; varargin{c} = 0; c=c+1;
            varargin{c} = "skipSaveAs"; c=c+1; varargin{c} = 1; c=c+1; 
            varargin{c} = "tileSpacing"; c=c+1; varargin{c} = "tight"; c=c+1; 
            varargin{c} = "tilePadding"; c=c+1; varargin{c} = "none"; c=c+1;  % none ?                      
            % (convertIfOldTypeFig, 1)
        elseif( strcmpi(varargin{1}, "copy") || strcmpi(varargin{1}, '"copy"') ) % set default for article arguments
            c=1; varargin{c} = "copy"; c=c+1; varargin{c} = 1; c=c+1;
        else
            % unmached = 1
            break;
        end
        fprintf(1, "   figPW("); comma = ', '; c = c-1;
        for( i = 1:2:c )
            if(c-i < 2) comma = ''; end
            secParam = string(varargin{i+1});
            if(isstring(varargin{i+1})) secParam = strcat( "'", string(varargin{i+1}), "'"); end
            fprintf(1, "'%s', %s%s", varargin{i}, secParam, comma );
        end
        fprintf(1, ") %% shorted param setup explanation \n");
    else
        varargin{1}
    end
    break  % prevents infinite loop
  end % while 1
        
end

% Arguments default values
valSaveTo = "fig/";
valDefaultExt = "png";
valNoTNR = "true";
valInterpreter = 'tex';
valOpenFolder = false;
valOpenFile = false;
valExportPdf = false;
valStyleLudwin = false;
valStylePiotr = false;
valOverwrite = false;
valTimestamp = false;
valSaveCopyFig = true;
valSkipSaveAs = false;
valNrF = 1;
valVectorReplacedByTIFFigBytes = 5e4;
valScale = 1; 
valScaleX = 1; 
valScaleY = 1; 
valFileName = "";
valStyleGrid = false;
valFont = "Helvetica";
valPlotContur = true;
valGoldenRatio = 1; % scaling factor
valTilePadding = 'none';

% valueAxis = "";
% valNoMarginPDF = "";

%arguments names
argCopy = "copy";
argMaxF = "maxF";
argNoMargin = "noMargin";
argHighQualityPNG = "hqPNG";
argAxis = "axis";
argHorizontalLegend ="hLegend";
argInterpreter = "Interpreter";
% argNoMarginPDF = "noMarginPDF";
argOpenFolder = "openFolder";
argOpenFile = "openFile";
argExportPdf = "exportPdf";
argOverwrite = "overwrite";
argStyleLudwin = "styleLudwin";
argStylePiotr = "stylePiotr";
argTimestamp = "timestamp";
argTileSpacing = "tileSpacing";
argSaveCopyFig = "saveCopyFig";
argSkipSaveAs = "skipSaveAs";
argNrF = "nrF";
argVectorReplacedByTIFFigBytes = "vectorReplacedByTIFFigBytes";
argScale = "scale";
argScaleX = "scaleX";
argScaleY = "scaleY";
argFileName = "fileName";
argStyleGrid = "styleGrid";
argFont = "font";
argPlotContur = "plotContur";
argGoldenRatio = "goldenRatio";
argTilePadding = "tilePadding";
argRePositonYlabel = "rePositonYlabel";

% -- Parser ---------------------------------------------------------------

p = inputParser; p.FunctionName = mfilename('name');

% p.KeepUnmatched = 1; % dont stop if param not maching 
% p.PartialMatching = 1;
% p.StructExpand  = 1;

% with default values

addOptional(p, 'ext',   valDefaultExt);
addOptional(p, 'path',  valSaveTo);
addOptional(p, 'TNR',   valNoTNR);
addOptional(p, argInterpreter, valInterpreter);
addOptional(p, argOpenFolder, valOpenFolder);
addOptional(p, argOpenFile, valOpenFile);
addOptional(p, argExportPdf, valExportPdf);
addOptional(p, argOverwrite, valOverwrite);
addOptional(p, argStyleLudwin, valStyleLudwin);
addOptional(p, argStylePiotr, valStylePiotr);
addOptional(p, argTimestamp, valTimestamp);
addOptional(p, argSaveCopyFig, valSaveCopyFig);
addOptional(p, argSkipSaveAs, valSkipSaveAs);
addOptional(p, argVectorReplacedByTIFFigBytes, valVectorReplacedByTIFFigBytes);
addOptional(p, argFileName, valFileName);
addOptional(p, argStyleGrid, valStyleGrid);
addOptional(p, argFont, valFont);
addOptional(p, argPlotContur, valPlotContur);
addOptional(p, argGoldenRatio, valGoldenRatio);
addOptional(p, argTilePadding, valTilePadding);

% without default value
optParam = [ argCopy, "TZ1", "TZ2", argNoMargin, argMaxF, argHighQualityPNG, ...
    argAxis, argHorizontalLegend, argTileSpacing, argNrF, argScale, argScaleX, argScaleY, argRePositonYlabel];

for i = 1:length(optParam)
    addOptional(p,optParam(i),[]);
end

parse(p, varargin{:});

% -- Get values from parser -----------------------------------------------

ext = p.Results.ext;
tmp = char(ext);
if(tmp(1) ~= '.') ext = strcat('.', ext); end
katalog = p.Results.path;
if isstring(p.Results.TNR) TNR = str2num( p.Results.TNR ); else TNR = p.Results.TNR; end
if isstring(p.Results.copy ) valArgCopy = str2num( p.Results.copy ); else valArgCopy = p.Results.copy; end
valueAxis       = p.Results.axis;
variantHorizontalLegend = p.Results.hLegend;
valInterpreter  = p.Results.Interpreter;
valOpenFolder   = p.Results.openFolder;
valOpenFile     = p.Results.openFile;
valExportPdf    = p.Results.exportPdf;
valOverwrite = p.Results.overwrite;
valStyleLudwin  = p.Results.styleLudwin;
valStylePiotr = p.Results.stylePiotr;
% valMaxF         = p.Results.valMaxF; todo
valTimestamp = p.Results.timestamp;
valTileSpacing = p.Results.tileSpacing;
valSaveCopyFig = p.Results.saveCopyFig;
valSkipSaveAs = p.Results.skipSaveAs;
valNrF = p.Results.nrF;
valVectorReplacedByTIFFigBytes = p.Results.vectorReplacedByTIFFigBytes;
valScale = p.Results.scale;
valScaleX = p.Results.scaleX;
valScaleY = p.Results.scaleY;
valFileName = string(p.Results.fileName);
valStyleGrid = p.Results.styleGrid;
valFont = p.Results.font;
valPlotContur = p.Results.plotContur;
valGoldenRatio = p.Results.goldenRatio;
valTilePadding = p.Results.tilePadding;
valRePositonYlabel = p.Results.rePositonYlabel;

if(~isempty(valNrF))
    figure(valNrF)
end

if(nargin<2) ext = 'png'; end;
% if(nargin<3) katalog = 'figury/'; end;

if ~exist(katalog, 'dir') mkdir (katalog); end;

%%%%%%%% Generate filename %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fTitle = ''; % do zapisywanej nazwy pliku
h1=get(gca,'title');
handle = gcf;
tmp = handle.Children;
SGtitle = '';
try
    for i = 1:length(tmp)
        tmp = handle.Children(i);
        if(strcmp(get(tmp, 'type'), 'subplottext') == 1 )
            SGtitle = tmp.String;
        end
        if(strcmp(get(tmp, 'Type'), 'tiledlayout') == 1 )
            SGtitle = tmp.Title.String;
        end
    end
catch
    disp('Error getting sgtitle')
end

tsAdded = false;
if( isempty(SGtitle) )
    title=get(h1,'string');
    if( isempty(title) )
        if(nargin<=1)
            fTitle = [ datestr(now ,'yyyy-mm-dd_HH.MM.ss') '_'];
            tsAdded = true;
        else
        end
    else
        fTitle = strcat(title, "_");
    end
else
    %         tmp = tmp.String;
    fTitle = strcat(string(SGtitle), "_");
end
nrName = get( get(gcf,'Number'), 'Name' );
if(valTimestamp)
    if(~tsAdded) fTitle = [ datestr(now ,'yyyy-mm-dd_HH.MM.ss') '_']; end
end
% title([{'Dziedzina czasu'},{'Cha-ka skokowa'}]);
% xlabel('O rzeczywista'); ylabel('O urojona');
% legend(str{:});

[calling_mfile, index] = dbstack(0);
mcName = [calling_mfile(length(calling_mfile)).name '_'];
[path, filename, Fext] = fileparts( mfilename('.')); [~, folderName] = fileparts(pwd()); 
filename = strcat(mcName, fTitle, nrName, num2str(get(gcf,'Number')));
filename = regexprep(filename, {'[%()*:\\" / ]+', '_+$'}, {'_', ''});
folderName = regexprep(folderName, {'[%()*:\\" / ]+', '_+$'}, {'_', ''});
if(size(filename,1) > 1) filename = filename(1);end;
if(strlength(valFileName) == 0)
    folderName = strcat(katalog, folderName, "_");%if(nargin == 1) folderName = katalog; nrName=''; end;                     % nazwa TEGO *.m-pliku
    folderFilename = strcat(folderName,filename);
else
    folderFilename = strcat(katalog,string(valFileName));
end
filenameExt = strcat(folderFilename, ext); % Default filename


%%%%%%% Fast save %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if numel(varargin) == 0
    figP(folderFilename, ext, TNR, valArgCopy, valOpenFolder, valOpenFile, valExportPdf, valOverwrite, valSkipSaveAs)
    return
end

%%%%%%% Save copy %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h=gcf; % for saveas()
% set(h,'PaperOrientation','Landscape');
%set(h,'Units','centimeters');
%set(h,'OuterPosition',[1, 1, 29 21]);
% set(h,'Position',2*get(h,'Position'));

% fn = nextname(filename, int2str(nrKol), "") to do
defaultExtension = '.fig';
if(valSaveCopyFig)
    if( strcmpi(ext, defaultExtension) == 0 ) % case insensitive
        if(defaultExtension(1) ~= '.') defaultExtension = strcat('.', defaultExtension); end
        fileNameExt = strcat(folderFilename, defaultExtension);
        if(valOverwrite)
            if(exist(fileNameExt, 'file'))
                delete(fileNameExt);
            end
        end
        saveas(h, fileNameExt);
        
        fprintf(1, '\t* Zapisano kopię: "%s%s"\n', folderFilename, defaultExtension);
    end
end

%             zapiszFig(nrPliku, nrKol, 'fig');
%             zapiszFig(nrPliku, nrKol, 'pdf');
%             zapiszFig(nrPliku, nrKol, 'emf'); %!
%             zapiszFig(nrPliku, nrKol, 'eps');
%             zapiszFig(nrPliku, nrKol, 'tif');
%             zapiszFig(nrPliku, nrKol, 'pcx');
%             zapiszFig(nrPliku, nrKol, 'jpg');
%             zapiszFig(nrPliku, nrKol, 'pbm');
%             zapiszFig(nrPliku, nrKol, 'pgm');
%             zapiszFig(nrPliku, nrKol, 'png');
%             zapiszFig(nrPliku, nrKol, 'ppm');


%%%%%%% Font Times New Roman %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ( TNR )
    font = "Times";
    if(strlength(valFont)>0)
        font = "Verdana"; 
        font = valFont; 
    end
    childs = get( gcf, 'Children' );
    for(childAxInx = 1:length(childs) )
        ca = childs(childAxInx);
    
        FontSizeTitle = 12;
        FontSizeLabels = 10;
        FontSizeTicks = 8;
        FontSizeLegend = 8;
        sgTitleFontSize = 15;

        type = get( ca, 'type' );

        if( 1 == strcmp( type, 'subplottext' ))
            set(ca,...
                'FontName',font,...
                'FontUnits','points',...
                'FontSize',sgTitleFontSize);% 'FontWeight','normal',...
            continue
        end
        if( 1 == strcmp( type, 'colorbar' ))
            set(ca,...
                'FontName',font,...
                'FontWeight','normal',...
                'FontSize',FontSizeTicks);
            type = get( ca, 'type' );
            continue
        end

        if( 1 == strcmp( type, 'tiledlayout' ))
                caX = ca;
        % for tiled layout path
        for(cai = 1:numel(caX.Children) )
            ca = caX.Children(cai);
            %             continue
            %         set(ca,...
            %             'FontName',font,...
            %             'FontUnits','points',...
            %             'FontWeight','normal',...
            %             'FontSize',FontSizeTicks);
            type = get( ca, 'type' );
            
            if(isfield(ca,"XLabel") && get(ca.XLabel,'Interpreter') ~= "latex")
                set(get(ca,'XLabel'), ...
                    'FontWeight','normal',...
                    'FontSize',FontSizeLabels,...
                    'Interpreter',valInterpreter,...
                    'FontName',font);
            end
            if(isfield(ca,"YLabel") && get(ca.XLabel,'Interpreter') ~= "latex")
               set(isfield(ca,"YLabel") && get(ca,'YLabel'),...
                'FontWeight','normal',...
                'FontSize',FontSizeLabels,...
                'Interpreter',valInterpreter,...
                'FontName',font);
            end
            if(isfield(ca,"Title") && get(ca.XLabel,'Interpreter') ~= "latex")
                set(get(ca,'Title'),...
                'FontWeight','normal',...
                'FontSize',FontSizeTitle,...
                'Interpreter',valInterpreter,...
                'FontName',font);
            end
            if(isfield(ca,"Subtitle") && get(ca.XLabel,'Interpreter') ~= "latex")
                set(get(ca,'Subtitle'),...
                'FontSize',FontSizeLegend,...
                'Interpreter',valInterpreter,...
                'FontName',font);
            end
            if(isfield(ca, "Legend"))
                set(get(ca,'Legend'),...
                    'FontUnits','points',...
                    'FontSize',FontSizeLegend,...
                    'Interpreter',valInterpreter,...
                    'Location','NorthEast',...
                    'FontName',font);
            end
            continue
        end

        set(ca,...
            'FontName',font,...
            'FontUnits','points',...
            'FontWeight','normal',...
            'FontSize',FontSizeTicks);
        type = get( ca, 'type' );

        if( 1 == strcmp( type, 'legend' ))
            continue;
        end

        if(get(ca.XLabel,'Interpreter') ~= "latex" )
            set(get(ca,'Xlabel'), ...
                'FontUnits','points',...                
                'FontSize',FontSizeLabels,...
                'Interpreter',valInterpreter,...
                'FontName',font);%'FontWeight','normal',...
        end
        set(get(ca,'Ylabel'),...
            'FontUnits','points',...
            'FontWeight','normal',...
            'FontSize',FontSizeLabels,...
            'Interpreter',valInterpreter,...
            'FontName',font);
        set(get(ca,'Title'),...
            'FontUnits','points',...
            'FontWeight','normal',...
            'FontSize',FontSizeTitle,...
            'Interpreter',valInterpreter,...
            'FontName',font);
        set(get(ca,'Legend'),...
            'FontUnits','points',...
            'FontSize',FontSizeLegend,...
            'Interpreter',valInterpreter,... % 'Location','NorthEast',...
            'FontName',font);
        end
    end
end

%%%%%%% Axis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (~ismember(argAxis, p.UsingDefaults))
    childs = get( gcf, 'Children' );
    for(childAxInx = 1:length(childs) )
        ca = childs(childAxInx);
        type = get( ca, 'type' );
        if type ~= "axes"
            continue
        end
        xlim(ca, valueAxis)
        ylim(ca, valueAxis)
        %         set(ca, "axes", valueAxis); % not work because field is readOnly
    end
end

%%%%%%% Style %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(valPlotContur)
    childs = get( gcf, 'Children' );         
    for(childAxInx = 1:length(childs) ) % for old type plots
        ca = childs(childAxInx);
        type = get( ca, 'type' );        
        if( 1 == strcmp( type, 'axes' ))
            set(ca,'Box','on');
        end
    end
end

if (~ismember(argStyleLudwin, p.UsingDefaults))
    if (valStyleLudwin)
allHyl = []; % ylabel pos matrix
set(groot,'defaultAxesTickLabelInterpreter','latex'); 
        % arrayfun(@(x) grid(x,'on'), findobj(gcf,'Type','axes'))
        % arrayfun(@(x) grid(x,'minor'), findobj(gcf,'Type','axes'))

        %         grid minor

        childs = get( gcf, 'Children' );

        skipYlabelPos = 1;
        if(isfield(childs,"GridSize"))
            if(childs.GridSize(2)>1)                
                % TODO
            else skipYlabelPos = 0; %no problemo
            end
        else fprintf(1,"Old styled figure, ylabel positioning skipped, use 'figConvert'\n");
        end

        for(childAxInx = 1:length(childs) )

            ca = childs(childAxInx);

            FontSizeTitle = 12;
            FontSizeLabels = 10;
            FontSizeTicks = 8;
            FontSizeLegend = 8;
            sgTitleFontSize = 15;
            font = valFont;

            type = get( ca, 'type' );

            if( 1 == strcmp( type, 'axes' ))

                set(ca,'FontSize',11);
                h=get(ca,'xlabel');
                %         set(h, 'FontSize', 11)
                set(h,'Interpreter','latex');
                h=get(ca,'ylabel');
                %         set(h, 'FontSize', 11)
                set(h,'Interpreter','latex');
                h=get(ca,'zlabel');
                %         set(h, 'FontSize', 11)
                set(h,'Interpreter','latex');

                %todo Z label
                continue
            end
            %         set(ca,...
            %             'FontName',font,...
            %             'FontUnits','points',...
            %             'FontWeight','normal',...
            %             'FontSize',FontSizeTicks);
            %         type = get( ca, 'type' );


            % set(findobj(gcf,'type','axes'),'FontName','Calibri','FontSize',11, ...
            % 'FontWeight','Bold', 'LineWidth', 1,'layer','top');grid on

            if( 1 == strcmp( type, 'legend' ))
                continue;
            end

            if( 1 == strcmp( type, 'tiledlayout' ))
                gcaP = gca().Parent;
                ch = gcaP.Children;
                set(ca.Title,...
                    'FontName',font,...
                    'FontWeight','normal',...
                    'FontSize',sgTitleFontSize);

%                 nums = tilenum(flipud(gca))
                for( i = 1:numel(ch))
                    a = ch(i);
                    atype = get( a, 'type' );
                    if( 1 == strcmp( atype, 'legend' ))
                        h = a;
                        set(h,'Interpreter','latex');
                        set(h,'FontName',font);
                        set(h,'FontSize',FontSizeLegend);
                        continue
                    end
                    set(a,'FontSize', FontSizeLabels);
                    h=get(a,'XLabel');
                    set(h,'Interpreter','latex');
                    set(h,'FontName',font);
                    set(h,'FontSize',FontSizeLabels);
                    
                    h=get(a,'YLabel');
                    allHyl = [allHyl; h];
                    set(h,'Interpreter','latex');
                    set(h,'FontName',font);
                    set(h,'FontSize',FontSizeLabels);

                    h=get(a,'Title');
                    set(h,'Interpreter','latex');
                    set(h,'FontSize', FontSizeTitle);


% FontSizeTicks = 8;TODO
          
%                     h=get(ca,'ZLabel'); isfield
%                     set(h,'Interpreter','latex');
%                     set(h,'FontName','Times');

%                     set(a,'YLabel',10);
%                     set(a,'Title',FontSizeTitle);
%                     set(a,'Subtitle',20);
%                      h=get(ca,'xlabel');
                end
                
%                 title("fontname","times")
%                 title( get(ca,'Title').String, 'interpreter','latex')
                set(ca.Title,'Interpreter','latex');
%                 set(gca.Title,'xFontSize',20);
%                  set(gca,'FontSize',20);
            end


            %
            %         set(get(ca,'Xlabel'), ...
            %             'FontUnits','points',...
            %             'FontWeight','normal',...
            %             'FontSize',FontSizeLabels,...
            %             'Interpreter',valInterpreter,...
            %             'FontName',font);
            %         set(get(ca,'Ylabel'),...
            %             'FontUnits','points',...
            %             'FontWeight','normal',...
            %             'FontSize',FontSizeLabels,...
            %             'Interpreter',valInterpreter,...
            %             'FontName',font);
            %         set(get(ca,'Title'),...
            %             'FontUnits','points',...
            %             'FontWeight','normal',...
            %             'FontSize',FontSizeTitle,...
            %             'Interpreter',valInterpreter,...
            %             'FontName',font);
            %         set(get(ca,'Legend'),...
            %             'FontUnits','points',...
            %             'FontSize',FontSizeLegend,...
            %             'Interpreter',valInterpreter,...
            %             'Location','NorthEast',...
            %             'FontName',font);
        end
        %
        %         childs = get( gcf, 'Children' );
        %         for(childAxInx = 1:length(childs) )
        %             ca = childs(childAxInx);
        %             type = get( ca, 'type' );
        %             if type ~= "axes"
        %                 continue
        %             end
        %             xlim(ca, valueAxis)
        %             ylim(ca, valueAxis)
        %     %         set(ca, "axes", valueAxis); % not work because field is readOnly
        %         end
 
if(~skipYlabelPos)
        values = [];
        for(i = 1:numel(allHyl))
            values = [values; allHyl(i).Position(1)];
        end
        % hist(values)
        m = min(values)
        for(i = 1:numel(allHyl))
% allHyl(i).Position(1)
            allHyl(i).Position(1) = m;
        end
end

        x0=1920; y0=-160;     
        width=1280; height=1024;
        set(gcf,'position',[x0,y0,width,height])
    end
end

%-----------

if (~ismember(argStylePiotr, p.UsingDefaults))
    if (valStylePiotr)

        defaultInterpreter = "latex";
        if (~ismember(argInterpreter, p.UsingDefaults))
            defaultInterpreter = valInterpreter;
        end

        childs = get( gcf, 'Children' );
         
        for(childAxInx = 1:length(childs) ) % for old type plots

            ca = childs(childAxInx);

            FontSizeTitle = 12;
            FontSizeLabels = 10;
            FontSizeTicks = 8;
            FontSizeLegend = 8;
            sgTitleFontSize = 15;
            font = valFont;

            type = get( ca, 'type' );
            
            if( 1 == strcmp( type, 'axes' ))

                set(ca,'FontSize',11); % fig in fig case
                set(ca,'Box','on');
                h=get(ca,'xlabel');
                h.String = literateLATEX(h.String); % make polish letters for latex
                %         set(h, 'FontSize', 11)
                set(h,'Interpreter',defaultInterpreter);
                h=get(ca,'xaxis');               
                h.TickLabelInterpreter = defaultInterpreter;
                
                
                h=get(ca,'ylabel'); 
                h.String = literateLATEX(h.String); 
                %         set(h, 'FontSize', 11)
                set(h,'Interpreter',defaultInterpreter);
                h=get(ca,'yaxis');               
                h.TickLabelInterpreter = defaultInterpreter;
                
                h=get(ca,'zlabel');
                h.String = literateLATEX(h.String); 
                %         set(h, 'FontSize', 11)
                set(h,'Interpreter',defaultInterpreter);
                h=get(ca,'zaxis');               
                h.TickLabelInterpreter = defaultInterpreter;
                
                h=get(ca,'title');
                h.String = literateLATEX(h.String); 
                set(h,'Interpreter',defaultInterpreter);
                h=get(ca,'subtitle');
                h.String = literateLATEX(h.String); 
                set(h,'Interpreter',defaultInterpreter);

                continue
            end

            if( 1 == strcmp( type, 'subplottext' ))
                h = ca;
                h.String = literateLATEX(h.String); 
                set(h,'Interpreter',defaultInterpreter);
                continue
            end
            %         set(ca,...
            %             'FontName',font,...
            %             'FontUnits','points',...
            %             'FontWeight','normal',...
            %             'FontSize',FontSizeTicks);
            %         type = get( ca, 'type' );


            % set(findobj(gcf,'type','axes'),'FontName','Calibri','FontSize',11, ...
            % 'FontWeight','Bold', 'LineWidth', 1,'layer','top');grid on

            if( 1 == strcmp( type, 'legend' ))
                h = ca;
                h.String = literateLATEX(h.String); 
                set(h,'Interpreter',defaultInterpreter);
                continue;
            end

            if( 1 == strcmp( type, 'tiledlayout' ))
                gcaP = gca().Parent;
                ch = gcaP.Children;
                set(ca.Title,...
                    'FontName',font,...
                    'FontWeight','normal',...
                    'FontSize',sgTitleFontSize);

%                 nums = tilenum(flipud(gca))
                for( i = 1:numel(ch))
                    a = ch(i);
                    atype = get( a, 'type' );
                    if( 1 == strcmp( atype, 'legend' ))
                        h = a;
                        h.String = literateLATEX(h.String); 
                        set(h,'Interpreter',defaultInterpreter);
                        set(h,'FontName',font);
                        set(h,'FontSize',FontSizeLegend);
                        continue
                    end
                    % set(a,'FontSize', FontSizeLabels);
                    h=get(a,'XLabel');
                    h.String = literateLATEX(h.String); 
                    set(h,'Interpreter',defaultInterpreter);
                    set(h,'FontName',font);
                    set(h,'FontSize',FontSizeLabels);
                    
                    h=get(a,'YLabel');
                    h.String = literateLATEX(h.String); 
                    set(h,'Interpreter',defaultInterpreter);
                    set(h,'FontName',font);
                    set(h,'FontSize',FontSizeLabels);

                    h=get(a,'Title');
                    h.String = literateLATEX(h.String); 
                    set(h,'Interpreter',defaultInterpreter);
                    % set(h,'FontName',font);
                    set(h,'FontSize', FontSizeTitle);


% FontSizeTicks = 8;TODO
          
%                     h=get(ca,'ZLabel'); isfield
%                     set(h,'Interpreter','latex');
%                     set(h,'FontName','Times');

%                     set(a,'YLabel',10);
%                     set(a,'Title',FontSizeTitle);
%                     set(a,'Subtitle',20);
%                      h=get(ca,'xlabel');
                end
                
%                 title("fontname","times")
%                 title( get(ca,'Title').String, 'interpreter','latex')
                set(ca.Title,'Interpreter',defaultInterpreter); %?? 
%                 set(gca.Title,'xFontSize',20);
%                  set(gca,'FontSize',20);
            end


            %
            %         set(get(ca,'Xlabel'), ...
            %             'FontUnits','points',...
            %             'FontWeight','normal',...
            %             'FontSize',FontSizeLabels,...
            %             'Interpreter',valInterpreter,...
            %             'FontName',font);
            %         set(get(ca,'Ylabel'),...
            %             'FontUnits','points',...
            %             'FontWeight','normal',...
            %             'FontSize',FontSizeLabels,...
            %             'Interpreter',valInterpreter,...
            %             'FontName',font);
            %         set(get(ca,'Title'),...
            %             'FontUnits','points',...
            %             'FontWeight','normal',...
            %             'FontSize',FontSizeTitle,...
            %             'Interpreter',valInterpreter,...
            %             'FontName',font);
            %         set(get(ca,'Legend'),...
            %             'FontUnits','points',...
            %             'FontSize',FontSizeLegend,...
            %             'Interpreter',valInterpreter,...
            %             'Location','NorthEast',...
            %             'FontName',font);
        end
        %
        %         childs = get( gcf, 'Children' );
        %         for(childAxInx = 1:length(childs) )
        %             ca = childs(childAxInx);
        %             type = get( ca, 'type' );
        %             if type ~= "axes"
        %                 continue
        %             end
        %             xlim(ca, valueAxis)
        %             ylim(ca, valueAxis)
        %     %         set(ca, "axes", valueAxis); % not work because field is readOnly
        %         end
    end
end

if (~ismember(argStyleGrid, p.UsingDefaults))
    if (valStyleGrid)
        arrayfun(@(x) grid(x,'on'), findobj(gcf,'Type','axes'))
        arrayfun(@(x) grid(x,'minor'), findobj(gcf,'Type','axes'))
    end
end


%----------- TiledLayout (spacing, padding)
if (~ismember(argTilePadding, p.UsingDefaults))

    childs = get( gcf, 'Children' );  % old type, simple styled figure
    for(childAxInx = 1:length(childs) )
        ca = childs(childAxInx);
        type = get( ca, 'type' );
        if( 1 == strcmpi( type, 'tiledlayout' ))
            gcaP = gca().Parent;
            gcaP.Padding = valTilePadding;
        end
    end
end
% ---
if (~ismember(argTileSpacing, p.UsingDefaults))

    childs = get( gcf, 'Children' );  
    for(childAxInx = 1:length(childs) )
        ca = childs(childAxInx);
        type = get( ca, 'type' );
        if( 1 == strcmpi( type, 'tiledlayout' ))
            gcaP = gca().Parent;
            gcaP.TileSpacing = valTileSpacing;
        end
    end
end

%%%%%%% Size %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% valFigUnits pixels, points, cale

% TODO
% if(valDimX ~= 1)
%     PosFig = get(gcf,'Position');
%     PosFig(3) = PosFig(3)*valScaleX;
%     set(gcf, 'Position', PosFig);
% end
% 
% if(valDimY ~= 1)
%     PosFig = get(gcf,'Position');
%     PosFig(4) = PosFig(4)*valScaleY;
%     set(gcf, 'Position', PosFig);
% end

%%%%%%% Scaling figure - position %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(valScale ~= 1)
    PosFig = get(gcf,'Position');
    PosFig(3:4) = PosFig(3:4)*valScale;
    set(gcf, 'Position',PosFig);
end

if(valScaleX ~= 1)
    PosFig = get(gcf,'Position');
    PosFig(3) = PosFig(3)*valScaleX;
    set(gcf, 'Position', PosFig);
end

if(valScaleY ~= 1)
    PosFig = get(gcf,'Position');
    PosFig(4) = PosFig(4)*valScaleY;
    set(gcf, 'Position', PosFig);
end

if (~ismember(argMaxF, p.UsingDefaults))
    %     if(valMaxF)
    %      a = get(gcf,'Position');
    %      gcf.WindowState = 'maximized';
    set(gcf, 'Position', get(0, 'Screensize'));
    %      jFrame = get(handle(gcf),'JavaFrame');
    %      jFrame.setMaximized(true);
    %     end
end

if (~ismember(argGoldenRatio, p.UsingDefaults))             
        if(valGoldenRatio)
            defaultSize = 1000*valGoldenRatio; %px absolut scaling standard 
            if(valGoldenRatio==1) defaultSize = gcf().Position(3); end
            set(gcf, 'Units', 'pixels');
            if(valGoldenRatio < 0)
                % or if in browser?
                defaultSize = 3.25*abs(valGoldenRatio); %inches [colummn size in trnse]
                set(gcf, 'Units', 'inches');
            end
            GOLDEN_RATIO = 1.618033988749894848204586834365638;
            set(gcf, 'Position', [1 1 defaultSize*GOLDEN_RATIO defaultSize]);
        end
end

%%%%%%% ylabel rePositon %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (~ismember(argRePositonYlabel, p.UsingDefaults))
    if(valRePositonYlabel)
        % for gcf, all axis get ylabel pos, get max and set to all ax
    end
end

%%%%%%% PNG HQ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (~ismember(argHighQualityPNG, p.UsingDefaults))
    %     figP(folderFilename, ext )% copyOnly
    %     quality
    copyGraphObj2Clipboard(valArgCopy, filename, gcf);
    
    if(ext(1) ~= '.') ext = strcat('.', ext); end
    folderFilename = strcat(folderFilename, "HQ");
    filenameExtHQ = strcat(folderFilename, ext); % Default filename
    % fid = fopen(filenameExtHQ, 'w')
    % pause
    % fclose(fid);

    
    print( filenameExtHQ, '-dpng', '-r300'); % Zapisz jako tenMPlik_nrOstatniejFigury.png
    fid = fopen(filenameExtHQ); fileSizeMB = 0;
    if(fid)
        fseek(fid, 0, 'eof');
        filesize = ftell(fid);
        fclose(fid);    
        fileSizeMB = filesize/2^10/2^10; 
    end
    fprintf("\t* %s %.2g MB\n", strcat("Zapisano w wysokiej jakości przed procesem skalowania: ", filenameExtHQ), string(fileSizeMB));
end

%%%%%%% Figure Scaling %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%     h=gcf;
%END
if( ~exist('FigType', 'var') ) FigType = 6; end;
LineWidth = 0.75;  % było 0.5
GridAlpha = 0.75;  % procentowo
%LineStyle=['-'];
MarkerSize = 3;
FontSizeTitle = 9;
FontSizeLabels = 9;
FontSizeTicks = 8;
FontSizeLegend = 8;%FontSizeLegend = 16;
Resolution = 1200;           % 150, 300, 600, 1200

FigX0 = 2; FigY0 = 2;        % (left,down) corner of the window
FigWidthShort = 5.75;        % window X size (in centimeters) - all = fig + text
FigWidthLong = 2*5.75;       % window X size (in centimeters) - all = fig + text
FigHeight = 4.25;            % window Y size 4.25
PosFigLong  = [.18/2 .2 .89  .690];   % Dell  % PosFigLong  = [.095 .20 .87  .68];   % Asus
%PosFigShort = [.175  .2 .775 .690];   % Dell  % [.175  .2 .775 .725];   % Dell PosFigShort = [.195 .205 .775 .68];  % Asus
PosFigShort = [.175  .195 .775 .690];   % Dell  % [.175  .2 .775 .725];   % Dell PosFigShort = [.195 .205 .775 .68];  % Asus
%PosFigShort = [.15   .2 .775 .690];   % Dell  % [.175  .2 .775 .725];   % Dell PosFigShort = [.195 .205 .775 .68];  % Asus
font = valFont; % 'Times';

% strcmpi
if( FigType==1 ) % 1 long figure
    FigWidth = FigWidthLong; PosFig = PosFigLong;
end
if( FigType==2 ) % 2 short figures, side by side
    FigWidth = FigWidthShort; PosFig = PosFigShort;
end

if( FigType==3 ) % 3 as is on monitor
    set(gcf,'Units','centimeters')
    PosFig = get(gcf,'Position'); FigWidth = PosFig(3);
    %        set(gcf,'Units','normalized'); PosFig = get(gcf,'Position');;
    %        FigWidth = FigWidthLong; PosFig = PosFigLong*2;
    PosFig = get(gca,'Position');
end

if (valExportPdf)
    %% ---------------- Check matlab version ----------------------------------
    if verLessThan('matlab', '9.8')
        error(' - figPW.m: Older versions than Matlab 2020b are not supported for exportgraphics')
    end

    fileNamePDF = strcat(folderFilename, ".pdf");
    if(valOverwrite)
        if exist(fileNamePDF,'file')
            delete(char(fileNamePDF));
        end
    end
    %     fileNameEPS = strcat(folderFilename, ".eps");
    %     exportgraphics(gcf, fileNameEPS, 'ContentType', 'vector');

    % sum = GetSize(gcf().CurrentObject);
    % for(i = 1:length(gcf().Children))
    % 
    %     a = GetSize(gcf().Children(i));
    %     sum = sum + a;
    % end
    % fprintf(1, 'Fig nr %d = %d bytes\n', gcf().Number, sum); 

    % if(sum > valVectorReplacedByTIFFigBytes)
    %     n = strcat(folderFilename, ".tif");
    %     exportgraphics(gcf, n, 'BackgroundColor','white','Resolution',300)    
    %     fprintf(1,'\t* Zapisano zamiast PDF obraz TIFF: "%s"\n', n);
    %     return
    % end
    
    lastwarn('') % catch
    exportgraphics(gcf, fileNamePDF, 'BackgroundColor','none', 'ContentType', 'vector') % cd(prefdir); open('matlab.prf'); % add line: JavaMemHeapMax=I190000
    %-- METHOD #1 --                    
    % s = dir('myfile.dat');         
    % filesize = s.bytes             
    %-- METHOD #2 --
    fid = fopen(fileNamePDF);
    fseek(fid, 0, 'eof');
    filesize = ftell(fid);
    fclose(fid);    
    fileSizeMB = filesize/2^10/2^10; 
    
    fprintf(1,'\t* Zapisano wektorowy PDF: "%s" %.1f MB\n', fileNamePDF, fileSizeMB);
    [msgstr, msgid] = lastwarn;
    switch msgid %identifier
        case 'MATLAB:print:ContentTypeImageSuggested'
            if(filesize > valVectorReplacedByTIFFigBytes)
                n = strcat(folderFilename, ".tif");
                exportgraphics(gcf, n, 'BackgroundColor','white','Resolution',300)    
                fprintf(1,'\t* Zapisano optymalny TIFF: "%s"\n', n);
            end
        otherwise             
    end

    % 
    % exportgraphics(gcf, fileNamePDF,...
    %     'BackgroundColor','none', ...
    %     'ContentType', 'vector')
    % fprintf(1,'\t* Zapisano wektorowy PDF: "%s"\n', fileNamePDF);
    
%     fid = fopen('myfile.dat');
% fseek(fid, 0, 'eof');
% filesize = ftell(fid)
% fclose(fid);
% GetSize(gcf)

    %     mypdf = eps2pdf(fileNameEPS);
end

if (~ismember(argNoMargin, p.UsingDefaults))
    %     prev_contents = clipboard('paste');
    %     copygraphics(gcf);
    %     fig_contents = clipboard('paste');
    %     exportgraphics(gcf,"myplot.pdf","Resolution",300)
    %     clipboard('copy', prev_contents);

    set(gcf,'Units','centimeters')
    %        PosFig = get(gcf,'Position'); FigWidth = PosFig(3);       PosFig = get(gca,'Position');
    a=get(h,'children');
    if (length(a) > 1)
        disp("NoMargin is disabled for multisubplots.")
    end
    for i = 1:length(a)
        if (length(a) > 1)
            continue;
        end
        ax = a(i);
        if ax.Type == "subplottext" continue; end;
        if ax.Type == "legend" continue; end;
        outerpos = ax.OuterPosition;
        ti = ax.TightInset;
        left = outerpos(1) + ti(1);
        bottom = outerpos(2) + ti(2);
        ax_width = outerpos(3) - ti(1) - ti(3);
        ax_height = outerpos(4) - ti(2) - ti(4);
        ax.Position = [left bottom ax_width ax_height];
        %                 axis tight; % if crop too much
        %                 axis tickaligned
        %                 ax = a(i);
        %                 pos = get(ax, 'Position');
        %                 pos(1) = 0.055;
        %                 pos(3) = 0.9;
        %                 set(ax, 'Position', pos);
    end
    %no margin
    %  ax = gca;
    % outerpos = ax.OuterPosition;
    % ti = ax.TightInset;
    % left = outerpos(1) + ti(1);
    % bottom = outerpos(2) + ti(2);
    % ax_width = outerpos(3) - ti(1) - ti(3);
    % ax_height = outerpos(4) - ti(2) - ti(4);
    % ax.Position = [left bottom ax_width ax_height];

    %todo margin values
    %       ?latex == tex?
    %         xlabel('Time (s)','Interpreter','latex','FontSize',14)
    %         ylabel('Curvature (cm)','Interpreter','latex','FontSize',14)
    %         legend('$\bar{X}$','$\bar{X} + \sigma$','$\bar{X} - \sigma$','Interpreter','latex','FontSize',14)
    %     saveas(h, strcat(folderFilename, ext));
    %     fprintf(1, ['\t* Zapisano rysunek "%s%s"\n'], folderFilename, ext);
    %                 figP(folderFilename,ext,TNR,valArgCopy);
    %     return
end
if( FigType==5 ) % 3 as is on monitor
    %        set(gcf,'Units','centimeters')
    PosFig = get(gcf,'Position'); FigWidth = PosFig(3);
    %        set(gcf,'Units','normalized'); PosFig = get(gcf,'Position');;
    %        FigWidth = FigWidthLong; PosFig = PosFigLong*2;
    PosFig = get(gca,'Position');
    H = figure(gcf);
    a = get(H,'Position');
    H.WindowState = 'maximized';
    figP(folderFilename,ext, TNR, valArgCopy, valOpenFolder, valOpenFile, valExportPdf, valOverwrite, valSkipSaveAs);
    set(H,'Position',a);
    return
end
if( FigType==6 )

    copyGraphObj2Clipboard(valArgCopy, filename, gcf);

    figP(folderFilename, ext, TNR, valArgCopy, valOpenFolder, valOpenFile, valExportPdf, valOverwrite, valSkipSaveAs)
    return;
end
%     figure('Units','centimeters',...
%'Position',[FigX0 FigY0 FigWidth FigHeight],...
%'PaperPositionMode','auto');

set(0,'defaultLineLineWidth', LineWidth);         % set the default line width to lw
set(0,'defaultLineMarkerSize',MarkerSize);        % set the default line marker size to msz
%set(0,'defaultLineStyle',LineStyle);             % set default line style
set(0,'DefaultFigurePaperPositionMode','auto');   % automatyczna wielkoć rysunku
%set(0,'DefaultAxesColorOrder',[0,0,0]);           % czarna linia

%set(h,'markers',MarkerSize);

%set(0,...
%'LineStyle',LineStyle,...
%'LineWidth',LineWidth,...
%'MarkerSize',MarkerSize);

set(gcf,'DefaultLineLineWidth',LineWidth);             % gruboć linii wykresów
%set(gcf,'DefaultMarkerSize',MarkerSize);                % wielkoć markera
set(gcf,'Units','centimeters');                        % jednostka wymiarowania okna
set(gcf,'Position', [FigX0 FigY0 FigWidth FigHeight]); % wymiary okna: (x,y,dx,dy), (x,y)- lewy dolny
set(gcf,'PaperPositionMode','auto');
%     PosFig = get(gcf,'Position');
%set(gca,'Units','centimeters'); %JB
set(gca,...                   % axis features
    'Units','normalized',...
    'LineWidth',LineWidth,...
    'GridLineStyle',':', ...
    'GridAlpha',GridAlpha, ...
    'Position',PosFig,...   % (left,bottom) (width,hight) - relative, inside the window
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',FontSizeTicks,...
    'FontName',font);
set(get(gca,'Xlabel'),...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',FontSizeLabels,...
    'Interpreter','tex',...
    'FontName',font);
set(get(gca,'Ylabel'),...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',FontSizeLabels,...
    'Interpreter','tex',...
    'FontName',font);
set(get(gca,'Title'),...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',FontSizeTitle,...
    'Interpreter','tex',...
    'FontName',font);
set(get(gca,'Legend'),...
    'FontUnits','points',...
    'FontSize',FontSizeLegend,...
    'Interpreter','tex',...
    'Location','NorthEast',...
    'FontName',font);
if(variantHorizontalLegend)
    set(get(gca,'Legend'),...
        'Orientation','horizontal',...
        'Location','SouthEast');
end
% Legenda
child = get( gcf, 'Children' );
for i = 1:length( child )
    tag = get( child(i), 'Tag' );
    if( 1 == strcmp( tag, 'legend' ) )
        set( child(i),'FontSize',FontSizeLegend,'LineWidth',LineWidth);
        break;
    end
end
% MyFigFile = fn
%     print( strcat(filename,'.png'),'-dpng', '-r600');
% print( strcat(MyFigFile,'.eps'),'-depsc', '-r600');
%  end

%%%%%%% Figure final save %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (valArgCopy)
    copyGraphObj2Clipboard(valArgCopy, filename, gcf);
end

figP(folderFilename, ext, TNR, valArgCopy, valOpenFolder, valOpenFile, valExportPdf, valOverwrite, valSkipSaveAs)

end

% ==========================

function [str] = literateLATEX(str)% ylabel('\''Srednia warto\''s\''c parametru $f_{max}$','Interpreter','latex')
    % return;
% I don't know how to do polish letters with lower 'ogonek' in latex, so...
    % str = strrep(str,'ą','{a}');
    % str = strrep(str,'Ą',"{A}");
    % str = strrep(str,'ę','{e}');
    % str = strrep(str,'Ę','{E}');
% PSW use diffrent 'ogonek' ;)
    str = strrep(str,'ą','\c{a}');
    str = strrep(str,'Ą','\c{A}');
    str = strrep(str,'ę','\c{e}');
    str = strrep(str,'Ę','\c{E}');
    
    str = strrep(str,'ó','{\''o}');
    str = strrep(str,'Ó','{\''O}');
    str = strrep(str,'ś','{\''s}');
    str = strrep(str,'Ś','{\''S}');
    str = strrep(str,'ł','{\l}');
    str = strrep(str,'Ł','{\L}');
    str = strrep(str,'ż','{\.z}');
    str = strrep(str,'Ż','{\.Z}');
    str = strrep(str,'ź','{\''z}');
    str = strrep(str,'Ź','{\''Z}');
    str = strrep(str,'ć','{\''c}');
    str = strrep(str,'Ć','{\''C}');
    str = strrep(str,'ń','{\''n}');
    str = strrep(str,'Ń','{\''N}');

    str = makeExprBtwDollars(str,"_");
    str = makeExprBtwDollars(str,"^");
end

function [str] = makeExprBtwDollars(str,sign)

    pat = letterBoundary + lettersPattern;
    expressi = "\s.[a-z()]*";
    if(sign=="^")   expression = strcat(expressi,"\",sign);
    else            expression = strcat(expressi,sign); end
    begL = regexpPattern(expression);
    endL = lookBehindBoundary(sign) + optionalPattern(lettersPattern)+ optionalPattern(digitsPattern);
    e = strfind(str,endL);
    b = strfind(str,begL);
    a = char(str);
    % a(b(2):e)

    if(strlength(a(:)')==0) return; end

    s = size(a);

    if(length(s)==3) % dimensions
        for(i = 1:s(3)) % eg. for legend text
            if (~isempty(b{i}) && ~isempty(e{i}))
                str = insertAfter(str(i), b, "$");
                str = insertAfter(str(i), e+1, "$");
            end
        end
    elseif(s(1)==1)
        if (~isempty(b) && ~isempty(e))            
            str = insertAfter(str, b, "$");
            str = insertAfter(str, e+1, "$");
        end
    else
        for(i = 1:s(1)) % eg. for legend text
            if (~isempty(b{i}) && ~isempty(e{i}))
                str = insertAfter(str, b, "$");
                str = insertAfter(str, e+1, "$");
            end
        end
    end
end

% set(gcf,'Resize','off')

function [totSize] = GetSize(this) 
   props = properties(this); 
   totSize = 0; 
   
   for ii=1:length(props) 
      currentProperty = getfield(this, char(props(ii))); 
      s = whos('currentProperty'); 
      totSize = totSize + s.bytes; 
   end
end





function [name,val] = nextname(bnm,sfx,ext,otp) %#ok<*ISMAT>
% Return the next unused filename, incrementing a numbered suffix if required.
%
% (c) 2017-2021 Stephen Cobeldick
%
%% Examples %%
%
%%% Current directory contains files 'A1.m', 'A2.m', and 'A4.m':
%
% >> nextname('A','1','.m')
% ans = 'A3.m'
%
% >> nextname('A','001','.m')
% ans = 'A003.m'
%
%%% Subdirectory 'HTML' contains folders 'B(1)', 'B(2)', and 'B(4)':
%
% >> nextname('HTML\B','(1)','')
% ans = 'B(3)'
%
% >> nextname('HTML\B','(001)','')
% ans = 'B(003)'
%
% >> nextname('HTML\B','(1)','',false) % default = name only.
% ans = 'B(3)'
% >> nextname('HTML\B','(1)','',true) % prepend same path as the input name.
% ans = 'HTML\B(3)'
%
%% Inputs and Outputs %%
%
%%% Input Arguments (**==default):
% bnm = CharVector or StringScalar giving the base filename or folder name,
%       with an absolute or relative file path if required.
% sfx = CharVector or StringScalar of the suffix to append, contains exactly
%       one integer number (use leading zeros to specify the number of digits).
% ext = CharVector or StringScalar of the file extension, if any. For folder
%       names or files without extensions use ''.
% otp = LogicalScalar, true/false** -> output with same path as input name / name only.
%
%% Input Wrangling %%
%
bnm = nn1s2c(bnm);
sfx = nn1s2c(sfx);
ext = nn1s2c(ext);
%
msg = 'Input <%s> must be a 1xN char vector or a scalar string.';
assert(ischar(bnm)&&ndims(bnm)==2&&size(bnm,1)==1,'SC.nextname:bnm:NotText',msg,'bnm')
assert(ischar(sfx)&&ndims(sfx)==2&&size(sfx,1)==1,'SC:nextname:sfx:NotText',msg,'sfx')
assert(ischar(ext)&&ndims(ext)==2&&size(ext,1)<=1,'SC:nextname:ext:NotText',msg,'ext')
%
tkn = regexp(sfx,'\d+','match');
val = sscanf(sprintf(' %s',tkn{:}),'%lu'); % faster than STR2DOUBLE.
assert(numel(val)==1,'SC:nextname:sfx:NotOneInteger',...
    'The suffix must contain exactly one integer value (any number of digits).')
wid = numel(tkn{1});
%
%% Get Existing File / Folder Names %%
%
[inpth,fnm,tmp] = fileparts(bnm);
fnm = [fnm,tmp];
%
% Find files/subfolders on that path:
raw = dir(fullfile(inpth,[fnm,regexprep(sfx,'\d+','*'),ext]));
%
% Special case of exactly one matching subfolder (Octave):
if ~all(strncmp({raw.name},fnm,numel(fnm)))
    raw = dir(fullfile(inpth,'*'));
end
%
% Generate regular expression:
rgx = regexprep(regexptranslate('escape',sfx),'\d+','(\\d+)');
rgx = ['^',regexptranslate('escape',fnm),rgx,regexptranslate('escape',ext),'$'];
%
% Extract numbers from names:
tkn = regexpi({raw.name},rgx,'tokens','once');
tkn = [tkn{:}];
%
%% Identify First Unused Name %%
%
if numel(tkn)
    % For speed these values must be converted before the WHILE loop:
    vec = sscanf(sprintf(' %s',tkn{:}),'%lu');  % faster than STR2DOUBLE.
    %
    % Find the first unused name, starting from the provided value:
    while any(val==vec)
        val = val+1;
    end
end
%
name = [fnm,regexprep(sfx,'\d+',sprintf('%0*u',wid,val)),ext];
%
if nargin>3
    assert(islogical(otp)&&isscalar(otp),'SC:nextname:otp:NotLogicalScalar',...
        'Input <otp> must be a scalar logical (i.e. true or false).')
    if otp
        name = fullfile(inpth,name);
    end
end
%
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%nextname
function arr = nn1s2c(arr)
% If scalar string then extract the character vector, otherwise data is unchanged.
if isa(arr,'string') && isscalar(arr)
    arr = arr{1};
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%nn1s2c

%% d
function copyGraphObj2Clipboard(valArgCopy, fileName, obj)
% First param is DPI scale for copied graphic object
if (valArgCopy)
    if(inBrowserOrMobileRuned)
        st = dbstack; namestr = st.name;
        fprintf(1, "\t- Skipped %s feature, probably you launched scripts in browser or on smartphone\n", namestr); 
        return;
    end
    if( 1 < valArgCopy )
        copygraphics(obj, 'Resolution', valArgCopy);
    else copygraphics(obj);
    end
    fprintf(1,"\t* Skopiowano do schowka: %s\n", fileName);
end
end
%% make new figure with one subplot of from old fig
% nFig = 6;
% for i=14
%     figure(nFig); ncol = i;
%     subplot(4,4,ncol);
%     ax1=gca;
%
%     figure;
%     tcl=tiledlayout(1,1);
%     ax1.Parent=tcl;
%     ax1.Layout.Tile=1;
% %     ax1.XLabel = tcl.XLabel
% %     ax1.YLabel = tcl.YLabel
%
%     figPW(nFig, ncol, 'png', 'figury/', 1, 1, 3)
% end
