function T = codeTraces
%codeTraces Code traces currently in effect
%   codeTraces returns a table of code traces currently in effect. The
%   table contains the variables FunctionName and LineNumber.
%
%   See also addCodeTrace, clearCodeTraces.

%   Steve Eddins
%   Copyright 2022 The MathWorks, Inc.

    ds = dbstatus;
    expressions = string({ds.expression});
    ds = ds(endsWith(expressions,codeTraceSuffix()));
    FunctionName = reshape(string({ds.name}),[],1);
    LineNumber = reshape(string({ds.line}),[],1);
    T = table(FunctionName,LineNumber);
end
        