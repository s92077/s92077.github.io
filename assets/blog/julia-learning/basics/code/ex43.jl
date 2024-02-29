# This file was generated, do not modify it. # hide
"""
`function fibonacci_for(n::Int)`
The function computes `n`th term in the Fibonacci sequence.
"""
function fibonacci_for(n::Int)
    temp1 = 1
    temp2 = 1
    ans = 0
    for i in 1:n
        temp1 = temp2
        temp2 = ans
        ans = temp1 + temp2
    end
    return ans
end