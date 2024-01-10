# This file was generated, do not modify it.

import PlutoUI; # hide

struct IPoint
    x
    y
end

p = IPoint(3.0, 4.0)

p

ismutable(p)

mutable struct MPoint
    x
    y
end

mp = MPoint(1, 2)

mp.x = 3

struct Rectangle
    width::Real
    height::Real
    corner
end

function reset_point(p::MPoint)
    (p.x, p.y)=(0, 0)
    return nothing
end

let
    p=MPoint(1, 2)
    reset_point(p)
    println((p.x, p.y))
end

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

let
    square1 = Square(3, IPoint(0, 0))
    square2 = Square(square1)
    (square1 == square2), (square1 === square2)
end

let
    square1 = Square(3, IPoint(0, 0))
    square2 = square1
    (square1 == square2), (square1 === square2)
end

function Base.show(io::IO, p::MPoint)
    print(io, "($(p.x), $(p.y))")
end

function Base.show(io::IO, p::IPoint)
    print(io, "($(p.x), $(p.y))")
end

function Base.show(io::IO, square::Square)
    print(io, "Square anchored at $(square.corner) with side length $(square.side)")
end

Square(2, IPoint(0, 0))

Square(2, MPoint(0, 0))

function Base.:+(p::MPoint, s::Square)
    t = Square(s)
    s.corner.x += p.x
    s.corner.y += p.y
    return t
end

distance(p) = sqrt(p.x^2 + p.y^2)

distance(p, q) = sqrt((p.x - q.x)^2 + (p.y - q.y)^2)

let
    p=MPoint(1, 2)
    println(distance(p))
    println((p.x, p.y))
end

let
    p=MPoint(1, 2)
    println(distance(p), distance(p, p))
end

MPoint(3, 4) + Square(3, MPoint(1, 2))

function histogram(s)
    d = Dict()
    for c in s
        if c ∉ keys(d)
            d[c] = 1
        else
            d[c] += 1
        end
    end
    d
end

histogram(("spam", "egg", "spam", "spam", "bacon", "spam"))

histogram(["spam", "egg", "spam", "spam", "bacon", "spam"])

const suit_names = ["♣", "♦", "♥", "♠"]

const rank_names = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]

struct Card
    suit :: Int64
    rank :: Int64
    #' constructor
    function Card(suit::Int64, rank::Int64)
        @assert(1 ≤ suit ≤ 4, "suit is not between 1 and 4")
        @assert(1 ≤ rank ≤ 13, "rank is not between 1 and 13")
        new(suit, rank)
    end
    #' methods overloading
    function Base.show(io::IO, card::Card)
        print(io, rank_names[card.rank], suit_names[card.suit])
    end
    #' operator overloading
    function Base.:<(c1::Card, c2::Card)
        (c1.suit, c1.rank) < (c2.suit, c2.rank)
    end
end

abstract type CardSet end

struct Hand <: CardSet
    cards :: Array{Card, 1}
    label :: String
    function Hand(label::String="")
        Hand(Card[], label)
    end
end

begin
    function Base.show(io::IO, cs::CardSet)
        for card in cs.cards
            print(io, card, " ")
        end
    end

    function Base.pop!(cs::CardSet)
        pop!(cs.cards)
    end

    function Base.push!(cs::CardSet, card::Card)
        push!(cs.cards, card)
        nothing
    end
end

struct Deck <: CardSet
    cards :: Array{Card, 1}
    #' constructor
    function Deck()
        deck = new(Card[])
        for suit in 1:4
            for rank in 1:13
                push!(deck.cards, Card(suit, rank))
            end
        end
        deck
    end
end

Deck()

deck = Deck()

repr(zip("abc", [1 2 3]))

dump(zip("abc", [1 2 3]))

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

let
    x::Int8 = round(Int, 2.0)
    typeof(x)
end

x = (a=1, b=1+1)

@isdefined x

x.a

let
    data = "This here's the wattle,\nthe emblem of our land.\n"
    open("output.txt", "w") do fout
        write(fout, data)
    end
end

let
    data = "This here's the wattle,\nthe emblem of our land.\n"
    f = fout -> begin
        write(fout, data)
    end
    open(f, "output.txt", "w")
end

"The way it works is the following:"

1 > 0 ? "It is true!" : "It is false!"

function fact(n::Integer)
    n >= 0 || error("n must be non-negative")
    n == 0 && return 1
    n * fact(n-1)
end

fact(4)

struct Point{T<:Real}
    x::T
    y::T
end

isa(8, Union{Real, String})

isa("s", Union{Int64, String})

isintpoint(p::Point{T}) where {T} = (T === Int64)

isintpoint(Point(1, 2))

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

Point(1,2)         # implicit T

Point{Int64}(1, 2) # explicit T

Point(1,2.5)       # implicit T

begin
    struct PointMultitype{T<:Real}
        x::T
        y::T
        PointMultitype{T}(x::T,y::T) where {T<:Real} = new{T}(x,y)
        PointMultitype(x::Real, y::Real) = Point(promote(x,y)...);
    end
    PointMultitype(1,2.5)
end

let
    Base.convert(::Type{Point{T}}, x::Array{T, 1}) where {T<:Real} = Point(x...)
    convert(Point{Int64},[1,2])
end

promote(1, 2.5, 3)

promote_rule(::Type{Float64}, ::Type{Int32}) = Float64

begin
    ex = Meta.parse("1 + 2") # expression 1
    ex = quote # expression 2
        1 + 2
    end
end

typeof(ex)

dump(ex)

eval(ex)

macro containervariable(container, element)
    return esc(:($(Symbol(container,element)) = $container[$element]))
end

@time sum([1 2 3 4])

