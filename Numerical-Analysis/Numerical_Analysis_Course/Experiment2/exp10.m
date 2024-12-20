n = input('请输入n的值:');
A = zeros(n, n);

A(1, 1) = 3;
A(1, 2) = -1/2;
A(1, 3) = -1/4;
A(2, 1) = -1/2;
A(2, 2) = 3;
A(2, 3) = -1/2;
A(2, 4) = -1/4;

for i = 3: n - 2 
    A(i, i - 2) = -1/4;
    A(i, i - 1) = -1/2;
    A(i, i) = 3;
    A(i, i + 1) = -1/2;
    A(i, i + 2) = -1/4;
end

A(n - 1, n) = -1/2;
A(n - 1, n - 1) = 3;
A(n - 1, n - 2) = -1/2;
A(n - 1, n - 3) = -1/4;
A(n, n) = 3;
A(n, n - 1) = -1/2;
A(n, n - 2) = -1/4;

b = sum(A, 2);

% 选列主元的高斯消去法
disp('选列主元的高斯消去法:')
x = hidden_selected_nagauss(A, b);

% 高斯-赛德尔迭代，普通存储方式
disp('高斯-赛德尔迭代，普通存储方式')
x = nags(A, b);

% 高斯-赛德尔迭代，稀疏存储方式
disp('高斯-赛德尔迭代，稀疏存储方式')
x = naspgs(A, b);
