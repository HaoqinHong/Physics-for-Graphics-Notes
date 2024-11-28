% 编写牛顿插值法程序，求解
% 利用函数 f(x) = sqrt(x) 在 100，121，144 的值求 sqrt(115) 的近似值

% 函数定义
f = @(x) sqrt(x);

x = [100 121 144];
y = f(x);

% 牛顿插值法求解近似值
xx = 115;
yy = newton_interpolation(x, y, xx)
 
