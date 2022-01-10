function out = falseWithSideEffect(fcn,expr)
    if nargin > 1
        feval(fcn,evalin("caller",expr));
    else
        feval(fcn);
    end
    out = false;
end