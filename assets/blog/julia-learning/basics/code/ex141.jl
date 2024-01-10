# This file was generated, do not modify it. # hide
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