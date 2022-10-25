function addCodeTrace(function_name,line_number,options)
%addCodeTrace Creates a code trace for a given function and line number
%   addCodeTrace(function_name,line_number) creates a code trace for a given
%   function and line number. Whenever the specified line in the specified
%   function is executed, a trace message will be displayed in the Command
%   Window.
%
%   addCodeTrace(function_name,line_number,Name=Value) specifies additional
%   information to be printed, such as a label or the value of an
%   expression, as one or more name-value arguments.
%
%   Name-Value Arguments
%
%       Label      text
%                  Includes the specified label in the trace output.
%
%       Expression text
%                  Includes the specified expression and its value in the
%                  trace output. The expression is evaluated before the
%                  code line is executed, and it is evaluated in the
%                  context and workspace of the function containing the
%                  code line.
%
%   Code traces are implemented using conditional breakpoints, and calling
%   dbclear all will clear the code traces. To clear just the code traces,
%   without affecting other breakpoints, call clearCodeTraces.
%
%   See also clearCodeTraces, codeTraces.

%   Steve Eddins
%   Copyright 2022 The MathWorks, Inc.

    arguments
        function_name      (1,1) string
        line_number        (1,1) double
        options.Label      (1,1) string = ""
        options.Expression (1,1) string = ""
        options.NumExpressionOutputs (1,1) {mustBeNumeric, mustBeMember(options.NumExpressionOutputs,[0 1])} = 1
        options.OutputFile (1,1) string = ""
        options.PrintTrace (1,1) logical = true  
        options.ShowStackDepth (1,1) logical = false
    end

    condition = sprintf("codetrace.printTrace(""%s"",%d,%s) %s", ...
        function_name,line_number,optionsToNamedArguments(options),codeTraceSuffix);

    dbstop("in",function_name,"at",string(line_number),"if",condition)
end

function s = optionsToNamedArguments(options)
    names = string(fieldnames(options));
    s = strings(length(names),1);
    for k = 1:length(names)
        name = names(k);
        value = options.(name);
        if isstring(value) 
            s(k) = name + "=" + """" + value + """";
        elseif isnumeric(value) || islogical(value)
            s(k) = name + "=" + value;
        end
    end
    s = join(s,",");
end
