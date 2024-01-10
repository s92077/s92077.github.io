# This file was generated, do not modify it. # hide
"""
`function fibonacci_while(n::Int)`
The function computes `n`th term in the Fibonacci sequence.
"""
function fibonacci_while(n::Int)
    temp1 = 1
    temp2 = 1
    ans = 0
    while n > 0
        temp1 = temp2
        temp2 = ans
        ans = temp1 + temp2
        n -= 1
    end
    return ans
end