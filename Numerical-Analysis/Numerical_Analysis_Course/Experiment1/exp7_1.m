% 作出下列函数图像
% (3) 抛物面 z = x ^ 2 + y ^ 2, |x| < 3, |y| < 3

% 定义x和y的范围
x = -3:0.1:3;
y = -3:0.1:3;

% 生成网格
[X, Y] = meshgrid(x, y);

% 计算z的值
Z = X.^2 + Y.^2;

% 绘制抛物面
surf(X, Y, Z);
title('Parabolic Surface z = x^2 + y^2');
xlabel('x');
ylabel('y');
zlabel('z');