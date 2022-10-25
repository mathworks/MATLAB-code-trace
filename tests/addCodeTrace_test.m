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

        function test_expressionNoOutput(testcase)
            import matlab.unittest.constraints.ContainsSubstring

            addCodeTrace("fib",2,Expression="disp(""""foobar"""")",...
                NumExpressionOutputs=0);
            cmd_win_out = evalc("fib(3)");
            testcase.verifyThat(cmd_win_out,ContainsSubstring("foobar"));
        end

        function test_outputFile(testcase)
            import matlab.unittest.fixtures.TemporaryFolderFixture
            import matlab.unittest.constraints.ContainsSubstring

            fixture = testcase.applyFixture(TemporaryFolderFixture);
            output_file = tempname(fixture.Folder);

            addCodeTrace("fib",2,Label="foobar",OutputFile=output_file);
            fib(3);
            file_contents = string(fileread(output_file));

            testcase.verifyThat(file_contents,ContainsSubstring("foobar"));
        end

        function test_printTraceOption(testcase)
            import matlab.unittest.constraints.ContainsSubstring

            addCodeTrace("fib",2,Label="foobar",DisplayTrace=false);
            cmd_win_out = evalc("fib(3)");

            testcase.verifyThat(cmd_win_out, ~ContainsSubstring("foobar"));
        end

        function test_showStackDepth(testcase)
            addCodeTrace("fib",2);
            cmd_win_out = string(evalc("fib(3)"));
            lines = split(cmd_win_out,newline);
            testcase.verifyEqual(strlength(lines(1)),strlength(lines(2)));

            clearCodeTraces
            addCodeTrace("fib",2,ShowStackDepth=true);
            cmd_win_out = string(evalc("fib(3)"));
            lines = split(cmd_win_out,newline);
            testcase.verifyEqual(strlength(lines(1))+2,strlength(lines(2)));
        end
    end
end

% Copyright 2022 The MathWorks, Inc.
