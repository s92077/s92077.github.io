# This file was generated, do not modify it. # hide
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