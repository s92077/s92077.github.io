<!--This file was generated, do not modify it.-->
````julia:ex1
using PlutoUI # hide
````

# Tutorial 1

In this tutorial, we will learn to print a Pascal's triangle using some basic operations as well as some simple markdown syntax and UI components.

## Prerequisite

### Markdown

In addition to [HTML](https://en.wikipedia.org/wiki/HTML), Pluto Notebook also supports [Markdown](https://en.wikipedia.org/wiki/Markdown) language, a language that is used to create formatted text. Its syntax is introduced in the [documentation](https://docs.julialang.org/en/v1.9.0/stdlib/Markdown/). This languages especially comes in handy for taking notes.

One of the useful commands is to print the value of a variable in markdown. See the following example.

````julia:ex2
m = 10
````

To print the value of `m`, type `$(m)` in the markdown string.

With the support of HTML, one can easily create basic UI components.

````julia:ex3
HTML("<input type=range min=1 max=100>");
````

One can also embed the code in markdown and "bind" the value to a value to a variable, say `a`:

```julia
@bind a html"<input type=range min=1 max=100 value=3>"
```

Drag the slider to see how the value changes.

### PlutoUI
PlutoUI is a package make `html"<input>"` a bit more native in Julia. To use the package we need to first load the package [^1] :
```julia
@bind x Slider(1:20)
```

Again, drag the slider to see how the value changes.

## Problem

Print a Pascal's triangle of level `n`, where `n` is a number determined by the user. You may try to use UI components in PlutoUI to take inputs.

```julia
@bind n Slider(1:10)
```

````julia:ex4
n = 10; # hide
````

````julia:ex5
let
    str = ""
    num = ones(Int64, n+1)
    num_p = ones(Int64, n+1)
    for i in 1:n
        if i == 1
            str *= "1\n"
        else
            str *= "1 "
            for j in 2:i-1
                num[j] = num_p[j-1] + num_p[j]
                str = str * string(num[j]) * " "
            end
            str *= "1\n"
        end
        num_p .= num
    end
    Text(str)
end
````

## Final notes

[^1]: In Pluto, one need not to manually add packages. Instead, Pluto automatically handles it when you import the packages.

