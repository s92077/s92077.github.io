# This file was generated, do not modify it. # hide
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