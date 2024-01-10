# This file was generated, do not modify it. # hide
function Base.show(io::IO, square::Square)
    print(io, "Square anchored at $(square.corner) with side length $(square.side)")
end