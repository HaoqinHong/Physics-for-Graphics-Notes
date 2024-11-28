% 求下列矩阵的行列式、逆、特征值、特征向量、各种范数和条件数
% n 阶方阵, n = 5, 50 和 500

% 定义矩阵
n = input('请输入n的值:');
A = zeros(n, n);
A(1, 1) = 5;
A(1, 2) = 6;
for i = 2: n - 1
    A(i, i - 1) = 1;
    A(i, i) = 5;
    A(i, i + 1) = 6;
end
A(n, n - 1) = 1;
A(n, n) = 5;
disp(A)
 
% 计算行列式
det_A = det(A);
disp(['Determinant: ', num2str(det_A)])

% 计算逆矩阵
inv_A = inv(A);
disp('Inverse:')
disp(inv_A)

% 计算特征值和特征向量
[V,D] = eig(A);
disp('Eigenvalues:')
disp(diag(D))
disp('Eigenvectors:')
disp(V)

% 计算各种范数
norm_1 = norm(A, 1); % 1范数
norm_2 = norm(A, 2); % 2范数
norm_inf = norm(A, inf); % 无穷范数
norm_fro = norm(A, 'fro'); % Frobenius范数
disp(['1-norm: ', num2str(norm_1)])
disp(['2-norm: ', num2str(norm_2)])
disp(['Inf-norm: ', num2str(norm_inf)])
disp(['Frobenius norm: ', num2str(norm_fro)])

% 计算条件数
cond_1 = cond(A, 1); % 1条件数
cond_2 = cond(A, 2); % 2条件数
cond_inf = cond(A, inf); % 无穷条件数
disp(['1-condition number: ', num2str(cond_1)])
disp(['2-condition number: ', num2str(cond_2)])
disp(['Inf-condition number: ', num2str(cond_inf)])