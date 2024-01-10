# This file was generated, do not modify it. # hide
begin
    struct PointMultitype{T<:Real}
        x::T
        y::T
        PointMultitype{T}(x::T,y::T) where {T<:Real} = new{T}(x,y)
        PointMultitype(x::Real, y::Real) = Point(promote(x,y)...);
    end
    PointMultitype(1,2.5)
end