function codeTrace(function_name,line_number,label,expression)
    arguments
        function_name (1,1) string
        line_number   (1,1) double
        label         (1,1) string = ""
        expression    (1,1) string = ""
    end

    if (label == "") && (expression == "")
        condition = locationCondition(function_name,line_number);

    elseif (label == "") && (expression ~= "")
        condition = expressionCondition(function_name,line_number,expression);

    elseif (label ~= "") && (expression == "")
        condition = labelCondition(function_name,line_number,label);

    else
        condition = labelExpressionCondition(function_name,line_number,label,expression);
    end

    dbstop("in",function_name,"at",string(line_number),"if",condition)
end

function condition = locationCondition(function_name,line_number)
    label = locationLabel(function_name,line_number);
    condition = "fprintf(1,""[trace] %s\n"",";
    condition = condition + """" + label + """" + ") < 0 % TRACE_CODE";
end

function condition = expressionCondition(function_name,line_number,expression)
    label = locationLabel(function_name,line_number);
    condition = "fprintf(1,""[trace] %s %s%s = %s\n"",";
    condition = condition + """" + label + """" + ",";
    condition = condition + "repmat('  ',1,length(dbstack)-1)" + ",";
    condition = condition + """" + expression + """" + ",";
    condition = condition + "compactDisp(" + expression + ")) < 0";
    condition = condition + codeTraceSuffix;
end

function condition = labelCondition(function_name,line_number,label)
    loc_label = locationLabel(function_name,line_number);
    condition = "fprintf(1,""[trace] %s %s%s\n"",";
    condition = condition + """" + loc_label + """" + ",";
    condition = condition + "repmat('  ',1,length(dbstack)-1)" + ",";
    condition = condition + """" + label + """" + ") < 0";
    condition = condition + codeTraceSuffix;
end

function condition = labelExpressionCondition(function_name,line_number,label,expression)
    loc_label = locationLabel(function_name,line_number);
    condition = "fprintf(1,""[trace] %s %s%s %s = %s\n"",";
    condition = condition + """" + loc_label + """" + ",";
    condition = condition + "repmat('  ',1,length(dbstack)-1)" + ",";
    condition = condition + """" + label + """" + ",";
    condition = condition + """" + expression + """" + ",";
    condition = condition + "compactDisp(" + expression + ")) < 0";
    condition = condition + codeTraceSuffix;
end


function label = locationLabel(function_name,line_number)
    function_name = shortenString(function_name,16);
    label = sprintf("%16s",function_name);

    label = label + ":";

    label = label + sprintf("%-5d",line_number);
end

function out = shortenString(in,n)
    L = strlength(in);
    if (L > n)
        middle_mark = "...";
        K = strlength(middle_mark);
        p = floor((L - K)/2);
        s1 = extractBefore(in,p+1);
        s2 = extractAfter(in,L-p);
        out = s1 + middle_mark + s2;

    else
        out = in;

    end
end

