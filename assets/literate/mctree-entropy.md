<!--This file was generated, do not modify it.-->
# Entropy of Markov tree-shifts over Markov-Cayley trees

## Backgrounds

Let $\mathcal{A}$ be a finite alphabet and $K$ be a $k$-by-$k$, $0$-$1$ matrix. A *Markov-Cayley* tree $T_K$ is subset of a free semigroup with generators $[k] = \{1,2,\cdots,k\}$:

\begin{align*}T_K=\{g \in \cup_{i \ge 0} [k]^{i}: K_{g_i, g_{i+1}} = 1, \text{ for all } i \ge 1\}。\end{align*}

A *Markov-Cayley tree-shifts $X_{\mathbf{A}}$*, associated with a $k$-tuple of $0$-$1$ matrices $\mathbf{A} = (A^{(1)}, A^{(2)}, \cdots, A^{(k)})$, over $T_K$ is a subset of $\mathcal{A}^{T_K}$ defined as

\begin{align*}X_{\mathbf{A}}=\{x \in \mathcal{A}^{T_K}: A^{(i)}_{x_g, x_{g i}} = 1, \text{ for all } g \in T_K, i \in [k] \text{ such that } g i \in T_k\}.\end{align*}

The *topological entropy* of $T_K$ is defined to be

\begin{align*}h(X_{\mathbf{A}}) = \lim_{n \to \infty} h^{(i)}_n(X_{\mathbf{A}}) := \lim_{n \to \infty} \frac{\log p^{(i)}_n(X_{\mathbf{A}})}{\# \Delta^{(i)}_n} \text{ for } i \in [k],\end{align*}

where $\Delta^{(i)}_n$ is the set $\{g \in T_K: g \text{ is of length } n \text{ with } i \text{ its prefix}\}$ and $p^{(i)}_n = \# \{x|_{\Delta^{(i)}_n}: x \in X_A\}$. If we further define $p^{(i)}_{n;a} = \# \{x|_{\Delta^{(i)}_n}: x \in X_A, x_\epsilon = a\}$ (so that $p^{(i)}_{n} = \sum_{a} p^{(i)}_{n;a}$), one can compute $h_n^{(i)}$ via the following recursive relation:

\begin{align*}\begin{cases}p^{(i)}_{n+1;a} = \prod_{j: K_{i,j}=1}\sum_{b:A^{(i)}_{a,b}=1} p^{(j)}_{n;b} \\ (\# \Delta^{(i)}_{n+1} - 1) = 1 + \prod_{j: K_{i,j}=1} (\# \Delta^{(j)}_{n} - 1) \end{cases}\end{align*}

We remark that $p^{(i)}_{n;a}$, at fastest, grows superexponentially in $n$, and is too large to store as a number. To address the issue, a naive solution is to normalize $p^{(i)}_{n;a}$ by $D^{(i)}_n = \max_{b} p^{(i)}_{n;b}$, which we denote by $\overline{p}^{(i)}_{n;a} = p^{(i)}_{n;a} / D^{(i)}_n$, and rephrase the recursion in terms of $\overline{p}^{(i)}_{n;a}$:

\begin{align*}\begin{cases} \overline{p}^{(i)}_{n+1;a} \cdot C^{(i)}_{n+1} = \prod_{j: K_{i,j}=1} \sum_{b:A^{(i)}_{a,b}=1} \overline{p}^{(j)}_{n;b} \\ \log D^{(i)}_{n+1} = \log C^{(i)}_{n+1} + \sum_{j: K_{i,j} = 1} \log D^{(j)}_{n} \\ (\# \Delta^{(i)}_{n+1} - 1) = 1 + \prod_{j: K_{i,j}=1} (\# \Delta^{(j)}_{n} - 1) \end{cases},\end{align*}

where $C^{(i)}_{n+1}:=\max_a \prod_{j: K_{i,j}=1} \sum_{b:A^{(i)}_{a,b}=1}$. Note that we now can approximate entropy using $D^{(i)}_n$ since $\log D^{(i)}_n / \log p^{(i)}_n(X_{\mathbf{A}}) \to 1$, and that $\log D^{(i)}_n$ grows only exponentially in $n$.

## Program

````julia:ex1
K=[1 1;1 1]
````

````julia:ex2
A = ([0 1 1;1 0 0;1 0 0], [1 1 1;1 0 0;1 0 1])
````

````julia:ex3
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
````

````julia:ex4
mctree_entropy(K,A)
````

