function fig(varargin)
% figLib caller function
%   gm - call gMain(dir), to generate main.m file in current working dir
%   hq - call figPW hq, to save PNG with some more default params for styling
%   l  - styleLudwin
%   la - as above for all figures
%   Example 1:
%       fig gm

% Pomysł:
% Gdy jest debug=1 or logOutput=1
% save log with timestamp, and add timesampt to sghtitle in figPW
% figFFT rename to? figFFTplot() figFplot() and figTplot for time domain


shortcutsFirstParam = [
    "gm" % generate main
    "hq" % save png
    "l"  % style Ludwin
    "la" % style Ludwin & save all fig
    "p"  % make current figure pretty and save
    "c"  % backup & copy to clippboard 
    "le" % low efficiency. Create simple figures
    "bp" % big picture, all important figures in onpage PDF
    ];

if(nargin)
    i = nargin;
    while ( 0 < i ) % used to skip section of code statement by break; instead of return;, to end all file interpretation
        if(isText(varargin{1}))
            param1 = lower(string(varargin{1}));
            switch(param1)
                case "gm",  gMain(dir);
                case "hq",  figPW('hqpng', 1, 'openFolder', 1, 'goldenRatio', 0, 'saveCopyFig', 0, 'skipSaveAs', 1, 'tileSpacing', 'tight', 'tilePadding', 'none') % shorted param setup explanation 
                case "l",   width=1280; height=1024; figPW("styleLudwin", 1, "exportPDF", 1)%, 'rePositonYlabel', 1, "figX", width, 'figY', height)
                case "la",  figPSW("exportPDF", 1, "styleLudwin", 1)
                case "p",   figPW stylepiotr goldenratio labely itp
                case "c",   figPW copy
                otherwise,  fprintf(1,"Unrecognized parameter '%s'", param1)
            end
        end
        break;
    end
    % if( strcmpi(varargin{1}, "art") || strcmpi(varargin{1}, '"art"') ) % set default for article arguments

    % fig gm sourcePath
    %     gMain(dir) | gMain(sourcePath)
else

    % list functions
    % https://www.mathworks.com/help/matlab/matlab_prog/create-a-help-summary-contents-m.html

end
end