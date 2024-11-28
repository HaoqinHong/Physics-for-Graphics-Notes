% 用 MATLAB 函数表示下列函数, 并作图
% p(x, y) = 0.5457exp(-0.75y^2 - 3.75x^2 - 1.5x),  x + y > 1
% p(x, y) = 0.7575exp(-y^2 - 6x^2),                -1 < x + y <= 1
% p(x, y) = 0.5457exp(-0.75y^2 - 3.75x^2 + 1.5x),  x + y <= -1

% 定义x和y的范围
x = linspace(-2, 2, 100);
y = linspace(-2, 2, 100);

% 生成网格
[X, Y] = meshgrid(x, y);

% 计算p的值
P1 = 0.5457 * exp(-0.75 * Y.^2 - 3.75 * X.^2 - 1.5 * X) .* (X + Y > 1);
P2 = 0.7575 * exp(-Y.^2 - 6 * X.^2) .* (-1 < X + Y & X + Y <= 1);
P3 = 0.5457 * exp(-0.75 * Y.^2 - 3.75 * X.^2 + 1.5 * X) .* (X + Y <= -1);

% 绘制函数
surf(X, Y, P1 + P2 + P3);
title('Function p(x, y)');
xlabel('x');
ylabel('y');
zlabel('p(x, y)');