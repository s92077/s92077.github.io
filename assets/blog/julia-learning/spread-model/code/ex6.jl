# This file was generated, do not modify it. # hide
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