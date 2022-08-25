classdef addCodeTrace_test < matlab.unittest.TestCase

    methods (TestMethodTeardown)
        function cleanupCodeTraces(~)
            clearCodeTraces
        end
    end

    methods (Test)
        function test_locationOnly(testcase)
            import matlab.unittest.constraints.ContainsSubstring

            addCodeTrace("fib",2);
            cmd_win_out = evalc("fib(3)");
            testcase.verifyThat(cmd_win_out,ContainsSubstring("fib:2"));
        end

        function test_label(testcase)
            import matlab.unittest.constraints.ContainsSubstring

            addCodeTrace("fib",2,Label = "b-flat horn");
            cmd_win_out = evalc("fib(3)");
            testcase.verifyThat(cmd_win_out,ContainsSubstring("b-flat horn"));
        end

        function test_expression(testcase)
            import matlab.unittest.constraints.ContainsSubstring

            addCodeTrace("fib",2,Label = "b-flat horn",Expression = "n");
            cmd_win_out = evalc("fib(3)");
            testcase.verifyThat(cmd_win_out,ContainsSubstring("n ="));
        end

        function test_expressionNoLabel(testcase)
            import matlab.unittest.constraints.ContainsSubstring

            addCodeTrace("fib",2,Expression = "n");
            cmd_win_out = evalc("fib(3)");
            testcase.verifyThat(cmd_win_out,ContainsSubstring("n ="));
        end 

        function test_longFunctionName(testcase)
            import matlab.unittest.constraints.ContainsSubstring

            addCodeTrace("abcdefghijklmnopqrstuvwxyz",2);
            cmd_win_out = evalc("abcdefghijklmnopqrstuvwxyz(3)");
            testcase.verifyThat(cmd_win_out,ContainsSubstring("..."));
        end
    end
end

% Copyright 2022 The MathWorks, Inc.
