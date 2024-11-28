% （追赶法的深度）考虑 n 阶三对角方程组
n = 300;
A = zeros(n, n);
A(1, 1) = 2;
A(1, 2) = 1;
for i = 2: n - 1
    A(i, i - 1) = 1;
    A(i, i) = 2;
    A(i, i + 1) = 1;
end
A(n, n - 1) = 1;
A(n, n) = 2;

% 用选列主元高斯消去法求解
b = ones(n, 1) * 4;
b(1) = 3;
b(end) = 3;
x = hidden_selected_nagauss(A, b)
euclidean_distance = norm(x - b)