# This file was generated, do not modify it. # hide
let
    struct Polynomial{R}
        coeff::Vector{R}
    end
    function (p::Polynomial)(x)
        val = p.coeff[end]
        for coeff in p.coeff[end-1:-1:1]
            val = val * x + coeff
        end
        val
    end
    p = Polynomial([1,10,100])
    p(3)
end