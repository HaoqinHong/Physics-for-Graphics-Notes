% 使用雅可比方法来迭代地消除矩阵的非对角元素，最终得到一个近似对角矩阵，其对角线元素就是原矩阵的特征值，而变换矩阵就是原矩阵的特征向量
function [V, D] = my_eig(A)
    n = size(A, 1);
    V = eye(n);
    for k = 1:100
        [p, q] = find_pq(A);
        [c, s] = find_cs(A, p, q);
        J = eye(n);
        J([p, q], [p, q]) = [c -s; s c];
        A = J' * A * J;
        V = V * J;
    end
    D = diag(diag(A));
end

function [p, q] = find_pq(A)
    [m, p] = max(abs(A - diag(diag(A))), [], 'all', 'linear');
    q = mod(p - 1, size(A, 1)) + 1;
    p = (p - q) / size(A, 1) + 1;
end

function [c, s] = find_cs(A, p, q)
    if A(p, q) == 0
        c = 1;
        s = 0;
    else
        tau = (A(q, q) - A(p, p)) / (2 * A(p, q));
        t = sign(tau) / (abs(tau) + sqrt(1 + tau^2));
        c = 1 / sqrt(1 + t^2);
        s = c * t;
    end
end