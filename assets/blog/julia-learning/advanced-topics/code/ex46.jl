# This file was generated, do not modify it. # hide
let
    data = "This here's the wattle,\nthe emblem of our land.\n"
    f = fout -> begin
        write(fout, data)
    end
    open(f, "output.txt", "w")
end