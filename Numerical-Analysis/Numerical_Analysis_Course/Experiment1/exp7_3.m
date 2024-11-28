% 作出下列函数图像
% (6) 半球面 x = 2sin(\fi)cos(\theta), y = 2sin(\fi)sin(\theta), z = 2cos(\fi), 0 <= \theta <= 2\pi, 0 <= \fi <= (1/2)\pi 

% 定义\theta和\fi的范围
theta = linspace(0, 2*pi, 100);
fi = linspace(0, pi/2, 100);

% 生成网格
[Theta, Fi] = meshgrid(theta, fi);

% 计算x, y, z的值
X = 2 * sin(Fi) .* cos(Theta);
Y = 2 * sin(Fi) .* sin(Theta);
Z = 2 * cos(Fi);

% 绘制半球面
surf(X, Y, Z);
title('Hemisphere Surface');
xlabel('x');
ylabel('y');
zlabel('z');