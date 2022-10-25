function T = codeTraces
%codeTraces Code traces currently in effect
%   codeTraces returns a table of code traces currently in effect. The
%   table contains the variables FunctionName and LineNumber.
%
%   See also addCodeTrace, clearCodeTraces.

%   Steve Eddins
%   Copyright 2022 The MathWorks, Inc.

    FunctionName = strings(0,1);
    LineNumber = zeros(0,1);

    ds = dbstatus;
    for k = 1:length(ds)
        for q = 1:length(ds(k).line)
            if endsWith(ds(k).expression{q},codetrace.codeTraceSuffix())
                FunctionName(end+1,1) = ds(k).name;            %#ok<*AGROW> 
                LineNumber(end+1,1) = double(ds(k).line(q));
            end
        end
    end

    T = table(FunctionName,LineNumber);
end
        