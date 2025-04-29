function const = figNext(varargin)
% Auto couting figure number. Up to 9 figures per file counting (one digit).
%   In your Base file (eg. main.m) use code;
%       global nrF; nrF = 0;
%   and in every nested file code run
%       figNext, figure(nrF);
%
%   OR you can use locally, to get const value for this dbstack eg.
%       figure(figNext(0)+3)
%   To count up in this file just place this line at the begninig of called script
%       figNext(mfilename('name'));

global nrF; global lastFn; global lockFn; global DEBUGfigNext; % numberFigure, lastFilename, lockFilename - for conting up eg. 10 20 30
DEBUG = DEBUGfigNext;

inputNrF = nrF;
if(isempty(nrF)||isnan(nrF)) nrF = 1; end
filesCallStackNonImporta = 2; st = dbstack; stName = [ st.name " " ]; stName = stName(1:end-1);
if(numel(st)==1) nrF = nrF + 1; fprintf(1,"nrF var incremeted\n", getVarName(nrF)); const = nrF; return; end
currFn = st(2).name;
dM = find(stName=="main");
if(isempty(dM)) dM = find(stName==st(end).name); end
dC = find(stName==currFn);
distFromMainToCurr = dM(1)-dC(1);
while 1
    if(isnan(nrF)) nrFvarWasNaN = string(nrF); warning(nrFvarWasNaN); inputNrF = 1; nrF = 1; break; end
    if(nargin<1)% no params
        if(isempty(lastFn)) % First time this function called
            nrF = nrF+10^distFromMainToCurr; break;
        else
            dL = find(stName==lastFn);
            if(isempty(dL)) % not found <-
                c = char(string(nrF)); % character
                if(distFromMainToCurr==0) % from main script file
                    d = str2double(c(1));
                else d = str2double(c(distFromMainToCurr)); % digit
                end
                nrF = (d+1)*10^distFromMainToCurr;
                break;
            else
                distPrevFileToCurr = dL-dC;
                if(distPrevFileToCurr == 0) nrF = nrF+1; break; end% same file
                nrF = nrF*10^distPrevFileToCurr;
                if(distPrevFileToCurr < 0) nrF = ((floor(nrF/10)+1)*10); end
                break
            end
        end
        if(numel(st)>1 && ~isempty(lastFn))
            if(st(2).name == lastFn) % same file
                % distFromMainToCurr
                nfF = nrF+1;
            else
                % nrF/(numel(dbstack)-2)

                % nrF = nrF/10^(strlength(string(nrF))-2); %make it 2 digit
                nrF = nrF+2;
                % const = nrF;
                break;
            end
        end
        % end
        nrFbefore = nrF;
        nrF = nrF+10^(distFromMainToCurr-1);%round(nrF + 10^(length(dbstack)-filesCallStackNonImporta));
        if(round(nrF) ~= nrF)
            nrFbefore
            distFromMainToCurr
            nrF
            nrF = round(nrF);
        end
        if(nrFbefore == nrF) nrF = nrF+1; end

        global figNextUsed;
        figNextUsed = figNextUsed+1;
    else
        if(isnumeric(varargin{1}))
            if(varargin{1} == 0)
                const = 10^(length(dbstack)-filesCallStackNonImporta+1);
            else
                const = 10^(length(dbstack)-filesCallStackNonImporta+1+varargin{1});
            end
        else
            distPrevFileToCurr = 0;
            if(isText(varargin{1}))
                lockFn = string(varargin{1});
                % dM = find(stName=="main")
                dLock = find(stName==lockFn);
                distFromMainToCurrLock = dM-dLock;
                if(distFromMainToCurrLock==0) distFromMainToCurrLock = 1; end
                if(~isempty(distFromMainToCurrLock))
                    c = char(string(nrF)); % character
                    d = str2double(c(1:distFromMainToCurrLock)); % digit
                    if(isempty(lastFn)) lastFn = currFn; nrF = 10^distFromMainToCurr;  break; end % most occurance should be = 10
                    dLast = find(stName==lastFn);
                    if(isempty(dLast)) % not found
                        c = char(string(nrF)); % character
                        d = str2double(c(1:distFromMainToCurr)); % digit
                        nrF = (d+1)*10^distFromMainToCurr;
                        break;
                    else distPrevFileToCurr = dLast-dC;
                    end
                    if(strcmp(lastFn, lockFn))
                        nrF = (d+1)*10;%^distFromMainToCurr-distFromMainToCurr+1;
                    else
                        nrF = (d)*10^distPrevFileToCurr;
                    end
                    break;
                end


                % if(st(2).name == currFn)
                %
                %     callStackFromMain = numel(st)-2;
                % else
                %     unimplementedSearchIndbstack = 1 % unexpected, implemnt
                % end
                lastFn = currFn;
                lockFn = currFn;
                % nrF=14
                % c = char(string(nrF)); % character
                % d = str2double(c(distFromMainToCurrLock-distPrevFileToCurr)); % digit
                % nrF = d*10^distFromMainToCurrLock;
                nrF = nrF*10^distPrevFileToCurr;
                % nrF = nrF+10^distFromMainToCurrLock;
            else

                % do check in db stack, and shift if in current file just add 1
                if(nrF < 10) nrF = 10; end
                d = floor(nrF/10); % dziesiatki
                nrF = nrF+1*10^distPrevFileToCurr
                % nrF = (d+1)*10;
                % numel(dbstack)
                % dbstack
                % lastFn
            end
            % end
            % dbstack(end-1)
        end
    end
    break; % prevent infinit loop, jumping by break; now is possible
end % while 1

% while(const not exist in figNrmbers) ++
hall = findall(groot,'Type','figure');
if(~isempty(hall))
    n = int32([hall.Number]); figNrExistedAndChanged = 0;
    r = nrF - inputNrF; % roznica
    if(r<1||isnan(r)||isempty(r)) r = 1; end
    while ( ~isempty(find(n==nrF)) && r)
        fprintf(1,"In: %d Propose: %d ", inputNrF, nrF); warning("This figure number exist")
        nrF = nrF+r;
        figNrExistedAndChanged = figNrExistedAndChanged+1;
    end
    if(figNrExistedAndChanged) fprintf(1,"nrF = %d\n", nrF); end
end
% todo check if figure nr exist in all opened figures
if(~exist('const','var'))
    const = nrF;
end
lastFn = currFn;
if(DEBUG)
    lineInFile = [ st(2).line stName(2:end) nrF ] % DEBUG when unneedent empty figures
end
end

% function output = isText(myVar)
% output = isstring(myVar)||ischar(myVar)||iscellstr(myVar);
% end