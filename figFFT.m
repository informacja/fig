function [s] = figFFT(x, fs, s) % mayby return P1 vector?
% Requaire args; x, fs
% Optional struct as 3td argument with (non zero to enable) fields:
%   log - x and y axes are logaritized. Uses loglog() plot func.
%   logx - x axes are logaritized. Uses semilogx() plot func.
%   logy - y axes are logaritized. Uses semilogy() plot func.
%   tag - Text make the same scale for axis Taged (eg. "Freq Domain")
% TODO
%   nrF - plot on specified figure number
%   xlimes - cut axis, 2 scalar vector (beg, end)
%   ylimes - cut axis, 2 scalar vector (beg, end)
%   LineWidth
%   displayName (for legend)
%
% Example 1:
%   figFFT(x, fs) title(""); subtitle("a)"); % x - time data, fs - frequency sampling
%
% Example 2:
%   s = []; s.logx = 1;
%   s = figFFT(x, fs, s)

% Changelog by PSW:
% * new smoothing metod for logy plots 20.07.24

% TODO
% db as in pinknoise example
% is plot or return vector only
% save history to s, to make the same scale
% a = next tioel
if( nargin==1 && isstruct(x) && isfield(x, "historyAxis") ) setYLim(x); return; end % reasign YLim

if(nargin<2) fprintf(1,"Provide arguments. If you don know just type: help %s", mfilename('name'));  return; end

vN = string(inputname(1));
LW = 1.2;
maxTu = 1e3;
dbScale = 0;
smooFuncName = ""; txInVars = ""; currTag = "Frequency Domain";
kolP1 = 'c'; kolAf = 'k'; % default plot colors for first data
lP1 = sprintf("%s P1", vN); lAf = sprintf("%s Af", vN);
plotP1 = 1; plotAf = 1;
% inDataNames = [];
if(nargin<3)
    s = [];
else
    if(isfield(s,"log"))    log = s.log; end
    if(isfield(s,"logx"))   logx = s.logx; end
    if(isfield(s,"logy"))   logy = s.logy; end
    if(exist("logx") && exist("logy"))
        if(logx && logy) log = 1; end
    end
    if(isfield(s,"db"))     dbScale = s.db; end

    if(isfield(s,"maxTu"))  maxTu = s.maxTu; end
    if(isfield(s,"faster")) faster = s.faster; end
    if(isfield(s,getVarName(plotP1))) plotP1 = s.plotP1; end
    if(isfield(s,getVarName(plotAf))) plotAf = s.plotAf; end
    if(isfield(s,"tag")) currTag = s.tag; end

    % depracated - tag in axis is enough solution % if(isfield(s,getVarName(inDataNames))) s.inDataNames, inDataNames = strcat(s.inDataNames, " ", vN); end

    % nrF = 1;
    % xlimes = [];
end
% inDataNames = get(gca,'Tag'), if(isempty(inDataNames)) set(gca,'Tag', vN); else set(gca,'Tag', strcat(inDataNames, " ", vN)); end; inDataNames = get(gca,'Tag')
%   set(gca,'Tag', strcat(inDataNames, " ", vN));
% inDataNames = get(gca,'Tag'),

if(~isfield(s,"inDataNames")) s.inDataNames = vN; else s.inDataNames(numel(s.inDataNames)+1) = vN; end
Y = fft(x);
L = length(Y);
P2 = abs(Y/L);
P1 = P2(1:ceil(L/2));
P1(2:end-1) = 2*P1(2:end-1);
dt = 1/fs;
f = fs/L*(0:(ceil(L/2)));

dzielnik = 100; % bigger = faster
if(exist('faster','var')) dzielnik = faster; end
kHz = fs/1e3;
val = char(string(ceil(kHz*L*dt)));
mnoznik = str2double(val(1))*10^length(val)/dzielnik;

dzielnikWyniku = 1; if(exist("logx", "var") && logx) dzielnikWyniku = 10; end
Twygl=mnoznik;  Tu=round(Twygl/(dt*1e3)/dzielnikWyniku);
if(Tu <= 1 ) error("Tu zbyt małe"); end

axes = findobj( gcf, 'Type', 'Axes' ); tags = [];
for( a = axes ) tags = [tags; a.Tag]; end

if(~isempty(tags) && ~isempty(find(tags==currTag,1))) 
    kolP1 = ''; kolAf = ''; 
end % use random plot colors

if(~exist("logx", "var") && ~exist("log", "var") && ~exist("logy", "var"))
    nxf=0; nrF=nxf; % for filtrWidmaMTF
    X=P1; MTF(1).Tu = []; MTF(2).Tu = []; MTF(3).Tu = [];
    if(~exist("filtrWidmaMTF", 'file')) maxTu = -1; end % if not accessible
    if(Tu>maxTu)
        % fprintf("Skipping smooth spectra with MTF because window length is Tu=%g\nInstead, movmean was used", Tu);
        Af =  movmean(P1,Tu); smooFuncName = "movmean(Tu)";
    elseif(~isvector(x))
        % fprintf("Skipping smooth spectra with MTF because input data isn't vector. dimSize[%d %d]\n", size(x,1), size(x,2));
        Af =  movmean(P1,Tu); smooFuncName = "movmean(Tu)";
    else filtrWidmaMTF; smooFuncName = "MTF(Tu)"; end
