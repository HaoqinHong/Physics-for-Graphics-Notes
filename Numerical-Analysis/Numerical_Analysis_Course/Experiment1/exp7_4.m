% 作出下列函数图像
% (7) 三条曲线合成图 y1 = sinx, y2 = sinxsin(10x), y3 = -sinx, 0 < x < π

% 定义x的范围
x = linspace(0, pi, 1000);

% 计算y的值
y1 = sin(x);
y2 = sin(x) .* sin(10*x);
y3 = -sin(x);

% 绘制曲线
plot(x, y1, x, y2, x, y3);
title('Composite Curve');
xlabel('x');
ylabel('y');
legend('y1 = sin(x)', 'y2 = sin(x)sin(10x)', 'y3 = -sin(x)');
