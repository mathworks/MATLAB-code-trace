function clearCodeTraces
%clearCodeTraces Clear all code traces
%   clearCodeTraces clears all code traces currently in effect.
%
%   See also addCodeTrace, codeTraces.

%   Steve Eddins
%   Copyright 2022 The MathWorks, Inc.

    ds = dbstatus;
    for k = 1:length(ds)
        if endsWith(ds(k).expression{1},codeTraceSuffix())
            dbclear("in",ds(k).name,"at",string(ds(k).line));
        end
    end
end
        