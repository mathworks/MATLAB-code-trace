function out = fib(n)
if n == 0
    out = 0;
elseif n == 1
    out = 1;
else
    out = fib(n-1) + fib(n-2);
end