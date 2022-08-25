function out = codeTraceCompactDisp(val)
% Utility function for code trace printing.
% This function needs to be on the path so that it can be found when
% conditional breakpoints are executed.

a.nothing = val;
s = string(evalc("disp(a)"));
s = split(s,newline);
out = extractAfter(s(1),":");

% Copyright 2022 The MathWorks, Inc.

