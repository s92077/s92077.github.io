# This file was generated, do not modify it. # hide
macro containervariable(container, element)
    return esc(:($(Symbol(container,element)) = $container[$element]))
end