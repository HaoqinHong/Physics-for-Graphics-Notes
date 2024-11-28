% 牛顿迭代法解线性方程 f(x) = 0
function x = nanewton(fname, dfname, x0, e, N)
% 格式: x = nanewton(fname, dfname, x0, e, N)
% fname 和 dfname 分别为表示 f(x) 及其导函数的M函数句柄或内嵌函数
% x0 为迭代初值，e 为精度要求（默认1e-4）
% N 为计算过程中的迭代次数上限
if nargin < 5, N = 500; end
if nargin < 4, e = 1e-4; end
x = x0; 
x0 = x + 2 * e; 
k = 0;

while abs(x0 - x) > e && k < N
    k = k + 1;
    x0 = x; 
    x = x0 - fname(x0)/dfname(x0);
end

if k == N, warning('已达到迭代次数上限') ;end
    