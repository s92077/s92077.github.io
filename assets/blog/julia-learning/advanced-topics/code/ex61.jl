# This file was generated, do not modify it. # hide
let
    Base.convert(::Type{Point{T}}, x::Array{T, 1}) where {T<:Real} = Point(x...)
    convert(Point{Int64},[1,2])
end