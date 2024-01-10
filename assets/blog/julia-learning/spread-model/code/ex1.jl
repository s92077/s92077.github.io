# This file was generated, do not modify it. # hide
struct Model
    #' specified in json
    label::Vector
    initial::Vector
    transition::Dict{String, Any}
    #' initialized here
    typenum::Integer
    M::Matrix
    CDF::Dict{String, Any}
    rho::Number
    rv::Vector
    lv::Vector
    function Model(label::Vector,initial::Vector,transition::Dict{String, Any})
        #' initialization
        typenum = length(label)
        M = zeros(typenum, typenum)
        CDF = Dict()
        rho = 0
        rv = Vector{Vector{Number}}()
        lv = Vector{Vector{Number}}()
        for (i,l) in enumerate(label)
            M[:,i] = sum([ t["num"]*t["p"] for t in transition[l] ])
            CDF[l] = pushfirst!(cumsum([n["p"] for n in transition[l]]), 0);
        end
        #' M = V diag(D) W
        F = eigen(M)
        V = F.vectors
        D = F.values
        W = inv(V)
        rho = maximum([D[i] for i in eachindex(D) if abs(W[i, :]' * initial) > 1e-30])
        for i in eachindex(D)
            if abs(abs(D[i]) - rho) < 1e-7 * rho && abs(W[i, :]' * initial) > 1e-30
                V[:,i] = V[:,i] / sum(V[:,i])
                W[i,:] = W[i,:] / (W[i,:]' * V[:,i])
                push!(rv,V[:,i])
                push!(lv,W[i,:])
            end
        end
        return new(label,initial,transition,typenum,M,CDF,rho,rv,lv)
    end
    function Model(model)
        model = model isa AbstractString ? JSON.parse(open(model,"r")) : model
        return Model(model["label"], model["initial"], model["transition"])
    end
end