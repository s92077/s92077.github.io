<!--This file was generated, do not modify it.-->
# Tutorial 2

In this tutorial, we will learn to plot figures.

## Markov-Cayley tree-shifts

Please go to [https://s92077.github.io/blog/julia-learning/](https://s92077.github.io/blog/julia-learning/) to download the code \"Markov-Cayley tree-shifts\" to proceed with this tutorial. The code basically computes the Entropy of Markov tree-shifts over Markov-Cayley trees [^1], and

### Problem

What can we say about the convergence of topological entropy using the above method?

## Spread model simulation

Please go to [https://s92077.github.io/blog/julia-learning/](https://s92077.github.io/blog/julia-learning/) to download the code \"spread model simulation\" and model files \"model 1-3\" to proceed with this tutorial. The code basically simulate the multi-type Galton-Watson processes, in the almost sure sense, involves finite patterns of reproduction.

### Model files `*.json`

In the model files, we need to specify the following fields:

- `label`: the set of types of individual
- `initial`: the number of ancestors of the population
- `transition`: reproduction patterns

It is not hard to see the syntax of the json files from the given examples.

### The `model` struct

The an object of the `model` struct stores parsed and preprocessed information from the `*.json` files. To learn more about the struct in Julia, check out the [documentation](https://docs.julialang.org/en/v1/base/base/#struct).

### `simulate`, `run_single_trial`, `produce_children`

- To run the code, we use `simulate` to simulate the growth of a population by specifying `gen_num`, the number of generations, and `trial_num`, the number of trials.
- In `simulate`, the function `run_single_trial` is called for `trial_num` times and return the empirical averages of the number of indiviuals as well as the theoretical growth on average. The `produce_children` determines
- In `run_single_trial`, iteratively and randomly produce childrens up to generation `gen_num`, and for each generation, `produce_children` is called to determine how parents reproduce its children.

### `plot_simulation_proportion`

The function `plot_simulation_proportion` plots the output of the function of `simulate`. To learn more about the plot function

The function uses the `Plots.jl` package to create the plots, which provides a unified collection of APIs of several different [backends](https://docs.juliaplots.org/stable/backends/). To learn more about it, one can check out the [official tutorial](https://docs.juliaplots.org/stable/tutorial/). To create a good-looking plot, one might also look into the [attributes](https://docs.juliaplots.org/stable/attributes/#attributes) of the plots.

### Parallelism

The code use the packages [Base.Threads](https://docs.julialang.org/en/v1/base/multi-threading/) and [LoopVectorization](https://juliasimd.github.io/LoopVectorization.jl/stable/) to speed up the computation. One can look into the [documentation](https://docs.julialang.org/en/v1/manual/parallel-computing/) to learn more about parallel computing.

### Problem

What if one wants to simulate a multi-type Galton-Watson process with infinitely many patterns of reproduction?

## Final notes

[^1]: One can find more details about Markov-Cayley trees and its entropy in [https://arxiv.org/abs/2110.08960](https://arxiv.org/abs/2110.08960).

