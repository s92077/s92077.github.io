# This file was generated, do not modify it. # hide
struct Hand <: CardSet
    cards :: Array{Card, 1}
    label :: String
    function Hand(label::String="")
        Hand(Card[], label)
    end
end