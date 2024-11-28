function x = nags(A, b, x0, e, N)
% A 为系数矩阵，b为右端向量，x返回解向量
% x0为初始向量，e为精度，N为迭代上限
n = length(b);
if nargin < 5, N = 500; end
if nargin < 4, e = 1e-2; end
if nargin < 3, x0 = zeros(n, 1); end
x = x0;
x0 = x + 2 * e;
k = 0; Al = tril(A); iAl = inv(Al);
tic;
while norm(x0 - x, inf) > e && k < N
    k = k + 1;
    x0 = x;
    x = -iAl * (A - Al) * x0 + iAl * b;
    x';
end
toc;
if k == N, disp('已达到最大迭代次数！'); end