# This file was generated, do not modify it.

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

function produce_children(model::Model, parent_label::String, parent_num::Integer)
    pattern_idx = zeros(Integer, parent_num)
    @inbounds @fastmath for i in 1:parent_num
        pattern_idx[i] = Int(sum(rand() .> model.CDF[parent_label]))
    end
    arr = [x["num"] for x in model.transition[parent_label]]
    stat = zeros(Integer, model.typenum)
    @inbounds @fastmath for i in 1:parent_num
        stat += arr[pattern_idx[i]]
    end
    return stat
    #'return vmapreduce((x) -> model.transition[parent_label][x]["num"], +, pattern_idx)
    #'return sum([model.transition[parent_label][i]["num"] for i in pattern_idx])
end

function run_single_trial(model::Model, gen_num)
    is_dieout = false
    stat = zeros(model.typenum, gen_num); # stat[i,j] = number of children of type i in j-th generation
    stat[:,1] = model.initial;
    #' experiment by producing random children
    for gen in 2:gen_num
        for (desc_idx, desc_label) in enumerate(model.label)
            if stat[desc_idx, gen-1] > 0
                #' deciding children to generate according to pattern_idx
                stat[:,gen] += produce_children(model, desc_label, Int(stat[desc_idx, gen-1]))
            end
        end
        is_dieout = (sum(stat[:,gen]) == 0)
    end
    return (stat, is_dieout)
end

function simulate(model::Model, gen_num, trial_num)
    count = 0 # number of trials
    dieout_count = 0;  # number of survived trials
    stat = zeros(model.typenum, gen_num) # stat[i,j] = number of children of type i in j-th generation
    stat_ratio = zeros(model.typenum, gen_num)
    stat_total = zeros(1,gen_num);
    #' theoretical value
    theoretical = zeros(model.typenum, gen_num);
    theoretical[:, 1] = model.initial;
    for gen in 2:gen_num
        theoretical[:, gen] = model.M * theoretical[:,gen-1];
    end
    #' experirmental value
    println("taking average")
    rho_seq = model.rho.^(0:gen_num-1);
    Threads.@threads for trial in 1:trial_num
        (stat, is_dieout) = run_single_trial(model, gen_num)
        stat_ratio .+= stat ./ rho_seq' # composition of population
        stat_total .+= sum(stat, dims=1) # size of population
        dieout_count += Int(is_dieout)
        count += 1
        #' println("trial: $(count)/$(trial_num)")
    end
    stat_ratio /= count
    stat_total /= count
    return (theoretical, stat_ratio, stat_total, dieout_count, count)
end

function plot_simulation_proportion(model::Model, theoretical, stat_ratio, stat_total, dieout_count, count, test_type)
    gen_num = size(theoretical, 2)
    p = plot(0:gen_num-1, stat_ratio',
             markershape = hcat(repeat([:square], model.typenum)...),
             markersize = hcat(repeat([3], model.typenum)...),
             markercolor = [i for i in Iterators.take(palette(:tab10), model.typenum)]',
             linecolor = [i for i in Iterators.take(palette(:tab10), model.typenum)]',
             label = hcat(model.label...),  # always row-vectors...
             legend = :outertopright
    )
    plot!(0:gen_num-1, Real.(hcat(model.rv...) * hcat(model.lv...)' * model.initial * ones(1,size(stat_ratio,2)))',
             markershape = hcat(repeat([:none], model.typenum)...),
             linestyle = hcat(repeat([:dash], model.typenum)...),
             linecolor = [i for i in Iterators.take(palette(:tab10), model.typenum)]',
             label = hcat([latexstring("v_$(l) w_$(test_type)") for l in model.label]...),  # always row-vectors...
             legend = :outertopright
    )
    title!("Mean population proportion: $(count - dieout_count)/$(count) survived")
    xlabel!(latexstring("Generation \$n\$"))
    ylabel!("Proportion")
    xticks!(0:gen_num-1)
    return p
end

function plot_simulation_size(model::Model, theoretical, stat_ratio, stat_total, dieout_count, count, test_type)
    gen_num = size(theoretical, 2)
    p = plot(0:gen_num-1, stat_total', m = (:square, 3), yaxis=:log,
         linecolor = [i for i in Iterators.take(palette(:tab10), model.typenum)]',
         label=test_type,
         legend = :outertopright
    )
    plot!(0:gen_num-1, sum(hcat(model.rv...) * hcat(model.lv...)' * model.initial) .* model.rho.^(0:gen_num-1),
         linestyle = :dash, yaxis=:log,
         linecolor = [i for i in Iterators.take(palette(:tab10), model.typenum)]',
         label=latexstring("\$w_$(test_type) \\rho^n\$"),
         legend = :outertopright
    )
    xticks!(0:gen_num-1)
    yticks!([1,10,100,1000,10000,100000,1000000,10000000,1000000])
    title!("Population size: $(count - dieout_count)/$(count) survived")
    xlabel!(latexstring("Generation \$n\$"))
    ylabel!("Proportion")
    return p
end

