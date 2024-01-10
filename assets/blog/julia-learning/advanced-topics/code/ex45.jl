# This file was generated, do not modify it. # hide
let
    data = "This here's the wattle,\nthe emblem of our land.\n"
    open("output.txt", "w") do fout
        write(fout, data)
    end
end