function tf = printTrace(function_name,line_number,options)
    arguments
        function_name      (1,1) string
        line_number        (1,1) double
        options.Label      (1,1) string = ""
        options.Expression (1,1) string = ""
        options.NumExpressionOutputs (1,1) {mustBeNumeric, mustBeMember(options.NumExpressionOutputs,[0 1])} = 1
        options.OutputFile (1,1) string = ""
        options.PrintTrace (1,1) logical = true
    end

    tf = false;
    if options.OutputFile == ""
        fid = 1;
    else
        fid = fopen(options.OutputFile,"a");
        fid_cleaner = onCleanup(@() fclose(fid));
    end

    if options.PrintTrace
        fprintfTrace = @(varargin) fprintf(varargin{:});
    else
        % no-op
        fprintfTrace = @(varargin) 1;
    end

    loc_label = locationLabel(function_name,line_number);
    fprintfTrace(fid,"[trace] %s%s", ...
        repmat('  ',1,length(dbstack)-1), ...
        loc_label);

    if options.Label ~= ""
        fprintfTrace(fid," %s",options.Label);
    end

    if options.Expression ~= ""
        if options.NumExpressionOutputs == 1
            v = evalin("caller",options.Expression);
            fprintfTrace(fid," %s = %s",options.Expression, ...
                codeTraceCompactDisp(v));
        else
            fprintfTrace(fid," %s",options.Expression);
            evalin("caller",options.Expression);
        end
    end

    fprintfTrace(fid,"\n");
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