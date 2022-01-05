function clearCodeTraces
    ds = dbstatus;
    for k = 1:length(ds)
        if endsWith(ds(k).expression{1},"% TRACE_CODE")
            dbclear("in",ds(k).name,"at",string(ds(k).line));
        end
    end
end
        