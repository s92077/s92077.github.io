# This file was generated, do not modify it.

K=[1 1;1 1]

A = ([0 1 1;1 0 0;1 0 0], [1 1 1;1 0 0;1 0 1])

"""
`function mctree_entropy(K, A, max_iter=50)`
The function returns the entropy \$h^{(i)}_n(X_{\\mathbf{A}}) \$ of the Markov tree-shifts \$X_{\\mathbf{A}}\$ over the Markov-Cayley tree \$T_K\$ associated with matrix ``K``, where
- `K` is the defining `k`-by-`k` matrix for the Markov-Cayley tree
- `A` is a vector of `k` adjacency matrices
- `max_iter` is the maximal number of iterations
"""
function mctree_entropy(K, A, max_iter=50)
    norm_pattern_num = ones(size(K,2), size(A[1],2), max_iter) # normalized number of patterns
    log_pattern_num = zeros(size(K,2), max_iter) # logarithm of pattern numbers (D^{(i)}_n)
    entropy = zeros(size(K,2), max_iter) # n-order approximation of entropy
    norm_const = ones(size(K,2), max_iter) # normalization constant (C^{(i)}_n)
    lattice_point_num = ones(size(K,2), max_iter) # numbers of lattice points (\# \Delta^{(i)}_n - 1)
    break_flag = false # break flag: terminate iteration if converged
    end_iter = 0 # number of executed iterations
    for i in 2:max_iter
        lattice_point_num[:,i] = K * lattice_point_num[:,i-1] .+ 1;
        for j in 1:size(K,2)
            temp = ones(size(A[1],2),1);
            for k in 1:size(K,2)
                if K[j,k] == 1
                    temp = temp .* (A[k] * norm_pattern_num[k,:,i-1]);
                end
            end
            norm_const[j,i] = maximum(temp);
            norm_pattern_num[j,:,i] = temp / norm_const[j,i];
            log_pattern_num[j,i] = K[j,:]' * log_pattern_num[:,i-1] + log10(norm_const[j,i]);
            entropy[j,i] = log_pattern_num[j,i] / lattice_point_num[j,i];
            if log_pattern_num[j,i] == -Inf
                break_flag = true;
                break;
            elseif abs(entropy[j,i] - entropy[j,i-1]) / entropy[j,i] < 1E-11 || entropy[j,i] < 1E-11
                break_flag = true;
                break;
            end
        end
        end_iter = i
        if break_flag
            end_iter = i-1;
            break
        end
    end
    return maximum(entropy[:,1:end_iter], dims = 1)
end

mctree_entropy(K,A)

