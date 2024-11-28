% 用拉格朗日插值作出 Runge 现象的图像

% 定义 Runge 函数
runge = @(x) 1 ./ (1 + x .^ 2);

% 定义插值点
xx = linspace(-5, 5, 1000);

% 5 等分
x5 = linspace(-5, 5, 5);
y5 = runge(x5);
yy5 = nalagr(x5, y5, xx);

% 10 等分
x10 = linspace(-5, 5, 10);
y10 = runge(x10);
yy10 = nalagr(x10, y10, xx);

% 绘制 Runge 函数和插值函数
figure;
subplot(2,1,1);
plot(xx, runge(xx), 'r-', 'LineWidth', 2); hold on;
plot(xx, yy5, 'b--', 'LineWidth', 2); hold off;
legend('Runge Function', 'Lagrange Interpolation (5 divisions)');
title('Runge Phenomenon with 5 divisions');

subplot(2,1,2);
plot(xx, runge(xx), 'r-', 'LineWidth', 2); hold on;
plot(xx, yy10, 'b--', 'LineWidth', 2); hold off;
legend('Runge Function', 'Lagrange Interpolation (10 divisions)');
title('Runge Phenomenon with 10 divisions');