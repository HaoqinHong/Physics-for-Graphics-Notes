% 求下列矩阵的行列式、逆、特征值、特征向量、各种范数和条件数
% [4 1 -1; 3 2 -6; 1 -5 3]

% 定义矩阵
A = [4 1 -1; 3 2 -6; 1 -5 3];

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