classdef clearCodeTraces_test < matlab.unittest.TestCase
    methods (TestMethodSetup)
        function clearAllBreakpoints(~)
            dbclear all
        end
    end

    methods (TestMethodTeardown)
        function clearAllBreakPoints(~)
            dbclear all
        end
    end

    methods (Test)
        function oneCodeTrace(testcase)
            addCodeTrace("fib",2);
            clearCodeTraces
            testcase.verifyEqual(height(codeTraces),0);
        end

        function breakpointsButNoCodeTraces(testcase)
            dbstop fib 2
            clearCodeTraces
            testcase.verifyEqual(height(codeTraces),0);
            testcase.verifyEqual(length(dbstatus),1);
        end

        function twoCodeTraces(testcase)
            addCodeTrace("fib",2);
            addCodeTrace("fib",3);
            clearCodeTraces
            testcase.verifyEqual(height(codeTraces),0);
        end
    end
end

% Copyright 2022 The MathWorks, Inc.