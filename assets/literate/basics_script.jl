# This file was generated, do not modify it.

println("Hello, World!")

Text("Hello, World!")

40 + 2

43 - 1

6 * 7

84 / 2

(2 + 4) * 7

1 == 2

3 != 3

1 < 2 != 5

"abc" * "def"

"abc" ^ 4

(2 > 1) && (3 > 2) # (2 > 1) and (3 > 2)

typeof(2)

typeof(42.0)

typeof("Hello, World!")

typeof([1 2 3 4 ; 5 6 7 8])

typeof([1, 2, 3, 4 ])

typeof(1+2im)

typeof(1.0+2im)

typeof(Inf)

typeof(NaN)

🐢 = 3.2

message = "a message"

let
    x = 0
    x += 1
end

sin(pi)

log10(exp(1))

"""
`function nothing()`
The function print the string "Nothing".
"""
function nothing()
    Text("Nothing")
end

nothing()

"""
`function circle_area(r)`
The function computes area of a circle with radius `r`.
"""
function circle_area(r)
    return pi * r^2
end

circle_area(2)

circle_area_inline(r) = pi * r^2

circle_area_inline(2)

begin
    if 0 > 0
        Text("1 is positive")
    end
end

begin
    if -1 > 0
        Text("-1 is positive")
    else
        Text("-1 is negative")
    end
end

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

fibonacci_recursion(7)

for i in 1:10
    if i % 3 == 0
        break
    end
    print(i, " ")
end

for i in 1:10
    if i % 3 == 0
        continue
    end
    print(i, " ")
end

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

fibonacci_while(7)

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

fibonacci_for(7)

'c'

'\u63' + 1

'🍌'

'\u1CC4'

'\U1F34C'

sizeof('🍌')

sizeof("c")

sizeof("\u1CC4")

sizeof("🍌")

str = "\u1CC4🍌c"

sizeof(str)

str[end]

str[2]

string(str,"1")

"$(str)$(1+1)"

length(str)

firstindex(str)

lastindex(str)

collect(eachindex(str))

for letter in str
    println(letter)
end

"abracadabra" >= "xylophone"

"Hello, Alice." <= "Hello, Bob."

str[[1,8]]

ncodeunits(str)

findnext("abc", "abcabc", 2)

occursin("abc", "abcabc")

'a' in "abcabc"

codeunit(str, 2)

collect(str)

join(['a', 'b', 'c'])

split("a-+b-c", "-+")

split("a b c")

let
    test_str = "AAA"
    test_str[1] = 'a'
end

let
    test_str = "AAA"
    test_str = 'a' * test_str[2:end]
end

cheeses = ["Cheddar", "Edam", "Gouda"]

random_items = ["spam", 2.0, 5, [10, 20]]

typeof(cheeses)

typeof(random_items)

cheeses[[1,3]]

"b" in cheeses

collect(eachindex(cheeses))

for item in cheeses
    println(item)
end

for i in eachindex(cheeses)
    println(cheeses[i])
end

let
    characters = ["a", "b", "c"]
    append!(characters, ["start"])
    push!(characters, "end")
end

let
    characters = ["a", "b", "c", "d", "e", "f"]
    splice!(characters, 3)
    pop!(characters)
    popfirst!(characters)
    characters
end

sort(["c", "b", "a"])

sum([1, 2, 3, 4])

[1, 2, 3, 4, 5] .^ 2

"Any Julia function can be applied elementwise to any array with the dot syntax."

circle_area.([1, 2, 3, 4, 5])

let
    characters = ["a", "b", "c"]
    characters[1] = "d"
    Text(characters)
end

let
    a = "banana"
    b = "banana"
    (a == b), (a === b)
end

let
    a = [10, 20]
    b = [10, 20]
    (a == b), (a === b)
end

let
    a = [10, 20]
    b = a
    (a == b), (a === b)
end

let
    a = [10, 20]
    b = a
    b[2] = 40
    a
end

let
    a = [10, 20]
    b = a[:]
    b[2] = 40
    a
end

dict = Dict()

begin
    global dict["one"] = 1
    dict
end

dict

"one" in keys(dict)

"dict" in values(dict)

for i in keys(dict)
    println(i)
end

get(dict, "one", -1), get(dict, "test", -1)

dict1 = Dict("one" => "uno", "two" => "dos", "three" => "tres")

typeof(dict1), ismutable(dict1)

let
    a, b = 1, 2
    temp = a
    a = b
    b = temp
    Text("$a $b")
end

let
    a, b = 1, 2
    a, b = b, a
end

typeof((1, 2)), ismutable((1, 2))

function minmax(t)
    minimum(t), maximum(t)
end

let
    tuple = (1, 2, 3, 4, 5)
    minmax(tuple)
end

function printall(args...)
    println(args[2:end])
end

printall(1,2,3,4,5)

let
    area_rectangle(x, y) = x * y
    rectangle = (3, 5)
    area_rectangle(rectangle...)
end

md"Arrays and Tuples
zip is a built-in function that takes two or more sequences and returns a collection of tuples where each tuple contains one element from each sequence. This example zips a string and an array:"

s = "abcd";

t = [1, 2, 3];

zip(s, t)

typeof(zip(s, t))

for pair in zip(s, t)
    pair
end

collect(zip(s, t))

let
    d = Dict('a'=>1, 'b'=>2, 'c'=>3);
    for (key, value) in d
        println(key, " ", value)
    end
end

let
    t = [('a', 1), ('c', 3), ('b', 2)];
    d = Dict(t)
end

let
    fout = open("output1.txt", "w")
    write(fout, "Her name is Alice.\nHis name is Bob.")
    close(fout)
end

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

[1 2 3 ; 4 5 6]

let
    A = [1 2 3 ; 4 5 6]
    A[2,3] = 7
    A
end

[2, 3]'

[1 2 3; 4 5 6]'

let
    A = [1 2;3 4]
    b = [1,0]
    A \ b
end

ones(3,3)

ones(Integer,3)

size([1 2 3 ; 4 5 6])

import LinearAlgebra

LinearAlgebra.eigvals([1 2 ; 3 4])

LinearAlgebra.eigvecs([1 2 ; 3 4])

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

