function codeCallback(function_name,line_number,callback_fcn,expression)

%   Steve Eddins
%   Copyright 2022 The MathWorks, Inc.

    arguments
        function_name (1,1) string
        line_number   (1,1) double
        callback_fcn  (1,1) string
        expression    (1,1) string = ""
    end

    if expression ~= ""
        condition = "falseWithSideEffect(" + ...
            """" + callback_fcn + """" + "," + ...
            """" + expression + """" + ")" + ...
            " % " + codeCallbackSuffix;
    else
        condition = "falseWithSideEffect(" + ...
            """" + callback_fcn + """" + ")" + ...
            " % " + codeCallbackSuffix; 
    end

    dbstop("in",function_name,"at",string(line_number),"if",condition)    
end