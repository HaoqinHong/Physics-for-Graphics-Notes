% 计算正定矩阵的平方根分解的函数
function B = sqrt_decomposition(A)
    [V,D] = eig(A);
    B = V*sqrt(D)*V';
end