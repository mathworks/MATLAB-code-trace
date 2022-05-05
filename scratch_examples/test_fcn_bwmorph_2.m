function test_fcn_bwmorph_2
    persistent count
    if isempty(count)
        count = 1;
    else
        count = count + 1;
    end
fprintf("Call count: %d\n",count)
end