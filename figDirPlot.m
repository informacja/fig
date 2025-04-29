function [s] = figDirPlot(s)


endOfFilePath = ".wav";
if(nargin<1)
    % s = [];
elseif(nargin ==1)
    if(isText(s)) endOfFilePath = s; end
end
 s = [];
separate = 0;
if(isfield(s,"separate")) separate = s.separate; end
% path = ".";
% if(isfield(s,"path")) path = s.path; end
s.x=[];
txtLg = [];
gfns = dir; % global

for(k=1:numel(gfns))
    cn = gfns(k).name;
    if(isfolder(cn)) continue; end
    if(strcmp(cn,".")) continue; end
    if(strcmp(cn,"..")) continue; end
    if((strlength(endOfFilePath))>=strlength(cn)) continue; end;
    % cd(cn);

    if(strcmp(cn(end-strlength(endOfFilePath)+1:end),endOfFilePath))
        ai = audioinfo(cn);
        x = audioread(cn);
        fn = string(cn(1:end-4));
        txtLg = [txtLg; fn];
        % normOfX = x/max(x);
        if(separate) hold off; nexttile;  end
        s.fs = ai.SampleRate;
        t = (0:length(x)-1)/s.fs;
        plot(t,x); hold on; axis tight; subtitle(fn); xlabel("time [s]")
        s.x = [s.x x];
        s.fileName(size(s.x, 2)) = fn;
    end
end

hold off;
dirName = pwd; pos = strfind(dirName, "/");
if(separate)
    sgtitle(dirName(pos(end)+1:end));
else
    legend(txtLg); 
    title(dirName(pos(end-1)+1:pos(end)-1)); 
    % s.inputname = dirName(pos(end)+1:end);
    subtitle(dirName(pos(end)+1:end));
xlabel("time [s]"); ylabel("Amp."); 
end
end