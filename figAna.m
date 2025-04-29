% figLib Analize dir with signals (time&freq)
function [s] = figAna(x)

if(isfield(x,"fileFilter"))
    ff = x.fileFilter;
    % s = x;
else
    if(isstruct(x))
        ff = x;
    end
end
s.separate = 1;
nexttile; s = figDirPlot(ff); axis tight
nexttile, 
% s.logx=1;
s = figFFTplot(s.x, s.fs, s); axis tight
xlim([0 555])
end

% fig p
% fig hq
