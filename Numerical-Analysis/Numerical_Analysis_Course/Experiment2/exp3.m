% 自定义函数计算选列主元LU分解和奇异值分解, 并验证计算结果
% [4 1 -1; 3 2 -6; 1 -5 3]

% 定义矩阵
A = [4 1 -1; 3 2 -6; 1 -5 3];

% 计算选列主元 LU 分解
[L, U, P] = lu_decomposition(A);
disp('LU decomposition:')
disp('L:')
disp(L)
disp('U:')
disp(U)
disp('P:')
disp(P)

% 计算奇异值分解
[U, S, V] = svd_decomposition(A);
disp('SVD decomposition:')
disp('U:')
disp(U)
disp('S:')
disp(S)
disp('V:')
disp(V)
