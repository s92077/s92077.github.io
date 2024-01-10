# This file was generated, do not modify it.

using PlutoUI # hide

m = 10

HTML("<input type=range min=1 max=100>");

n = 10; # hide

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

