# This file was generated, do not modify it. # hide
let
    f(x::Int,y::Int) = x+y
    try
        println(f(1.0, 2.0))
    catch e
        println("Error: $e")
    end
    try
        println(f(1, 2))
    catch e
        println("Error: $e")
    end
end