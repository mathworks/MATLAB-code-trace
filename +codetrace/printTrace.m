function tf = printTrace(function_name,line_number,options)
    arguments
        function_name      (1,1) string
        line_number        (1,1) double
        options.Label      (1,1) string = ""
        options.Expression (1,1) string = ""
    end

    tf = false;

    loc_label = locationLabel(function_name,line_number);
    fprintf(1,"[trace] %s%s", ...
        repmat('  ',1,length(dbstack)-1), ...
        loc_label);

    if options.Label ~= ""
        fprintf(1," %s",options.Label);
    end

    if options.Expression ~= ""
        fprintf(1," %s = %s",options.Expression, ...
            codeTraceCompactDisp(options.Expression));
    end

    fprintf(1,"\n");
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