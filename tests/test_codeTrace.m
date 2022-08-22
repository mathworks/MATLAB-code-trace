classdef test_codeTrace < matlab.unittest.TestCase

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

            addCodeTrace("fib",2,"b-flat horn");
            cmd_win_out = evalc("fib(3)");
            testcase.verifyThat(cmd_win_out,ContainsSubstring("b-flat horn"));
        end

        function test_expression(testcase)
            import matlab.unittest.constraints.ContainsSubstring

            addCodeTrace("fib",2,"b-flat horn","n");
            cmd_win_out = evalc("fib(3)");
            testcase.verifyThat(cmd_win_out,ContainsSubstring("n ="));
        end

        function test_expressionNoLabel(testcase)
            import matlab.unittest.constraints.ContainsSubstring

            addCodeTrace("fib",2,"","n");
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
