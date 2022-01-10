classdef test_codeTrace < matlab.unittest.TestCase
    methods (TestMethodSetup)
        function        
    end
    tests = functiontests(localfunctions);
end

function test_locationOnly(testcase)
    codeTrace("fib",2);
    cmd_win_out = evalc("fib(3)");
end