function [x, y] = naeulerb(dyfun, xspan, y0, h)
% 用途：隐式欧拉法解常微分方程 y' = f(x, y), y(x0) = y0
% 格式：[x, y] = naImplicitEuler(dyfun, xspan, y0, h)。其中，
% dyfun为函数f(x, y), xspan为求解区间[x0, xN], y0为初值y(x0), h为步长，
% x返回节点，y返回数值解

x = xspan(1):h:xspan(2);
y = zeros(size(x));
y(1) = y0;

for n = 1:length(x) - 1
    % 使用匿名函数定义隐式方程
    implicitEq = @(ynext) ynext - y(n) - h * dyfun(x(n+1), ynext);
    
    % 使用牛顿法或其他根求解方法求解隐式方程
    y(n + 1) = fsolve(implicitEq, y(n)); % 初始猜测使用 y(n)
end

x = x'; y = y';
end
