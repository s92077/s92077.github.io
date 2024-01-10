# This file was generated, do not modify it. # hide
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