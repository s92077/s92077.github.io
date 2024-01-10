# This file was generated, do not modify it. # hide
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