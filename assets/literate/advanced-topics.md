<!--This file was generated, do not modify it.-->
# Advanced Topics

````julia:ex1
import PlutoUI; # hide
````

**Note:** The materials of the this introduction are borrowed from [^1]. Hence, it is highly recommended to read the Chapter 15 to Chapter 18 in [^1].
\toc
## Structs and objects

At this point you know how to use functions to organize code and built-in types to organize data. The next step is to learn how to build your own types to organize both code and data. This is a big topic; it will take a few chapters to get there.

### Composite types

We have used many of Julia’s built-in types; now we are going to define a new type. As an example, we will create a type called Point that represents a point in two-dimensional space.

A programmer-defined composite type is also called a struct. For example, the `struct` definition for a point looks like this:

````julia:ex2
struct IPoint
    x
    y
end
````

A struct is like a factory for creating objects. To create a point, you call Point as if it were a function having as arguments the values of the fields. When Point is used as a function, it is called a constructor.

````julia:ex3
p = IPoint(3.0, 4.0)
````

To access the attributes of `p`, we use the `.` operator:

````julia:ex4
p
````

### Structs are immutable

As we can see from below, a Point is an immutable type

````julia:ex5
ismutable(p)
````

!!! note
    Here are some advantages for a struct to be immutable:
    - It can be more efficient.
    - It is not possible to violate the invariants provided by the type’s constructors.
    - Code using immutable objects can be easier to reason about.

To define a mutable struct, we use the keyword `mutable struct` in place of `struct`:

````julia:ex6
mutable struct MPoint
    x
    y
end
````

````julia:ex7
mp = MPoint(1, 2)
````

````julia:ex8
mp.x = 3
````

````julia:ex9
struct Rectangle
    width::Real
    height::Real
    corner
end
````

## Structs and functions

### Pure functions and modifiers

A *pure function* is a function without side effects (e.g. modifying the arguments) after execution and the returned value only on the input passed to the function.

Here is an example of a pure function:

