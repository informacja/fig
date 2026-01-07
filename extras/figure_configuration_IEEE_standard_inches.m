%% IEEE Standard Figure Configuration - Version 1.0

% run this code before the plot command

%%
% According to the standard of IEEE Transactions and Journals: 

% Times New Roman is the suggested font in labels. 

% For a singlepart figure, labels should be in 8 to 10 points,
% whereas for a multipart figure, labels should be in 8 points.

% Width: column width: 8.8 cm; page width: 18.1 cm.

%% width & hight of the figure
k_scaling = 4/2;          % scaling factor of the figure
% (You need to plot a figure which has a width of (8.8 * k_scaling)
% in MATLAB, so that when you paste it into your paper, the width will be
% scalled down to 8.8 cm  which can guarantee a preferred clearness.
k_width_hight = 2/2;      % width:hight ratio of the figure

width = 3.25 * k_scaling;
hight = width / k_width_hight;

fontname = "Helvetica";

%% figure margins
% top = 0.5;  % normalized top margin
% bottom = 3;	% normalized bottom margin
% left = 3.5;	% normalized left margin
% right = 1;  % normalized right margin

% Set the figure background color and grid color
set(0, 'defaultFigureColor', 'w');
set(0, 'defaultAxesColor', 'w');
set(0, 'defaultAxesGridColor', [0.5 0.5 0.5]);
% top = 0;  % normalized top margin
% bottom = 0;	% normalized bottom margin
% left = 0;	% normalized left margin
% right = 0;  % normalized right margin

%% set default figure configurations
set(0,'defaultFigureUnits','inches');
set(0,'defaultFigurePosition',[0 0 width*2 hight*2]);

set(0,'defaultLineLineWidth',1*k_scaling);
set(0,'defaultAxesLineWidth',0.25*k_scaling);

set(0,'defaultAxesGridLineStyle',':');
set(0,'defaultAxesYGrid','on');
set(0,'defaultAxesXGrid','on');

set(0,'defaultAxesFontName',fontname);
set(0,'defaultAxesFontSize',8*k_scaling);

set(0,'defaultTextFontName',fontname);
set(0,'defaultTextFontSize',8*k_scaling);

set(0,'defaultLegendFontName',fontname);
set(0,'defaultLegendFontSize',8*k_scaling);

set(0,'defaultAxesUnits','normalized');
% set(0,'defaultAxesPosition',[left/width bottom/hight (width-left-right)/width  (hight-bottom-top)/hight]);

set(0,'defaultAxesColorOrder',[0 0 0]);
set(0,'defaultAxesTickDir','out');

set(0,'defaultFigurePaperPositionMode','auto');

% you can change the Legend Location to whatever as you wish
set(0,'defaultLegendLocation','southeast');
set(0,'defaultLegendBox','on');
set(0,'defaultLegendOrientation','vertical');

% Added by PSW 31.10.2025
% set(gcf,'Units','inches');                        % jednostka wymiarowania okna
% set(gcf,'Position', [0 0 width hight]); % wymiary okna: (x,y,dx,dy), (x,y)- lewy dolny

