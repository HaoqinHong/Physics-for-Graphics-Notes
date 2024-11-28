% 判断矩阵是否为正定矩阵的函数
function is_positive_definite = check_positive_definite(A)
    is_positive_definite = all(eig(A) > 0);
end