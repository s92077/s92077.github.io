<!--This file was generated, do not modify it.-->
# Julia 101
\toc
**Note:** The author is also a newbie to Julia, and to me this document is meant to be a note of what I have learned from the literatures. Were there some misconceptions or unclearness, please let me know. Comments and suggestions are also welcome.

## About Julia

### What is Julia?

- Julia is a programming language.
- Its origin dates back to 2009, when Jeff Bezanson, Stefan Karpinski, Viral B. Shah, and Alan Edelman decide to set their hands to a new languages that is both high-level and fast. In 2012, a website is created with a blog post to explain the mission of the language, and it is the moment that the language made its debut.
- At the time the author is writing this note (May 2023), the stable release number of Julia is 1.9.0, and its syntax is now considered stable.

### Why Julia?

According to its [officiel website](https://julialang.org/), Julia boasts the following advantages: fast, dynamic, reproducible, composable, general, open source. What these features mean to me is that I don't need to pay MATLAB to enjoy a similar syntax, and it is reasonably fast yet concise that I don't need to resort to C/C++ to pursue performance. To me, the more I code with the language, the better I realize how much these merits benefits the scientific computing.

### How do I learn Julia?

The [officiel website](https://julialang.org/) includes a great abundance of resources, ranging from the download link of the compiler, the official documentation (with detailed yet comprehensible explanations) to learning materials. I closely follow one of the texts, and if I found something unfamiliar, I will look it up in the documentation or simply google it.

Here I include some of the useful resources:

- If you are familiar with other programming languages, see [https://docs.julialang.org/en/v1.9.0/manual/noteworthy-differences/](https://docs.julialang.org/en/v1.9.0/manual/noteworthy-differences/) for a comparison and [https://cheatsheets.quantecon.org/](https://cheatsheets.quantecon.org/) for a cheat sheet if you are familiar with MATLAB or python.
- A quick cheatsheet for Julia syntax and its abilities is at [https://juliadocs.github.io/Julia-Cheat-Sheet/](https://juliadocs.github.io/Julia-Cheat-Sheet/) and a similar cheatsheet for the Plots package is at [https://github.com/sswatson/cheatsheets/blob/master/plotsjl-cheatsheet.pdf](https://github.com/sswatson/cheatsheets/blob/master/plotsjl-cheatsheet.pdf)

## Installation

1. Go to Julia's website <https://julialang.org> and download and install the latest stable release of Julia.
> * For __*Windows*__ users, download the installer and click on the installer to install, or download the portable version and extract files.
> * For __*Linux*__ or __*Mac*__ users, download the corresponding package and extract/install it.
2. Run Julia REPL [^1] by executing `bin/julia`!

## Use Pluto.jl

[Pluto.jl](https://github.com/fonsp/Pluto.jl) is an lightweight interactive notebook for Julia. It is helpful for the users to conduct experiments, and it comes in handy when you want to export your computation as html to create a live demo.

### Installation

To install Pluto [^2], type `]` to enter package manager `Pkg` in Julia:

```julia-repl
julia> ]
```

Enter `add Pluto` to add the package:

```julia-repl
(@v1.9) pkg> add Pluto
```

To exit package manager, press `Ctrl+C` or `Backspace`

```julia-repl
(@v1.9) pkg> ^C
```

### Start Pluto

To use Pluto, we need to first import it

```julia-repl
julia> import Pluto
julia> Pluto.run()
```

It will automatically open a webpage of Pluto notebook. If not, you may copy the link printed on screen (something like `http://localhost:1234/?secret=xxxxxxxx`) to the browser.

# Final notes

[^1]: See for example [here](https://guides.libraries.uc.edu/julia) for an explanation.
[^2]: Check also [here](https://plutojl.org/docs/install/) if you face any difficulties.

