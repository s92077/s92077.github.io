# This file was generated, do not modify it. # hide
"""
`function fibonacci_recursion(n::Int)`
The function computes `n`th term in the Fibonacci sequence.
"""
function fibonacci_recursion(n::Int)
    if n <= 0
        return 0
    elseif n < 3
        return 1
    else
        return fibonacci_recursion(n-1) + fibonacci_recursion(n-2)
    end
end