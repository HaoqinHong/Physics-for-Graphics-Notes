% 作出下列函数图像
% (5) 空间曲线 x = sint, y = cost, z = cos(2t), 0 < t < 2π

% 定义t的范围
t = 0:0.01:2*pi;

% 计算x, y, z的值
x = sin(t);
y = cos(t);
z = cos(2*t);

% 绘制空间曲线
plot3(x, y, z);
title('Space Curve');
xlabel('x');
ylabel('y');
zlabel('z');
