% 二分法解非线性方程 f(x) = 0
function x = nabisect(fname, a, b, e)
% 格式: x = nabisect（fname, a, b, e）
% fname 为函数句柄或内嵌函数表达式 f(x)
% a, b 为区间端点, e 为精度 (默认值为1e-4), 函数在两端点值必须异号
if nargin < 4, e = 1e-4; end;
fa = fname(a); 
fb = fname(b);

if fa * fb > 0, error('函数在两端点值必须异号'); end
x = (a + b) / 2;

while (b - a) > (2 * e)
    fx = fname(x);
    if fa * fx < 0, b = x; fb = fx; else a = x; fa = fx; end
    x = (a + b) / 2;
end
    
    