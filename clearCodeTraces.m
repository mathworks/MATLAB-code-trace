function clearCodeTraces
    ds = dbstatus;
    for k = 1:length(ds)
        if endsWith(ds(k).expression{1},codeTraceSuffix())
            dbclear("in",ds(k).name,"at",string(ds(k).line));
        end
    end
end
        