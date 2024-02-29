# This file was generated, do not modify it. # hide
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