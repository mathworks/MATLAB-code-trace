function out = compactDisp(val)
a.nothing = val;
s = string(evalc("disp(a)"));
s = split(s,newline);
out = extractAfter(s(1),":");