A *modifier function*, on the other hand, modifies the the its input and returns `nothing`. The name of a modifier function, in Julia, is conventially ends with a exclamation mark `!`. Learn more about this from the [documentation](https://docs.julialang.org/en/v1.9/manual/variables/#Stylistic-Conventions).

Here is an example of a modifier:

````julia:ex10
function reset_point(p::MPoint)
    (p.x, p.y)=(0, 0)
    return nothing
end
````

````julia:ex11
let
    p=MPoint(1, 2)
    reset_point(p)
    println((p.x, p.y))
end
````

## Function overloading

The idea of function overloading is that you can define two functions taking different arguments with the same name. For example, we can difine a distance function calculating two different points:

### Constructors

A *constructor* is a special function that is called to create an object. The default constructor methods of `Rectangle` have the following signatures:
```julia
Rectange(width::Real, height::Real, corner)
```
They simply initialize the attribute of the object. We can also define our own *inner constructor*, by using `new` in a these constructors to generate a new object. An example is given as follows:

````julia:ex12
mutable struct Square
    side
    corner
    #' customized constructor (override the default constructor)
    function Square(side, corner = IPoint(0, 0))
        @assert(side >= 0, "Side length is negative!")
        return new(side, corner)
    end
    #' copy constructor
    function Square(square::Square)
        new(square.side, square.corner)
    end
end
````

We can compare the following results:

````julia:ex13
let
    square1 = Square(3, IPoint(0, 0))
    square2 = Square(square1)
    (square1 == square2), (square1 === square2)
end
````

````julia:ex14
let
    square1 = Square(3, IPoint(0, 0))
    square2 = square1
    (square1 == square2), (square1 === square2)
end
````

!!! warning
    The default constructor is not available if any inner constructor is defined. You have to write explicitly all the inner constructors you need.

In the code above, we have a constructor taking an argument of type `Square`. It is useful when we decide to make a generate a new copy of the object later on.

### `show`

We now override the `show` function to generate an string expression for type `Square`

````julia:ex15
function Base.show(io::IO, p::MPoint)
    print(io, "($(p.x), $(p.y))")
end
````

````julia:ex16
function Base.show(io::IO, p::IPoint)
    print(io, "($(p.x), $(p.y))")
end
````

````julia:ex17
function Base.show(io::IO, square::Square)
    print(io, "Square anchored at $(square.corner) with side length $(square.side)")
end
````

````julia:ex18
Square(2, IPoint(0, 0))
````

````julia:ex19
Square(2, MPoint(0, 0))
````

### Operator overloading and multiple dispatch

Some operators in Julia, like other functions, can be overloaded. These operators are in `Base` [module](#62ce4035-b68a-46a0-a77c-57ee66ea3645), and operator `op` in the module should referred to as `Base:op` or even `Base:(op)` (e.g. mandatory for `==`)

````julia:ex20
function Base.:+(p::MPoint, s::Square)
    t = Square(s)
    s.corner.x += p.x
    s.corner.y += p.y
    return t
end
````

````julia:ex21
distance(p) = sqrt(p.x^2 + p.y^2)
````

````julia:ex22
distance(p, q) = sqrt((p.x - q.x)^2 + (p.y - q.y)^2)
````

````julia:ex23
let
    p=MPoint(1, 2)
    println(distance(p))
    println((p.x, p.y))
end
````

````julia:ex24
let
    p=MPoint(1, 2)
    println(distance(p), distance(p, p))
end
````

````julia:ex25
MPoint(3, 4) + Square(3, MPoint(1, 2))
````

The choice of which method to execute when a function is applied is called *dispatch*.

### Generic programming

Many of the functions we wrote for strings also work for other sequence types. For example, in Dictionary as a Collection of Counters we used histogram to count the number of times each letter appears in a word.

````julia:ex26
function histogram(s)
    d = Dict()
    for c in s
        if c ∉ keys(d)
            d[c] = 1
        else
            d[c] += 1
        end
    end
    d
end
````

````julia:ex27
histogram(("spam", "egg", "spam", "spam", "bacon", "spam"))
````

````julia:ex28
histogram(["spam", "egg", "spam", "spam", "bacon", "spam"])
````

Functions that work with several types are called *polymorphic*. Polymorphism can facilitate code reuse.

## Abstract types and subtyping

In the following, we use the same example as [^1] to demonstrate abstract type and subtyping.

Here is our setup

````julia:ex29
const suit_names = ["♣", "♦", "♥", "♠"]
````

````julia:ex30
const rank_names = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
````

````julia:ex31
struct Card
    suit :: Int64
    rank :: Int64
    #' constructor
    function Card(suit::Int64, rank::Int64)
        @assert(1 ≤ suit ≤ 4, "suit is not between 1 and 4")
        @assert(1 ≤ rank ≤ 13, "rank is not between 1 and 13")
        new(suit, rank)
    end
    #' methods overloading
    function Base.show(io::IO, card::Card)
        print(io, rank_names[card.rank], suit_names[card.suit])
    end
    #' operator overloading
    function Base.:<(c1::Card, c2::Card)
        (c1.suit, c1.rank) < (c2.suit, c2.rank)
    end
end
````

We now define a virtual type `CardSet`, to which both a deck and a hand belong to:

````julia:ex32
abstract type CardSet end
````

````julia:ex33
struct Hand <: CardSet
    cards :: Array{Card, 1}
    label :: String
    function Hand(label::String="")
        Hand(Card[], label)
    end
end
````

We can defining generic functions on CardSet, which apply to both decks and hands:

````julia:ex34
begin
    function Base.show(io::IO, cs::CardSet)
        for card in cs.cards
            print(io, card, " ")
        end
    end

    function Base.pop!(cs::CardSet)
        pop!(cs.cards)
    end

    function Base.push!(cs::CardSet, card::Card)
        push!(cs.cards, card)
        nothing
    end
end
````

````julia:ex35
struct Deck <: CardSet
    cards :: Array{Card, 1}
    #' constructor
    function Deck()
        deck = new(Card[])
        for suit in 1:4
            for rank in 1:13
                push!(deck.cards, Card(suit, rank))
            end
        end
        deck
    end
end
````

````julia:ex36
Deck()
````

````julia:ex37
deck = Deck()
````

## Others

### `repr`

Create a string from any value using the show function. You should not add methods to repr; define a show method instead.

````julia:ex38
repr(zip("abc", [1 2 3]))
````

### `dump`

Show every part of the representation of a value.

````julia:ex39
dump(zip("abc", [1 2 3]))
````

### `::` operator

We may use `a :: T` to assert if a variable `a` is of type `T`:

````julia:ex40
let
    f(x::Int,y::Int) = x+y
    try
        println(f(1.0, 2.0))
    catch e
        println("Error: $e")
    end
    try
        println(f(1, 2))
    catch e
        println("Error: $e")
    end
end
````

It may also help us to perform assignment:

````julia:ex41
let
    x::Int8 = round(Int, 2.0)
    typeof(x)
end
````

### Macro call '@'

A macro maps a tuple of arguments, expressed as space-separated expressions or a function-call-like argument list, to a returned expression. A macro named `macro_name` can be called by `@macro_name`.

### `:` operator

`:expr` quote an expression `expr`, returning the abstract syntax tree (AST) of expr. The AST may be of type `Expr`, `Symbol`, or a literal value. The syntax :identifier evaluates to a `Symbol`.

### Named tuple

You can name the components of a tuple, creating a named tuple:

````julia:ex42
x = (a=1, b=1+1)
````

````julia:ex43
@isdefined x
````

````julia:ex44
x.a
````

### `do` blocks

In Reading and Writing we had to close the file after when where done writing. This can be done automatically using a do block:

````julia:ex45
let
    data = "This here's the wattle,\nthe emblem of our land.\n"
    open("output.txt", "w") do fout
        write(fout, data)
    end
end
````

In this example fout is the file stream used for output. This is functionally equivalent to

````julia:ex46
let
    data = "This here's the wattle,\nthe emblem of our land.\n"
    f = fout -> begin
        write(fout, data)
    end
    open(f, "output.txt", "w")
end
````

````julia:ex47
"The way it works is the following:"
````

```julia
function open(f::Function, args...)
    io = open(args...)
    try
        f(io)
    finally
        close(io)
    end
end
```

Check out the [documentation](https://docs.julialang.org/en/v1.9/base/io-network/#Base.open]).

### Ternary operator `condition ? true : false`

The is an alternative to an `if-elseif` statement:

````julia:ex48
1 > 0 ? "It is true!" : "It is false!"
````

### Short-Circuit Evaluation

The operators `&&` and `||` do a short-circuit evaluation: a next argument is only evaluated when it is needed to determine the final value.

````julia:ex49
function fact(n::Integer)
    n >= 0 || error("n must be non-negative")
    n == 0 && return 1
    n * fact(n-1)
end
````

````julia:ex50
fact(4)
````

### Primitive, composite, abstract and  parametric types

[Primitive types](https://docs.julialang.org/en/v1.9/manual/types/#Primitive-Types) are a concrete types whose data consists of plain old bits, and their identity depend only on bits.

[Composite type](https://docs.julialang.org/en/v1.9/manual/types/#Composite-Types) are called records, structs, or objects in various languages. A composite type is a collection of named fields, an instance of which can be treated as a single value. In many languages, composite types are the only kind of user-definable type, and they are by far the most commonly used user-defined type in Julia as well.

Primitive/composite/abstract types can have parameters. See the following example:

````julia:ex51
struct Point{T<:Real}
    x::T
    y::T
end
````

### Type unions

````julia:ex52
isa(8, Union{Real, String})
````

````julia:ex53
isa("s", Union{Int64, String})
````

Parametric Methods

Method definitions can also have type parameters qualifying their signature:

````julia:ex54
isintpoint(p::Point{T}) where {T} = (T === Int64)
````

````julia:ex55
isintpoint(Point(1, 2))
````

### Function-like Objects

Any arbitrary Julia object can be made “callable”. Such “callable” objects are sometimes called functors.

````julia:ex56
let
    struct Polynomial{R}
        coeff::Vector{R}
    end
    function (p::Polynomial)(x)
        val = p.coeff[end]
        for coeff in p.coeff[end-1:-1:1]
            val = val * x + coeff
        end
        val
    end
    p = Polynomial([1,10,100])
    p(3)
end
````

### Constructors

Parametric types can be explicitly or implicitly constructed:

````julia:ex57
Point(1,2)         # implicit T
````

````julia:ex58
Point{Int64}(1, 2) # explicit T
````

````julia:ex59
Point(1,2.5)       # implicit T
````

To address the above ambiguous issue, we can use [`promote`]() function:

````julia:ex60
begin
    struct PointMultitype{T<:Real}
        x::T
        y::T
        PointMultitype{T}(x::T,y::T) where {T<:Real} = new{T}(x,y)
        PointMultitype(x::Real, y::Real) = Point(promote(x,y)...);
    end
    PointMultitype(1,2.5)
end
````

### Conversion and Promotion

Julia has a system for promoting arguments to a common type. This is not done automatically but can be easily extended.

We can add our own convert methods:

````julia:ex61
let
    Base.convert(::Type{Point{T}}, x::Array{T, 1}) where {T<:Real} = Point(x...)
    convert(Point{Int64},[1,2])
end
````

On the other hand, promotion is the conversion of values of mixed types to a single common type:

````julia:ex62
promote(1, 2.5, 3)
````

Methods for the promote function are normally not directly defined, but the auxiliary function promote_rule is used to specify the rules for promotion:

````julia:ex63
promote_rule(::Type{Float64}, ::Type{Int32}) = Float64
````

### Metaprogramming

Julia code can be represented as a data structure of the language itself. This allows a program to transform and generate its own code.

Every Julia program starts as a string, which we can parse into an object called an `expression`:

````julia:ex64
begin
    ex = Meta.parse("1 + 2") # expression 1
    ex = quote # expression 2
        1 + 2
    end
end
````

````julia:ex65
typeof(ex)
````

````julia:ex66
dump(ex)
````

We can use `eval` to evaluate expressions:

````julia:ex67
eval(ex)
````

### Macros

`Macros` can include generated code in a program. A macro maps a tuple of Expr objects directly to a compiled expression:

````julia:ex68
macro containervariable(container, element)
    return esc(:($(Symbol(container,element)) = $container[$element]))
end
````

The macro call `@containervariable letters 1` is replaced by `:(letters1 = letters[1])`.

### Measuring Performance

````julia:ex69
@time sum([1 2 3 4])
````

### Interactive Utilities
```julia
@code_lowered sum([1 2 3 4])
```
```julia-repl
CodeInfo(
1 ─      nothing
│   %2 = Base.:(:)
│   %3 = Core.NamedTuple()
│   %4 = Base.pairs(%3)
│   %5 = Base.:(var"#sum#807")(%2, %4, #self#, a)
└──      return %5
)
```
```julia
@code_typed sum([1 2 3 4])
```
```julia-repl
CodeInfo(
1 ─ %1 = Base.identity::typeof(identity)
│   %2 = Base.add_sum::typeof(Base.add_sum)
│   %3 = invoke Base._mapreduce(%1::typeof(identity), %2::typeof(Base.add_sum), $(QuoteNode(IndexLinear()))::IndexLinear, a::Matrix{Int64})::Int64
└──      return %3
) => Int64
```
```julia
@code_llvm sum([1 2 3 4])
```
```julia-repl
;  @ reducedim.jl:994 within `sum`
; Function Attrs: uwtable
define i64 @julia_sum_338({}* noundef nonnull align 16 dereferenceable(40) %0) #0 {
top:
; ┌ @ reducedim.jl:994 within `#sum#807`
; │┌ @ reducedim.jl:998 within `_sum`
; ││┌ @ reducedim.jl:998 within `#_sum#809`
; │││┌ @ reducedim.jl:999 within `_sum`
; ││││┌ @ reducedim.jl:999 within `#_sum#810`
; │││││┌ @ reducedim.jl:357 within `mapreduce`
; ││││││┌ @ reducedim.jl:357 within `#mapreduce#800`
; │││││││┌ @ reducedim.jl:365 within `_mapreduce_dim`
          %1 = call i64 @j__mapreduce_340({}* nonnull %0) #0
; └└└└└└└└
  ret i64 %1
}
```
```julia
@code_native sum([1 2 3 4])
```
```julia-repl
        .text
        .file   "sum"
        .globl  julia_sum_368                   # -- Begin function julia_sum_368
        .p2align        4, 0x90
        .type   julia_sum_368,@function
julia_sum_368:                          # @julia_sum_368
; ┌ @ reducedim.jl:994 within `sum`
        .cfi_startproc
# %bb.0:                                # %top
        pushq   %rbp
        .cfi_def_cfa_offset 16
        .cfi_offset %rbp, -16
        movq    %rsp, %rbp
        .cfi_def_cfa_register %rbp
        subq    $32, %rsp
; │┌ @ reducedim.jl:994 within `#sum#807`
; ││┌ @ reducedim.jl:998 within `_sum`
; │││┌ @ reducedim.jl:998 within `#_sum#809`
; ││││┌ @ reducedim.jl:999 within `_sum`
; │││││┌ @ reducedim.jl:999 within `#_sum#810`
; ││││││┌ @ reducedim.jl:357 within `mapreduce`
; │││││││┌ @ reducedim.jl:357 within `#mapreduce#800`
; ││││││││┌ @ reducedim.jl:365 within `_mapreduce_dim`
        movabsq $j__mapreduce_370, %rax
        callq   *%rax
; │└└└└└└└└
        addq    $32, %rsp
        popq    %rbp
        retq
.Lfunc_end0:
        .size   julia_sum_368, .Lfunc_end0-julia_sum_368
        .cfi_endproc
; └
                                        # -- End function
        .section        ".note.GNU-stack","",@progbits
```
Compare these with @which
```julia
@which sum([1 2 3 4])
```
```julia-repl
sum(a::AbstractArray; dims, kw...)
     @ Base reducedim.jl:994
```
### `@debug` macro

```julia
let
    x=5
    y=-5
    while x > 0 && y < 0
        x -= 1
        y += 1
        @debug "variables" x y
        @debug "condition" x > 0 && y < 0
    end
end
```
```julia-repl
┌ Debug: variables
│   x = 4
│   y = -4
└ @ Main REPL[10]:7
┌ Debug: condition
│   x > 0 && y < 0 = true
└ @ Main REPL[10]:8
┌ Debug: variables
│   x = 3
│   y = -3
└ @ Main REPL[10]:7
┌ Debug: condition
│   x > 0 && y < 0 = true
└ @ Main REPL[10]:8
┌ Debug: variables
│   x = 2
│   y = -2
└ @ Main REPL[10]:7
┌ Debug: condition
│   x > 0 && y < 0 = true
└ @ Main REPL[10]:8
┌ Debug: variables
│   x = 1
│   y = -1
└ @ Main REPL[10]:7
┌ Debug: condition
│   x > 0 && y < 0 = true
└ @ Main REPL[10]:8
┌ Debug: variables
│   x = 0
│   y = 0
└ @ Main REPL[10]:7
┌ Debug: condition
│   x > 0 && y < 0 = false
└ @ Main REPL[10]:8
```
# References

- [^1]: Think Julia: How to Think Like a Computer Scientist, <https://benlauwens.github.io/ThinkJulia.jl/latest/book.html>.

````julia:ex70
rm("output.txt", force = true); # hide
````

