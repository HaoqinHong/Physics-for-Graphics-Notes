% 分别用ode45和ode15s求解刚性方程组，并比较计算效率。
% {y}'_1 & = -1000.25y_1 + 999.75y_2 +0.5, y_1(0) = 1,
% {y}'_2 & = 999.75y_1 - 1000.25y_2 + 0.5, y_2(0) = -1,
% 0 < x < 50

% 定义微分方程
stiffODE = @(t, y) [-1000.25*y(1) + 999.75*y(2) + 0.5; 999.75*y(1) - 1000.25*y(2) + 0.5];

% 初始条件
y0 = [1; -1];

% 时间范围
tspan = [0 50];

% 使用ode45求解微分方程
tic; % 开始计时
[t_ode45, y_ode45] = ode45(stiffODE, tspan, y0);
t_ode45_elapsed = toc; % 结束计时

% 使用ode15s求解微分方程
tic; % 开始计时
[t_ode15s, y_ode15s] = ode15s(stiffODE, tspan, y0);
t_ode15s_elapsed = toc; % 结束计时

% 输出计算时间
fprintf('ode45耗时：%f秒\n', t_ode45_elapsed);
fprintf('ode15s耗时：%f秒\n', t_ode15s_elapsed);
