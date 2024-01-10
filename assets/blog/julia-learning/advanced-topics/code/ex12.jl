# This file was generated, do not modify it. # hide
mutable struct Square
    side
    corner
    #' customized constructor (override the default constructor)
    function Square(side, corner = IPoint(0, 0))
        @assert(side >= 0, "Side length is negative!")
        return new(side, corner)
    end
    #' copy constructor
    function Square(square::Square)
        new(square.side, square.corner)
    end
end