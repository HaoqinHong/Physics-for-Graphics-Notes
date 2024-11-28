function [x, y] = rungeKutta4(dyfun, xspan, y0, h)
% 用途：4阶Runge-Kutta法解常微分方程 y' = f(x, y), y(x0) = y0
% 格式：[x, y] = rungeKutta4(dyfun, xspan, y0, h)。
% 其中，dyfun为函数f(x, y), xspan为求解区间[x0, xN], y0为初值y(x0), h为步长，
% x返回节点，y返回数值解
    x = xspan(1):h:xspan(2);
    y = zeros(1, length(x));
    y(1) = y0;
    for n = 1:length(x) - 1
        k1 = dyfun(x(n), y(n));
        k2 = dyfun(x(n) + h / 2, y(n) + h / 2 * k1);
        k3 = dyfun(x(n) + h / 2, y(n) + h / 2 * k2);
        k4 = dyfun(x(n) + h, y(n) + h * k3);
        y(n + 1) = y(n) + (h / 6) * (k1 + 2 * k2 + 2 * k3 + k4);
    end
    x = x'; y = y';
end
