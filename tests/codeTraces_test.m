classdef codeTraces_test < matlab.unittest.TestCase

    methods (TestMethodTeardown)
        function cleanupCodeTraces(~)
            clearCodeTraces
        end
    end

    methods (Test)
        function test_TwoTraces(testcase)
            addCodeTrace("abcdefghijklmnopqrstuvwxyz",2)
            addCodeTrace("fib",3)

            T = codeTraces;
            T = sortrows(T,"FunctionName");

            act1 = T.FunctionName;
            exp1 = ["abcdefghijklmnopqrstuvwxyz" ; "fib"];
            act2 = T.LineNumber;
            exp2 = [2 ; 3];

            testcase.verifyEqual(act1,exp1);
            testcase.verifyEqual(act2,exp2);
        end
    end
end

% Copyright 2022 The MathWorks, Inc.