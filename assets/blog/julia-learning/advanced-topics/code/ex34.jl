# This file was generated, do not modify it. # hide
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