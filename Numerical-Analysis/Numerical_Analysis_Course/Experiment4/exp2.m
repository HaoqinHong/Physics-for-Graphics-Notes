% 实验6 计算积分
%（1）\int_{\infty}^{\infty} exp(-x^2) / (1 + x^2) dx

% 定义函数
f = @(x) exp(-x.^2) ./ (1 + x.^2);

% 计算积分
result = integral(f, -inf, inf);

% 显示结果
disp(result);
