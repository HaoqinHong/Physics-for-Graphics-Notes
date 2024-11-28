% 判断矩阵是否为正定矩阵, 求正定矩阵的平方根分解, 并验证计算结果
function process_matrix(A)
    % 判断是否为正定矩阵
    if check_positive_definite(A)
        disp('The matrix is positive definite.')

        % 计算平方根分解
        B = sqrt_decomposition(A);
        disp('Square root decomposition:')
        disp(B)

        % 验证计算结果
        disp('Verification:')
        disp(B*B')
    else
        disp('The matrix is not positive definite.')
    end
end

function is_positive_definite = check_positive_definite(A)
    is_positive_definite = all(eig(A) > 0);
end

function B = sqrt_decomposition(A)
    [V,D] = eig(A);
    B = V*sqrt(D)*V';
end