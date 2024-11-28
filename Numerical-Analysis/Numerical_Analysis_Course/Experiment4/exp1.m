% 实验1 用 MATLAB 指令计算下列积分
% （4）\int_{0}^{2\pi} exp(2x)sin^2(x)dx

% 定义函数
f = @(x) exp(2*x) .* (sin(x).^2);

% 计算积分
result = my_integral(f, 0, 2*pi);

% 显示结果
disp(result);