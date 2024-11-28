% 选列主元 LU 分解的函数
function [L, U, P] = lu_decomposition(A)
    [m, n] = size(A);
    L = eye(n);
    U = A;
    P = eye(n);
    for k = 1:n
        [~, i] = max(abs(U(k:n, k)));
        i = i + k - 1;
        U([k, i], :) = U([i, k], :);
        L([k, i], 1:k-1) = L([i, k], 1:k-1);
        P([k, i], :) = P([i, k], :);
        for j = k+1:n
            L(j, k) = U(j, k) / U(k, k);
            U(j, k:n) = U(j, k:n) - L(j, k) * U(k, k:n);
        end
    end
end