function debugTrace(function_name,line_number,label,expression)

function_name = string(function_name);
line_number = string(line_number);
if nargin > 2
    label = string(label);
end
if nargin > 3
    expression = string(expression);
end

if nargin == 4
    if label == ""
        s = "fprintf(1,""%s = %s    (%s, line %s)\n"",";
        s = s + """" + expression + """" + ",";
        s = s + "compactDisp(" + expression + "),";
        s = s + """" + function_name + """" + ",";
        s = s + """" + line_number + """" + ") < 0";
    else
        s = "fprintf(1,""%s%s %s = %s    (%s, line %s)\n"",";
        s = s + "repmat('  ',1,length(dbstack)-1)" + ",";
        s = s + """" + label + """" + ",";
        s = s + """" + expression + """" + ",";
        s = s + "compactDisp(" + expression + "),";
        s = s + """" + function_name + """" + ",";
        s = s + """" + line_number + """" + ") < 0";
    end

elseif nargin == 3
    s = "fprintf(1,""%s:%s %s\n"",";
    s = s + """" + function_name + """" + ",";
    s = s + """" + line_number + """" + ",";
    s = s + """" + label + """" + ") < 0";

else
    s = "fprintf(1,""%s:%s\n"",";
    s = s + """" + function_name + """" + ",";
    s = s + """" + line_number + """" + ") < 0";
end

dbstop("in",function_name,"at",line_number,"if",s)
