# This file was generated, do not modify it. # hide
function fact(n::Integer)
    n >= 0 || error("n must be non-negative")
    n == 0 && return 1
    n * fact(n-1)
end