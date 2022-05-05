function T = codeTraces
    ds = dbstatus;
    FunctionName = strings(0,1);
    LineNumber = zeros(0,1);
    for k = 1:length(ds)
        if endsWith(ds(k).expression{1},codeTraceSuffix())
            FunctionName(end+1,1) = ds(k).name;
            LineNumber(end+1,1) = ds(k).line;
        end
    end

    T = table(FunctionName,LineNumber);
end
        