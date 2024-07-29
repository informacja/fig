function [mobile] = inMobileRuned()
% Return true if script runed on mobile app
    mobile = false;
    if(ismac) return; end
    if(isunix())
        result = evalc('ver');
        startIndex = regexp(result,"\nMATLAB License");
        stopIndex = regexp(result,"\nOperating System:");
        line = result(startIndex:stopIndex);
        os = "professional";
        i = strfind(line, os);
        if(i>0)
            mobile = true;
        end
    end
end