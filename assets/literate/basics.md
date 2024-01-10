<!--This file was generated, do not modify it.-->
# Basics of Julia

**Note:** The materials of the this introduction are borrowed from [^1].
\toc
## “Hello, World!”

As a tradition, we write “Hello, World!” as our first program, which simply display the worlds “Hello, World!”. In Julia, it looks like this:

````julia:ex1
println("Hello, World!")
````

In Pluto, an alternative solution to that is:

````julia:ex2
Text("Hello, World!")
````

## Operators

### Arithmetic operators

Julia provides *operators*, such as `+`,`-`,`*`,`/`, which respectively performs addition, subtraction, multiplication, and division:

````julia:ex3
40 + 2
````

````julia:ex4
43 - 1
````

````julia:ex5
6 * 7
````

````julia:ex6
84 / 2
````

You can also combine these operations, as is seen in the following example:

````julia:ex7
(2 + 4) * 7
````

Here is a table of arithmetirc operations. Note that Julia support Unicode characters like '`÷`'.
| Expression | Name | Description |
| :--- | :--- | :--- |
| `+x` | unary plus | the identity operation |
| `-x` | unary minus | maps values to their additive inverses |
| `x + y` | binary plus | performs addition |
| `x - y` | binary minus | performs subtraction |
| `x * y` | times | performs multiplication |
| `x / y` | divide | performs division |
| `x ÷ y` | integer divide | `x / y`, truncated to an integer (equivalent to `div(x,y)`) |
| `x \ y` | inverse divide | equivalent to `y / x` |
| `x ^ y` | power | raises `x` to the `y`th power |
| `x % y` | remainder | equivalent to `rem(x,y)` |
(exerpted from <https://docs.julialang.org/en/v1.9/manual/mathematical-operations/#Arithmetic-Operators>)

!!! note "Operator precedence"
    The order of the evaluation depends on the *operator precendence*. Such precendences of some basic operations are given as follows, and the acronym PEMDAS is a useful way to remember the rules.
    1. parenthesese: `()`.
    2. exponentiation: `^`
    3. multiplication and division: `*` and `/`
    4. addition and subtraction: `+` and `/`
    For a complete list, check out [here](https://docs.julialang.org/en/v1/manual/mathematical-operations/#Operator-Precedence-and-Associativity).

### Numeric comparisons

We should compare two numbers by using the comparison operators. For example, we can check whether two numbers are the same (resp., different) by using `==` (resp., `!=`):

````julia:ex8
1 == 2
````

````julia:ex9
3 != 3
````

We can also do chaining comparison:

````julia:ex10
1 < 2 != 5
````

Here is a table of the comparison operators:
| Operator | Name |
| :--- | :--- |
| `==` | equality |
| `!=`, `≠` | inequality |
| `<` | less than |
| `<=`, `≤` | less than or equal to |
| `>` | greater than |
| `>=`, `≥` | greater than or equal to |
(exerpted from <https://docs.julialang.org/en/v1/manual/mathematical-operations/#Numeric-Comparisons>)

### String operators

Similar to the arithmetic operators, there are some operators for strings. The operator `*` concatenate two strings and `^` repeat a string for several times:

````julia:ex11
"abc" * "def"
````

````julia:ex12
"abc" ^ 4
````

### Boolean operators

To compare logic, we need Boolean operators. The result will be either true or false.

````julia:ex13
(2 > 1) && (3 > 2) # (2 > 1) and (3 > 2)
````

Here is a table of Boolean operators:
| Expression | Name |
| :--- | :--- |
| `!x` | negation |
| `x && y` | short-circuiting and |
| `x \|\| y` | short-circuiting or |

## Values and types

A *value* is one of the basic things a program works with, like a letter or a number. For example, `2`, `42.0`, "Hello, World!" are values. These values belong to different *types*: `2` is an *integer*, `42.0` is a floating-point number, and "Hello, World!" is a *string*. Check out the types of these by the command `typeof`

````julia:ex14
typeof(2)
````

````julia:ex15
typeof(42.0)
````

````julia:ex16
typeof("Hello, World!")
````

Matrices and vectors are also built-in types:

````julia:ex17
typeof([1 2 3 4 ; 5 6 7 8])
````

````julia:ex18
typeof([1, 2, 3, 4 ])
````

Julia supports also complex numbers. Find out what types they are:

````julia:ex19
typeof(1+2im)
````

````julia:ex20
typeof(1.0+2im)
````

There are also two special values extending the idea of numbers: `NaN` (not a number) and `Inf` (infinty). Check out what types they are:

````julia:ex21
typeof(Inf)
````

````julia:ex22
typeof(NaN)
````

Read also [here](https://docs.julialang.org/en/v1.9/manual/integers-and-floating-point-numbers/#Integers-and-Floating-Point-Numbers) to learn more about integers and floating-point numbers and [here](https://docs.julialang.org/en/v1.9/manual/complex-and-rational-numbers/) about complex numbers in Julia. Also, read also [here](https://docs.julialang.org/en/v1/manual/mathematical-operations/#Numeric-Comparisons) to learn about how to compare `NaN`, `Inf`, and other regular numbers.

!!! note
    For the type `Int64`, the number 64 indicate it takes 64 bits to store such a number. It could be verify by the function `sizeof`, which returns the number of byte (1 byte = 8 bits) of the argument.

## Variables and assignments

An *assignment statement* creates a new variable and gives it a value. For example, we can define two variables `x`, `🐢`, and `message` as below:

╠═╡ disabled = true

````julia:ex23
#=╠═╡
x = 2
  ╠═╡ =#
````

````julia:ex24
🐢 = 3.2
````

````julia:ex25
message = "a message"
````

!!! note "Rules of variable names"
    - It cannot begin with numbers.
    - Lowercase letters are preferred as a [convention](#01649df3-f3f9-4124-b838-39877da02694).
    - The underscore character, \_, is often used in names with multiple words, such as `your_name`.
    - [Unicode](https://en.wikipedia.org/wiki/Unicode) characters are allowed.
    - It cannot be Julia's reserved [_keywords_](https://docs.julialang.org/en/v1.9/base/base/#Keywords), such as `struct`.

What if we want to add 1 to `x`? We can simplify the expression `x = x + 1` by `x += 1`. (To understand `let...end` block, read also [this](#5ae1a550-999f-466e-bb1f-52a847a6688c).)

````julia:ex26
let
    x = 0
    x += 1
end
````

The pattern `+=` also works with other operators above, e.g. `-=`, `/=`, etc.

## Functions

A *function* is a named sequence of statements that performs a computation. After defining a function by specifying its name and sequence of statements, you can “call” the function by name. We have seen an example of a function call in our “Hello, World!” program:

```julia
println("Hello, World!")
```

In this program, `println` is the name of the function, and the string `"Hello, World!"` that we “pass” in the function is called an *argument*.

### Elemetary mathematical functions

Most of the familiar mathematical functions are available:

````julia:ex27
sin(pi)
````

````julia:ex28
log10(exp(1))
````

Check out the [documentation](https://docs.julialang.org/en/v1/base/math/#Base.sin-Tuple{Number}) to learn more about the basic mathematical functions.

### Adding new functions

In addition to calling available functions, we can also define our own! The basic syntax of a function definition is as follows:

```julia
function function_name(argument1, argument2, ...)
    statements1
    statements2
    ...
end
```

Roughly speaking, the variables defined in the function are local (stays alive only in the function.) The following is a function printing the string “Nothing”.

````julia:ex29
"""
`function nothing()`
The function print the string "Nothing".
"""
function nothing()
    Text("Nothing")
end
````

````julia:ex30
nothing()
````

The function `nothing` performs an action but does not return a value. Such a function is called a *void function*. We may also define a function that returns a value, and here is an example of a function calculating the area of a circle with radius `r`

````julia:ex31
"""
`function circle_area(r)`
The function computes area of a circle with radius `r`.
"""
function circle_area(r)
    return pi * r^2
end
````

````julia:ex32
circle_area(2)
````

An alternative way of defining a function is the following:

````julia:ex33
circle_area_inline(r) = pi * r^2
````

````julia:ex34
circle_area_inline(2)
````

## Conditional execution

to check conditions and change the behavior of the program accordingly, we need the `if` statement, whose basic syntax is as follows:

```julia
if condition1
    execute_statements1
elseif condition2
    execute_statements2
else
    execute_statements3
end
```

The above code executes `execute_statements1` if `condition1` is `true`, and `execute_statements2` if `condition1` is `false` but `condition2` is `true`, and `execute_statements3` if both `condition1` and `condition2` are `false`. Note that `else` and `elseif` are optional, and there can be as many `elseif`'s as you want between `if` and `else`. See the following for examples.

````julia:ex35
begin
    if 0 > 0
        Text("1 is positive")
    end
end
````

````julia:ex36
begin
    if -1 > 0
        Text("-1 is positive")
    else
        Text("-1 is negative")
    end
end
````

````julia:ex37
begin
    if NaN == 0
        Text("NaN is 0")
    elseif NaN > 0
        Text("NaN is positive")
    elseif NaN < 0
        Text("NaN is negative")
    else
        Text("NaN is neither positive nor negative")
    end
end
````

### An example

We can add the first `n` natural numbers using `if` statement.

````julia:ex38
"""
`function fibonacci_recursion(n::Int)`
The function computes `n`th term in the Fibonacci sequence.
"""
function fibonacci_recursion(n::Int)
    if n <= 0
        return 0
    elseif n < 3
        return 1
    else
        return fibonacci_recursion(n-1) + fibonacci_recursion(n-2)
    end
end
````

````julia:ex39
fibonacci_recursion(7)
````

The above function calls itself is *recursive*, and such a function is called a recursion.

!!! note
    A infinite recursion (or a never-ending recursion) would be interrupted by Julia by reporting an error message when the maximum recursion depth is reached.

## Iterations

### While loops

The `while` statement is used to repeatedly perform operations until a condition is no longer satisfied. The basic syntax of a while loop is:

```julia
while condition
    execute_statements
end
```

### For loops

For loop is a basic way to perform iterative operations. The basic syntax of a for loop is:

```julia
for iterator in range
    execute_statements(iterator)
end
```

### Break

The `break` statement is used to “jump” out of a while/for loop. See the follow example for the its usage.

````julia:ex40
for i in 1:10
    if i % 3 == 0
        break
    end
    print(i, " ")
end
````

### Continue

The `continue` statement is used to “jump” to the the beginning of a while/for loop. See the follow example for the its usage.

````julia:ex41
for i in 1:10
    if i % 3 == 0
        continue
    end
    print(i, " ")
end
````

### An example

We can implement a function computing the Fibonacci sequence using the while loop.

````julia:ex42
"""
`function fibonacci_while(n::Int)`
The function computes `n`th term in the Fibonacci sequence.
"""
function fibonacci_while(n::Int)
    temp1 = 1
    temp2 = 1
    ans = 0
    while n > 0
        temp1 = temp2
        temp2 = ans
        ans = temp1 + temp2
        n -= 1
    end
    return ans
end
````

````julia:ex43
fibonacci_while(7)
````

In a similar manner, we can implement such a function using the while loop.

````julia:ex44
"""
`function fibonacci_for(n::Int)`
The function computes `n`th term in the Fibonacci sequence.
"""
function fibonacci_for(n::Int)
    temp1 = 1
    temp2 = 1
    ans = 0
    for i in 1:n
        temp1 = temp2
        temp2 = ans
        ans = temp1 + temp2
    end
    return ans
end
````

````julia:ex45
fibonacci_for(7)
````

## String

### Char

A `Char` value is a single character and is surrounded by single quotes. In the digital world, we need encode the letters of the numerals/alphabet/... as digits. Among the encodings, [ASCII](https://en.wikipedia.org/wiki/ASCII) standard (American Standard Code for Information Interchange) maps commonly used numerals/English letters/punctuations to integers between 0 to 127. (It is very important to for you to get familiar with some special characters in the escaped input forms, such as newline `'\n'`.) On the other hand, the so-called [Unicode](https://en.wikipedia.org/wiki/Unicode) standard aims to include many characters in non-English languages, and it coincides with ASCII standard for values between 0 and 127.
Julia natively supports both encodings for its `Char` value. Some examples are given as follows. You can input any Unicode character in single quotes using `\u` followed by up to four hexadecimal digits or `\U` followed by up to eight hexadecimal digits (the longest valid value only requires six).

````julia:ex46
'c'
````

````julia:ex47
'\u63' + 1
````

````julia:ex48
'🍌'
````

````julia:ex49
'\u1CC4'
````

````julia:ex50
'\U1F34C'
````

Check out the the size of a character:

````julia:ex51
sizeof('🍌')
````

### String as a sequence of characters

A string in Julia is a sequence of characters (using the [UTF-8](https://en.wikipedia.org/wiki/UTF-8) encoding), and thus you can access every single character via the bracket operator. However, the size varies from from character to character. (Each byte is a "code unit"):

````julia:ex52
sizeof("c")
````

````julia:ex53
sizeof("\u1CC4")
````

````julia:ex54
sizeof("🍌")
````

Therefore, `sizeof` does not tells the real length of the string, and not all indices are valid:

````julia:ex55
str = "\u1CC4🍌c"
````

````julia:ex56
sizeof(str)
````

````julia:ex57
str[end]
````

````julia:ex58
str[2]
````

### Concatenation

There are different ways of concatenating strings. Apart from `*` and `^`, we can also use the following methods:

````julia:ex59
string(str,"1")
````

### Interpolation

Constructing strings using concatenation can become a bit cumbersome, however. To reduce the need for these verbose calls to string or repeated multiplications, Julia allows interpolation into string literals using `$`:

````julia:ex60
"$(str)$(1+1)"
````

### Length

To get the real length of the string, call `length(str)`:

````julia:ex61
length(str)
````

### Index

Some useful functions are `firstindex(str)`, `lastindex(str)`, `eachindex(str)`, `nextind(str, i, n=1)`, `prevind(str, i, n=1)`

````julia:ex62
firstindex(str)
````

````julia:ex63
lastindex(str)
````

````julia:ex64
collect(eachindex(str))
````

Loop through the characters in a string:

````julia:ex65
for letter in str
    println(letter)
end
````

### String comparisons

The strings are compared lexicographically (according to the UTF-8 encoding) using `<`, `<=`, `>`, `>=`, `==`, `!=`.

````julia:ex66
"abracadabra" >= "xylophone"
````

````julia:ex67
"Hello, Alice." <= "Hello, Bob."
````

To understand the above comparison, we note that the two strings share the same 7 code units, but the former has “smaller” 8th code unit (`'A' <= 'B'`).

### Substring

To extract a substring indexed by a index set `idx`, we can use the slice operator `array[idx]`

````julia:ex68
str[[1,8]]
````

Some useful functions are `findfirst(substr,str)`, `findlast(substr,str)`, `findnext(substr,str,i)`, `occursin(substr, str)`, `in(chr, str)` (equivalently, `chr ∈ str` or `chr in str`), `repeat(str, n)`

````julia:ex69
ncodeunits(str)
````

````julia:ex70
findnext("abc", "abcabc", 2)
````

````julia:ex71
occursin("abc", "abcabc")
````

````julia:ex72
'a' in "abcabc"
````

### Codeunit

Some useful functions are `ncodeunits(str)`, `codeunit(str,i)`

````julia:ex73
codeunit(str, 2)
````

### String library

One can convert a string to an array of characters via `collect(str)`.

````julia:ex74
collect(str)
````

To convert it back to a string, use `join(array)`:

````julia:ex75
join(['a', 'b', 'c'])
````

One can parse a string using `split(str, token)`

````julia:ex76
split("a-+b-c", "-+")
````

````julia:ex77
split("a b c")
````

### Strings are immutable

The strings are *immutable*, meaning that an existing string cannot be changed:

````julia:ex78
let
    test_str = "AAA"
    test_str[1] = 'a'
end
````

Instead, to modify the string, we can re-assign a new string to str.

````julia:ex79
let
    test_str = "AAA"
    test_str = 'a' * test_str[2:end]
end
````

## Arrays

### Array as a sequence of values

Like a *string*, an *array* is a sequence of values. In a string, the values are characters; in an array, they can be any type. An example could be:

````julia:ex80
cheeses = ["Cheddar", "Edam", "Gouda"]
````

````julia:ex81
random_items = ["spam", 2.0, 5, [10, 20]]
````

Check out what types they are:

````julia:ex82
typeof(cheeses)
````

````julia:ex83
typeof(random_items)
````

### Subarrays

To extract a subarray indexed by a index set `idx`, we can use the slice operator `array[idx]`

````julia:ex84
cheeses[[1,3]]
````

We can use `in(element, array)` (equivalently, `element ∈ array` or `element in array`) to check if an element is in the array.

````julia:ex85
"b" in cheeses
````

### Index

`eachindex(array)` also works for arrays.

````julia:ex86
collect(eachindex(cheeses))
````

Loop through the array:

````julia:ex87
for item in cheeses
    println(item)
end
````

Alternatively, we can do:

````julia:ex88
for i in eachindex(cheeses)
    println(cheeses[i])
end
````

### Array library

We can use `push!(array, element)` or `push!(array, array_src)` to add elements to array:

````julia:ex89
let
    characters = ["a", "b", "c"]
    append!(characters, ["start"])
    push!(characters, "end")
end
````

To delete the element from the array, one can use `splice!(array, i)` to delete the *i*th element and to return the deleted element, and use `deleteat(array, i)` to delete *i*th element the array and to return the updated array. Furthermore, use `pop!(array)` (resp. `popfirst!(array)`) to delete the last (resp. first) element of the array, which return the deleted element.

````julia:ex90
let
    characters = ["a", "b", "c", "d", "e", "f"]
    splice!(characters, 3)
    pop!(characters)
    popfirst!(characters)
    characters
end
````

!!! note
    The exclamation mark in `push!` or `pop!` is conventionally meant to indicate the arguments are written inside the function!

We can sort (in ascending order) arrays using `sort(array)`

````julia:ex91
sort(["c", "b", "a"])
````

We can sum an array of numbers by `sum(array)`

````julia:ex92
sum([1, 2, 3, 4])
````

### Entrywise operations

For every binary operator like `^`, there is a corresponding `dot` operator that performs entrywise operations.

````julia:ex93
[1, 2, 3, 4, 5] .^ 2
````

````julia:ex94
"Any Julia function can be applied elementwise to any array with the dot syntax."
````

````julia:ex95
circle_area.([1, 2, 3, 4, 5])
````

### Arrays are mutable

Unlike strings, arrays are *mutable*

````julia:ex96
let
    characters = ["a", "b", "c"]
    characters[1] = "d"
    Text(characters)
end
````

## Objects and Values

### Aliasing and mutability

An *object* is something a variable can refer to. If now we have two variables, say two strings `a` and `b` both are assigned `"banana"`, are these two variables refer to the same objects, or are they two different copies of the same string (immutable)? To conduct an experiment, we resort to the operator `===` to test if two variables refer to the same object, and `==` to see if the variables store the same string.

````julia:ex97
let
    a = "banana"
    b = "banana"
    (a == b), (a === b)
end
````

As opposed to it, if we replace the value by an array (mutable), the outcome is different.

````julia:ex98
let
    a = [10, 20]
    b = [10, 20]
    (a == b), (a === b)
end
````

In this case we would say that the two arrays are *equivalent*, because they have the same elements, but not *identical*, because they are not the same object.

!!! note
    Here is an explanation for the operator `===`
    - For mutable values (arrays, mutable composite types), === checks object identity: `x === y` is true if `x` and `y` are the same object, stored at the same location in memory.
    - For immutable composite types, `x === y` is true if `x` and `y` have the same type – and thus the same structure – and their corresponding components are all recursively `===`.
    - For bits types (immutable chunks of data like Int or Float64), `x === y` is true if `x` and `y` contain exactly the same bits.

We should note that variables `a` and `b` only stores the *address* to the object, and therefore we may assign the *address* in `b` to `a`:

````julia:ex99
let
    a = [10, 20]
    b = a
    (a == b), (a === b)
end
````

This is where we should be more careful with mutable types, since the actually values pointed by the *address* might be changed without changing the *address*:

````julia:ex100
let
    a = [10, 20]
    b = a
    b[2] = 40
    a
end
````

To copy the properly copy `a` to `b`, we may consider:

````julia:ex101
let
    a = [10, 20]
    b = a[:]
    b[2] = 40
    a
end
````

## Dictionary

A *dictionary* is like an array, but more general. In an array, the indices have to be integers; in a dictionary they can be (almost) any type.

To create a dictionary, see following examples:

````julia:ex102
dict = Dict()
````

````julia:ex103
begin
    global dict["one"] = 1
    dict
end
````

````julia:ex104
dict
````

### Index

Get keys using `keys(dict)` and values using `values(dict)`.

````julia:ex105
"one" in keys(dict)
````

````julia:ex106
"dict" in values(dict)
````

We may also loop throught the dictionary.

````julia:ex107
for i in keys(dict)
    println(i)
end
````

We get entry using `get(dict, element, default_return)`:.

````julia:ex108
get(dict, "one", -1), get(dict, "test", -1)
````

Alternatively, we can initialize a dictionary by

````julia:ex109
dict1 = Dict("one" => "uno", "two" => "dos", "three" => "tres")
````

### Dictionary is mutable

Check out the type of the dictionary and whether it is immutable:

````julia:ex110
typeof(dict1), ismutable(dict1)
````

## Tuple

The following is a motivation for using tuple objects. It is often useful to swap the values of two variables. With conventional assignments, you have to use a temporary variable. For example, to swap a and b:

````julia:ex111
let
    a, b = 1, 2
    temp = a
    a = b
    b = temp
    Text("$a $b")
end
````

This solution is cumbersome; tuple assignment is more elegant:

````julia:ex112
let
    a, b = 1, 2
    a, b = b, a
end
````

### Tuple is immutable

````julia:ex113
typeof((1, 2)), ismutable((1, 2))
````

### Tuple as a return value

We may return a tuple in a function:

````julia:ex114
function minmax(t)
    minimum(t), maximum(t)
end
````

````julia:ex115
let
    tuple = (1, 2, 3, 4, 5)
    minmax(tuple)
end
````

### Variable-length argument tuples

Functions can take a variable number of arguments. A parameter name that ends with `...` *gathers* arguments into a tuple. The syntax for it would be like:
```julia
function function_name(args...)
    execute_statements
end
```

For example, the following function prints all but the first arguments passed in the function:

````julia:ex116
function printall(args...)
    println(args[2:end])
end
````

````julia:ex117
printall(1,2,3,4,5)
````

The operator `...` also *scatters* a tuple to pass it into a function. The following code is an example to demonstrate this:

````julia:ex118
let
    area_rectangle(x, y) = x * y
    rectangle = (3, 5)
    area_rectangle(rectangle...)
end
````

### Arrays and tuples

````julia:ex119
md"Arrays and Tuples
zip is a built-in function that takes two or more sequences and returns a collection of tuples where each tuple contains one element from each sequence. This example zips a string and an array:"
````

````julia:ex120
s = "abcd";
````

````julia:ex121
t = [1, 2, 3];
````

This is what it looks like if we zip `s` and `t`:

````julia:ex122
zip(s, t)
````

````julia:ex123
typeof(zip(s, t))
````

The `Zip` type is sort of an iterator, and thus we can loop through it.

````julia:ex124
for pair in zip(s, t)
    pair
end
````

We can also use collect to make it an array:

````julia:ex125
collect(zip(s, t))
````

### Dictionaries and Tuples

1. Dictionaries can be used as iterators that iterate the key-value pairs. You can use it in a for loop like this:

````julia:ex126
let
    d = Dict('a'=>1, 'b'=>2, 'c'=>3);
    for (key, value) in d
        println(key, " ", value)
    end
end
````

2. You can use an array of tuples to initialize a new dictionary:

````julia:ex127
let
    t = [('a', 1), ('c', 3), ('b', 2)];
    d = Dict(t)
end
````

## Files

We can create a text file using `open(filename, mode)`, write to a file using `write(iostream, str)`, and close a file using `close(iostream)`. The following code serves as an example.

````julia:ex128
let
    fout = open("output1.txt", "w")
    write(fout, "Her name is Alice.\nHis name is Bob.")
    close(fout)
end
````

Check also the functions [`write`](https://docs.julialang.org/en/v1.9/base/io-network/#Base.write), [`readlines`](https://docs.julialang.org/en/v1.9/base/io-network/#Base.readlines)

!!! note
    - The argument `filename` can be either the complete path or the relative path with respect to where the `.jl` file is at.
    - If we do not close the file, the file will still be closed as the code exit.
    - To learn more about mode, please check out [here](https://docs.julialang.org/en/v1.9/base/io-network/#Base.open). Basically,
        - `read` means reading file;
        - `write` means writing to file;
        - `append` means always writing at the end of the file;
        - `truncate` means clearing the file if existing;
        - `create` means creating the file if not existing;
    - By default, the mode is `r`

### Exception handling

A lot of things can go wrong when you try to read and write files. If you try to open a file that doesn’t exist or that you don’t have permission, you get a SystemError. In these cases, we can use `try`-`catch` statement to handle these exceptions, and `finally` to execute instructions when the given block of code exits. An example is given as follows:

````julia:ex129
let
    try
        i = 1;
        fin = open("output1.txt")
        try
            for line in eachline(fin)
                println("line $( i ): $line")
                i += 1
            end
        finally
            close(fin)
            println("File closed.")
        end
    catch exc
        println("Something went wrong: $exc")
    finally
        println("The code ends.")
    end
end
````

## Others

We listed here some basic but useful functions. To learn more about these functions, check `Live Docs` in Pluto or [documentation](https://docs.julialang.org/en/v1.9/).

### How to type a matrix?

If we want to type a matrix 2 x 3 matrix, one way to do it is to use white space ` `for horizontal concatenation, and use semicolon for vertical concatenation.

````julia:ex130
[1 2 3 ; 4 5 6]
````

We note that the convention is slightly different from MATLAB. See [documentation](https://docs.julialang.org/en/v1/manual/arrays/) for a more detailed explanation of concatenation.

### How to access an element of a matrix?

To access the element at (2,3), we type:

````julia:ex131
let
    A = [1 2 3 ; 4 5 6]
    A[2,3] = 7
    A
end
````

### Transpose `'`

Use `'` to transpose a matrix / vector:

````julia:ex132
[2, 3]'
````

````julia:ex133
[1 2 3; 4 5 6]'
````

### Solve for A x = b

````julia:ex134
let
    A = [1 2;3 4]
    b = [1,0]
    A \ b
end
````

### `ones/zeros`

The function `ones` (resp. `zeros`). Generate an all-1 (resp, all-0) vector matrix

````julia:ex135
ones(3,3)
````

````julia:ex136
ones(Integer,3)
````

````julia:ex137
size([1 2 3 ; 4 5 6])
````

### `eigvals` and `eigvec`

To compute eigenvalues and eigenvectors, we need to import the `LinearAlgebra` module. We type:

````julia:ex138
import LinearAlgebra
````

````julia:ex139
LinearAlgebra.eigvals([1 2 ; 3 4])
````

````julia:ex140
LinearAlgebra.eigvecs([1 2 ; 3 4])
````

# References

- [^1]: Think Julia: How to Think Like a Computer Scientist, <https://benlauwens.github.io/ThinkJulia.jl/latest/book.html>.

# Final notes

## About the coding style

Every language has its own programming style (e.g. capitalization of variable names or avoid overuse of certain commands), and it is recommended to follow those coding styles are usually recommended. At the very least, it helps others in the community to read the code. Sometimes it also improves the performance of the code since it might sometimes related to how the code is compiled or executed and even how the language itself is designed.

- Check [here](https://docs.julialang.org/en/v1.9/manual/variables/#Stylistic-Conventions) for the stylistic conventions for variables.
- Check [here](https://docs.julialang.org/en/v1.9/manual/style-guide/) for the general style guide.

## About the scope

The reason the some of the codes are encapsulated in a `let` is two-fold. On the one hand, Pluto need a `begin` block or a `let` block to run multiple commands in one cell. On the other, `let` block, unlike `begin` block, create a new local scope to avoid name conflict (The `x` in the block has nothing to do with the formerly defined `x`). For a better understanding of the scope in Julia, please also read the [documentation](https://docs.julialang.org/en/v1/manual/variables-and-scoping/#Global-Scope), from which the following table is excerpted.
| Construct | Scope type | Allowed within |
| :--- | :--- | :--- |
| `module`, `baremodule` | global | global |
| `struct` | local (soft) | global |
| `for`, `while`, `try` | local (soft) | global, local |
| `macro` | local (hard) | global |
| functions, `do` blocks, `let` blocks, comprehensions, generators | local (hard) | global, local |
`begin` blocks and `if` blocks do not create new local scopes.
In summary, we have the following rules.
> * If the current scope is global, the new variable is global; if the current scope is local, the new variable is local to the innermost local scope and will be visible inside of that scope but not outside of it.
> * When `x = <value>` occurs in a local scope, Julia applies the following rules
>     1. **Existing local:** If x is already a local variable, then the existing local x is assigned;
>     2. **Hard scope:** If x is not already a local variable and assignment occurs inside of any hard scope construct, a new local named x is created in the scope of the assignment;
>     3. **Soft scope:** If x is not already a local variable and all of the scope constructs containing the assignment are soft scopes the behavior depends on whether the global variable x is defined:
>         1. if global x is undefined, a new local named x is created in the scope of the assignment;
>         2. if global x is defined, the assignment is considered ambiguous:
>             - in non-interactive contexts (files, eval), an ambiguity warning is printed and a new local is created;
>             - in interactive contexts (REPL, notebooks), the global variable x is assigned.
It should be a good exercise to think about which rule should apply in the above examples.

## About regular expressions

Sometimes you are not looking for an exact string, but a particular pattern, say for example, date of the format `YYYY-MM-DD`. Then, [regular expressions](https://docs.julialang.org/en/v1/manual/strings/#man-regex-literals) just comes in handy:

````julia:ex141
begin
    #' The input string containing two dates
    date = "Alice's birthday is 1991-01-01, and Bob's birthday is 1992-02-02."
    println("Input string: ", date)
    #' Define the regex string and substitution string
    regex1 = r"[0-9]{4}-[0-9]{2}-[0-9]{2}"
    regex2 = r"(?<Alice>[0-9]{4}-[0-9]{2}-[0-9]{2})(.+)(?<Bob>[0-9]{4}-[0-9]{2}-[0-9]{2})"
    substitution = s"\g<Bob>\2\g<Alice>"
    #' Find the first matched date
    m = match(regex1, date)
    println("First found date: ", m.match)
    #' Find the second matched date
    m = match(regex1, date, m.offset + 1)
    println("Second found date: ", m.match)
    #' Swap two matched date
    date_swap = replace(date, regex2 => substitution)
    println("Swap the dates: ", date_swap)
    #' Types of r"..." and s"..."
    println("The type of r\"..\" string: ", typeof(regex1))
    println("The type of s\"..\" string: ", typeof(substitution))
end
````