else
    Af = smoothdata(P1,"gaussian",Tu); smooFuncName = 'smoothdata(P1,"gaussian",Tu)';
end

if(exist("log", "var") && log)
    if(dbScale) Af = db(Af); if(plotP1) P1 = db(P1); end; end
    if(plotP1) loglog(f(1:length(P1)),P1,kolP1,"LineWidth",1,'DisplayName',lP1); hold on; end
    if(plotAf) loglog(f(1:length(Af)),Af,kolAf,"LineWidth",LW,'DisplayName',lAf); hold off; end; legend('Location','southwest'); ylabel("log|P1(f)|");  if(dbScale)  ylabel("Power [dB]"); end
elseif(exist("logx", "var") && logx)
    if(plotP1) semilogx(f(1:length(P1)),(P1),kolP1,"LineWidth",1,'DisplayName',lP1); hold on; end
    if(plotAf) semilogx(f(1:length(Af)),(Af),kolAf,"LineWidth",LW,'DisplayName',lAf); hold off; end; ylabel("|P1(f)|");
elseif(exist("logy", "var") && logy)
    if(dbScale) Af = db(Af); if(plotP1) P1 = db(P1); end; end
    if(plotP1) semilogy(f(1:length(P1)),P1,kolP1,"LineWidth",1,'DisplayName',lP1); hold on; end
    if(plotAf) semilogy(f(1:length(Af)),Af,kolAf,"LineWidth",LW,'DisplayName',lAf); hold off; end; ylabel("log|P1(f)|"); if(dbScale)  ylabel("Power [dB]"); end
else % linear scale
    if(plotP1) plot(f(1:length(P1)),P1,kolP1,"LineWidth",1,'DisplayName',lP1); hold on; end
    if(plotAf) plot(f(1:length(Af)),Af,kolAf,"LineWidth",LW,'DisplayName',lAf); hold off; end; ylabel("|P1(f)|")
end
legend;

if(~isfield(s,"historyAxis")) s.historyAxis = []; end
% if(~exist("s.historyAxis",'var') s.historyAxis = []; end
s.historyAxis = [s.historyAxis gca];
for( i = 1:numel(s.historyAxis) ) txInVars = sprintf("%s %s", txInVars, s.inDataNames(i)); end
title(sprintf("Single-Sided Amplitude Spectrum of: %s", txInVars ));
txP1 = ""; if(plotP1) txP1 = "P1 is original spectrum, "; end
txAf = ""; if(plotAf) txAf = sprintf("%s smoothed with %s", getVarName(Af), smooFuncName); end
subtitle(sprintf("%s%s", txP1, txAf));
% if(exist("LwAm","var")) depracated meta częstotliwośc, ma sens dla d.
% czasu
% xlabel(sprintf("Frequency [Hz]\nTu=%g [S] fs=%g [kHz] fw/fmax=1/%g [?]", Tu, kHz, LwAm/Tu)); % [s] T = %.2f L*dt,
% else
xlabel(sprintf("Tu=%g [S] fs=%g [kHz] Frequency [Hz]", Tu, kHz));
% end
axis tight;
% axis([1 fs/2 0 45]),
grid on
xlim([1 fs/2])
setYLim(s);
% minY =
set(gca,'Tag', currTag);

% ylim()
% s.inDataNames = inDataNames;
return
y = pinknoise(length(x),1);  %2^16,1e3    % Generate 1000 channels of pink noise
y = x;
Y = fft(y);          % Compute the FFT of each channel of pink noise
FS = 44100; FS=fs;          % Display assuming 44.1 kHz sample rate
ff = linspace(0,FS/2,size(y,1)/2); Af = movmean(abs(Y(1:end/2,:)),Tu);          % Frequency axis
nexttile, semilogx(ff,db(mean(abs(Y(1:end/2,:)),2)),'c',ff,db(Af),'k')   % Plot the response

axis([1 FS/2 0 45]), grid on                % Set axis and grid
title('Pink Noise Spectral Density (Averaged)')
xlabel('Frequency (Hz)')
ylabel('Power (dB)')
% [length(f),length(ff)]
% [f(1), ff(1)]


P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = fs/L*(0:(L/2));
Af =  movmean(P1,Tu);
nexttile, semilogx(f,(P1),"LineWidth",1,'Color','c'); hold on
semilogx(f,(Af),'k')
title("Single-Sided Amplitude Spectrum of X(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|"); axis tight
end

function setYLim(s)
% Get min/max values
YL = s.historyAxis(1).YLim;
for(i = 2:numel(s.historyAxis)) % skip if only one figure
    curr = s.historyAxis(i).YLim;
    if(YL(1) > curr(1)) YL(1) = curr(1); end
    if(YL(2) < curr(2)) YL(2) = curr(2); end
end

% Set min/max values for all
for(i = 1:numel(s.historyAxis)) % skip if only one figure
    s.historyAxis(i).YLim = YL;
end
end