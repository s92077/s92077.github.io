# This file was generated, do not modify it. # hide
function Base.:+(p::MPoint, s::Square)
    t = Square(s)
    s.corner.x += p.x
    s.corner.y += p.y
    return t
end