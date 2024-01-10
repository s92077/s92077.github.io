# This file was generated, do not modify it. # hide
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