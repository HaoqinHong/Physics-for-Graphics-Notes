function x = jacobi(A, b, x0, tol, maxIter)
% 格式: x = jacobi(A, b, x0, tol, maxIter)
% A 是系数矩阵，b 是常数向量
% x0 是初始解，tol 是误差阈值，maxIter 是最大迭代次数

if nargin < 5, maxIter = 1000; end
if nargin < 4, tol = 1e-6; end

x = x0;
n = length(x0);

for k = 1:maxIter
    x_old = x;
    for i = 1:n
        x(i) = (b(i) - A(i, [1:i-1, i+1:end]) * x_old([1:i-1, i+1:end])) / A(i, i);
    end
    if max(abs(x - x_old)) < tol
        break;
    end
end

end