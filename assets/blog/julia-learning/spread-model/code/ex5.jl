# This file was generated, do not modify it. # hide
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