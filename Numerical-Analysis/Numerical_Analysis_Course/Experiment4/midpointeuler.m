function [x, y] = midpointeuler(dyfun, xspan, y0, h)
% 用途：中点欧拉法解常微分方程 y' = f(x, y), y(x0) = y0
% 格式：[x, y] = midpointEuler(dyfun, xspan, y0, h)。
% 其中，dyfun为函数f(x, y), xspan为求解区间[x0, xN], y0为初值y(x0), h为步长，
% x返回节点，y返回数值解
    x = xspan(1):h:xspan(2);
    y = zeros(1, length(x));
    y(1) = y0;
    for n = 1:length(x) - 1
        y_mid = y(n) + (h / 2) * dyfun(x(n), y(n));
        y(n + 1) = y(n) + h * dyfun(x(n) + h / 2, y_mid);
    end
    x = x'; y = y';
end
