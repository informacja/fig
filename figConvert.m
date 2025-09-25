function [newFigNr] = figConvert(figNr, subplotDim1Dest, subplotDim2Dest, subplotDim1Source, subplotDim2Source)
% Convert old styled figure by subplot() function, to tiledlayout.
%   Param: figure number or path to *.fig file
%   Return: new Figure Number
% Example 1:
%   figConvert(1);
% Example 2:
%   newConvFigNr = figConvert(gcf().Number)

% Created 20.07.2024 by PSW in the Odyseja

if(nargin < 1) disp("No params. Set figure number or path."); end 
if(isnumeric(figNr))
    % ok, do nothing
else
   if(isstring(figNr))
        % o = openfig("Collegium_Medicum_figPW_Spectrum_for_intra-group_raw_&_power_signals_1.fig");
        o = openfig(figNr);
        figNr = o().Number;
   else
       error("Unknown param");
   end
end

if(nargin < 3)
    subplotDim1Dest = 2;
    subplotDim2Dest = 3;
end

if(nargin == 3)
    subplotDim1Source = subplotDim1Dest;
    subplotDim2Source = subplotDim2Dest;
end

nrOfPlots = subplotDim1Dest*subplotDim2Dest;

h = figure(figNr);
tmp = h.Children;
SGtitle = '';
% try
    for i = 1:length(tmp)
        tmp = h.Children(i);
        if(strcmp(get(tmp, 'type'),'tiledlayout'))
            warning(sprintf("The figure(%d) have Tiled Layout, so can't be converted again. Breaking oparation without return value!", figNr));
            return
        end
        if(strcmp(get(tmp, 'type'), 'subplottext') == 1 )
            SGtitle = tmp.String;
        end
    end

newFigHandle = figure;

tcl=tiledlayout(subplotDim1Dest, subplotDim2Dest);
% tcl = tiledlayout('flow')

for( sp = 1:nrOfPlots)%numel(h.Childrens)
    figure(figNr); subplot(subplotDim1Source, subplotDim2Source, sp);
    ax = gca;

    figure(newFigHandle);
    if(sp == nrOfPlots) for( j = 1:nrOfPlots-1) delete(nexttile(nrOfPlots)); end; end
    a = nexttile; 
    a.Layout.Tile = nrOfPlots;
    if(sp == nrOfPlots && sp ~= 1) delete(nexttile(nrOfPlots)); end 
    ax.Parent = tcl;
    ax.Layout.Tile = sp;
end

if(~isempty(SGtitle)) sgtitle(SGtitle); end

tcl.TileSpacing = 'compact'; 
% tcl.TileSpacing = 'tight';
tcl.Padding = 'none';
% tcl.TileSpacing = 'none';
% tcl.Padding = 'none';
newFigNr = newFigHandle().Number;
end