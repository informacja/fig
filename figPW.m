function figPW(varargin)% FigType, ext, katalog)
% Part of 3 functions: figP, figPW and figPSW
%
% Usage:
%       figPW("copy", 1) % Figure will be coped to clipboard
% or just (fast version)
%       figPW
%
% Function gets pair of arguments.
% Example param: copy, maximize, noMargin, hq, axis, hLegend
%
% Args are compared case insensitive


% schowek do pdfa no margin
% size legend

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

if nargin == 1
    FigType = varargin{1};
end

% p.KeepUnmatched = 1;
% p.PartialMatching = 1;
% p.StructExpand  = 1;

valSaveTo = "figury/";
valDefaultExt = "png";
valNoTNR = "true";
valInterpreter = 'tex';
% valueAxis = "";
% valNoMarginPDF = "";

argCopy = "copy";
argMaximize = "maximize";
argNoMargin = "noMargin";
argHighQuality = "hq"; % png
argAxis = "axis";
argHorizontalLegend ="hLegend";
argInterpreter = "Interpreter";
argNoMarginPDF = "noMarginPDF";

% -- Parser ---------------------------------------------------------------

p = inputParser;
p.FunctionName = mfilename('name');

% with default values

addOptional(p, 'ext',   valDefaultExt);
addOptional(p, 'folder',valSaveTo);
addOptional(p, 'TNR',   valNoTNR);
addOptional(p, argInterpreter, valInterpreter);

optParam = [ argCopy, "TZ1", "TZ2", argNoMargin, argMaximize, argHighQuality, argAxis, argHorizontalLegend argNoMarginPDF];
for i = 1:length(optParam)
    addOptional(p,optParam(i),[]);
end

parse(p,varargin{:});

% -- Get values from parser -----------------------------------------------

ext = p.Results.ext;
tmp = char(ext);
if(tmp(1) ~= '.') ext = strcat('.', ext); end
katalog = p.Results.folder;
if isstring(p.Results.TNR) TNR = str2num( p.Results.TNR ); else TNR = p.Results.TNR; end
if isstring(p.Results.copy ) valArgCopy = str2num( p.Results.copy ); else valArgCopy = p.Results.copy; end
valueAxis = p.Results.axis;
variantHorizontalLegend = p.Results.hLegend;
valInterpreter = p.Results.Interpreter;
% addtimestamp TODO

if(nargin<2) ext ='png'; end;
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
    end
catch
    disp('Error getting sgtitle')
end

if( isempty(SGtitle) )
    title=get(h1,'string');
    if( isempty(title) )
        if(nargin<1)
        else
            fTitle = [ datestr(now ,'yyyy-mm-dd_HH.MM.ss') '_'];
        end
    else
        fTitle = strcat(title, "_");
    end
else
    %         tmp = tmp.String;
    fTitle = strcat(SGtitle, "_");
end
nrName = get( get(gcf,'Number'), 'Name' );
% title([{'Dziedzina czasu'},{'Cha-ka skokowa'}]);
% xlabel('O rzeczywista'); ylabel('O urojona');
% legend(str{:});

[calling_mfile, index] = dbstack(0);
mcName = [calling_mfile(length(calling_mfile)).name '_'];
[path, filename, Fext] = fileparts( mfilename('.')); [~, folderName] = fileparts(pwd()); folderName = strcat(katalog, folderName, "_");%if(nargin == 1) folderName = katalog; nrName=''; end;                     % nazwa TEGO *.m-pliku
filename = strcat(mcName, fTitle, nrName, num2str(get(gcf,'Number')));
filename = regexprep(filename, {'[%()*:\\" / ]+', '_+$'}, {'_', ''});
if(size(filename,1) > 1) filename = filename(1);end;
folderFilename = strcat(folderName,filename);

filenameExt = strcat(folderFilename, ext); % Default filename

%%%%%%% Fast save %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if numel(varargin) == 0
    figP(folderFilename,ext)
    return
end

%%%%%%% Font Times New Roman %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ( TNR )
    font = "Times";
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
                'FontWeight','normal',...
                'FontSize',sgTitleFontSize);
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

        set(get(ca,'Xlabel'), ...
            'FontUnits','points',...
            'FontWeight','normal',...
            'FontSize',FontSizeLabels,...
            'Interpreter',valInterpreter,...
            'FontName',font);
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
            'Interpreter',valInterpreter,...
            'Location','NorthEast',...
            'FontName',font);
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

%%%%%%% PNG HQ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (~ismember(argHighQuality, p.UsingDefaults))
%     figP(folderFilename, ext )% copyOnly
%     quality
    if (valArgCopy)
        fprintf("\t* %s\n", strcat("Skopiowano do schowka: ", filename));
        copygraphics(gcf)
    end 

    print( filenameExt, '-dpng', '-r300'); % Zapisz jako tenMPlik_nrOstatniejFigury.png
    fprintf("\t*%s\n", strcat("Zapisano w wysokiej jakości: ", filenameExt));
    return % jeżeli mniej niż 2 parametry
end

%%%%%%% Figure Scaling %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h=gcf; % for saveas()
% set(h,'PaperOrientation','Landscape');
%set(h,'Units','centimeters');
%set(h,'OuterPosition',[1, 1, 29 21]);
% set(h,'Position',2*get(h,'Position'));

% fn = nextname(filename, int2str(nrKol), "") to do
defaultExtension = '.fig';
if( strcmpi(ext, defaultExtension) == 0 ) % case insensitive
    if(defaultExtension(1) ~= '.') defaultExtension = strcat('.', defaultExtension); end
    saveas(h, strcat(folderFilename, defaultExtension));
    fprintf(1, '\t* Zapisano kopię: "%s%s"\n', folderFilename, defaultExtension);
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
font = 'Times'; % 'Times';

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

if (~ismember(argNoMarginPDF, p.UsingDefaults))
    fileNameEPS = strcat(folderFilename, ".eps");
    exportgraphics(gcf, fileNameEPS, 'ContentType', 'vector');
    mypdf = eps2pdf(fileNameEPS)
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
    figP(folderFilename,ext, TNR, valArgCopy);
    set(H,'Position',a);
    return
end
if( FigType==6 )

    if (valArgCopy)
        fprintf("\t* %s\n", strcat("Skopiowano do schowka: ", filename));
        copygraphics(gcf)
    end
    
    figP(folderFilename, ext, TNR, valArgCopy)
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
    fprintf("\t* %s\n", strcat("Skopiowano do schowka: ", filename));
    copygraphics(gcf)
end 

figP(folderFilename, ext)

end
% set(gcf,'Resize','off')


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
