% 实验6 计算积分
% \iint\limits_{D}(1 + x + y^2)dydx, D 为 x^2 + y^2 <= 2x 

% 定义函数
f = @(x, y) 1 + x + y.^2;

% 定义积分区域的边界
xmin = 0;
xmax = 2;
ymin = @(x) -sqrt(2*x - x.^2);
ymax = @(x) sqrt(2*x - x.^2);

% 计算积分
result = integral2(f, xmin, xmax, ymin, ymax);

% 显示结果
disp(result);