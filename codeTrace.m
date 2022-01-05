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
    condition = "fprintf(1,""trace--> %s\n"",";
    condition = condition + """" + label + """" + ") < 0 % TRACE_CODE";
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

% 
% 
% function_name = string(function_name);
% location_label = sprintf("%20s",function_name + ":" + string(line_number));
% if nargin > 2
%     label = string(label);
% end
% if nargin > 3
%     expression = string(expression);
% end
% 
% if nargin == 4
%     if label == ""
%         s = "fprintf(1,""%s%s = %s    (%s, line %s)\n"",";
%         s = s + "repmat('  ',1,length(dbstack)-1)" + ",";        
%         s = s + """" + expression + """" + ",";
%         s = s + "compactDisp(" + expression + "),";
%         s = s + """" + function_name + """" + ",";
%         s = s + """" + line_number + """" + ") < 0";
%     else
%         s = "fprintf(1,""%s   %s%s %s = %s\n"",";
%         s = s + """" + location_label + """" + ",";
%         s = s + "repmat('  ',1,length(dbstack)-1)" + ",";
%         s = s + """" + label + """" + ",";
%         s = s + """" + expression + """" + ",";
%         s = s + "compactDisp(" + expression + ")) < 0";
%     end
% 
% elseif nargin == 3
%     s = "fprintf(1,""%s   %s%s\n"",";
%     s = s + """" + location_label + """" + ",";
%     s = s + "repmat('  ',1,length(dbstack)-1)" + ",";
%     s = s + """" + label + """" + ") < 0";
% 
% else
%     s = "fprintf(1,""%s\n"",";
%     s = s + """" + location_label + """" + ") < 0";
% end
% 
% dbstop("in",function_name,"at",string(line_number),"if",s)
