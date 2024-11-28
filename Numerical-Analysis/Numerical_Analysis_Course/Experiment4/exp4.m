%  用ode45，ode23和ode113解下列微分方程：
%（2）x’= 2x + 3y, y’= 2x + y, x(0) = -2.7, y(0) = 2.8, 0 < t < 10,作相平面图。

% 定义微分方程作为匿名函数
myODE = @(t, y) [2*y(1) + 3*y(2); 2*y(1) + y(2)];

% 初始条件
y0 = [-2.7; 2.8];

% 时间范围
tspan = [0 10];

% 使用不同的求解器求解ODE
[t1, y1] = ode45(myODE, tspan, y0);
[t2, y2] = ode23(myODE, tspan, y0);
[t3, y3] = ode113(myODE, tspan, y0);

% 绘制相平面图
figure;
plot(y1(:,1), y1(:,2), 'r'); % ode45的结果
hold on;
plot(y2(:,1), y2(:,2), 'g'); % ode23的结果
hold on;
plot(y3(:,1), y3(:,2), 'b'); % ode113的结果
xlabel('x');
ylabel('y');
title('相平面图');
legend('ode45', 'ode23', 'ode113');
