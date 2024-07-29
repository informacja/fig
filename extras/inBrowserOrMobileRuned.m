function [browserOrMobile] = inBrowserOrMobileRuned()
% Returns true/false value, usefull for unsupported features skipping info message
%   Example code for user message in called feature function:
%       st = dbstack; namestr = st.name;
%       fprintf(1, "\t- Skipped %s feature, probably you launched scripts in browser or on smartphone\n", namestr); 
%       return;
browserOrMobile = inBrowserRuned;
% mobile TODO
end

function [browser] = inBrowserRuned()
    browser = false;
    if(ismac) return; end
    if(isunix())
        result = evalc('ver');
        % result(1:500)
        startIndex = regexp(result,"\nOperating System:");
        stopIndex = regexp(result,"\nJava Version:");
        line = result(startIndex:stopIndex);
        % os = "Ubuntu";
        % i = strfind(line, os);
        % if(i>0)
        %     browser = false;
        % end
        os = "professional";
        i = strfind(line, os);
        if(i>0)
            mobile = true;
        end        
        
        os = "aws";
        i = strfind(line, os);
        if(i>0)
            browser = true;
        end
    end    
end




% from mobile
% >> inBrowserOrMobileRuned
% 
% ans =
% 
%     '-------------------------------------------------------------------------------------------------
%      MATLAB Version: 24.1.0.2661297 (R2024a) Update 5
%      MATLAB License Number: professional
%      Operating System: Linux 5.15.0-1062-aws #68~20.04.1-Ubuntu SMP Wed May 1 15:24:09 UTC 2024 x86_64
%      Java Version: Java 1.8.0_292-b10 with AdoptOpenJDK OpenJDK 64-Bit Server VM mixed mode
%      -------------------------------------------------------------------------------------------------
%      MATLAB                            '

% from browser
 % '-------------------------------------------------------------------------------------------------
 %     MATLAB Version: 24.1.0.2661297 (R2024a) Update 5
 %     MATLAB License Number: 40759233
 %     Operating System: Linux 5.15.0-1062-aws #68~20.04.1-Ubuntu SMP Wed May 1 15:24:09 UTC 2024 x86_64
 %     Java Version: Java 1.8.0_292-b10 with AdoptOpenJDK OpenJDK 64-Bit Server VM mixed mode
 %     -------------------------------------------------------------------------------------------------
 %     MATLAB   
% 
% function [runable] = checkSystem()
% runable = 1;
% 
% end