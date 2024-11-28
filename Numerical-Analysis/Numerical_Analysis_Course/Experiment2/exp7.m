% 用二分法和牛顿迭代法求下列方程的正根
% xln(sqrt(x ^ 2 - 1) + x) - sqrt(x ^ 2 - 1) - 0.5x = 0

syms x;                                                                          % 创建符号变量 x
fun = x * log(sqrt(x ^ 2 - 1) + x) - sqrt(x ^ 2 - 1) - 0.5 * x; % 定义函数
dfun = diff(fun, x);                                                           % 求解 fun 的导数

% 将符号表达式转换为函数句柄
fun = matlabFunction(fun);
dfun = matlabFunction(dfun);

% f(2) = -0.0981 f(3) = 0.9598
x0 = 2;
x1 = 3;
e = 1e-4;

% 二分法求解正根
x = nabisect(fun, x0, x1, e)

% 牛顿迭代法求解正根
N = 500;
x = nanewton(fun, dfun, x0, e, N)
   