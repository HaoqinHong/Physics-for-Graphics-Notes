% 试用最小二乘方法找出这一天的气温变化规律
% 考虑下列函数类型，计算误差平方和，并作图比较效果。
% （1）	二次函数
% （2）	三次函数
% （3）	四次函数
% （4）	函数C = aexp[-b(t - c)^2]

% 数据
hours = [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24];
temperature = [15 14 14 14 14 15 16 18 20 22 23 25 28 31 32 31 29 27 25 24 22 20 18 17 16];

% 拟合二次函数
p2 = nafit(hours, temperature, 2);
y2 = polyval(p2, hours);
err2 = sum((y2 - temperature).^2);

% 拟合三次函数
p3 = nafit(hours, temperature, 3);
y3 = polyval(p3, hours);
err3 = sum((y3 - temperature).^2);

% 拟合四次函数
p4 = nafit(hours, temperature, 4);
y4 = polyval(p4, hours);
err4 = sum((y4 - temperature).^2);

% 拟合函数 C = aexp[-b(t - c)^2]
fun = @(p,x) p(1)*exp(-p(2)*(x-p(3)).^2);
p0 = [1,0.1,12]; % 初始参数
p = lsqcurvefit(fun,p0,hours,temperature);
y5 = fun(p, hours);
err5 = sum((y5 - temperature).^2);

% 绘图
figure;
plot(hours, temperature, 'ko', 'MarkerFaceColor', 'k'); hold on;
plot(hours, y2, 'r-', 'LineWidth', 2);
plot(hours, y3, 'g-', 'LineWidth', 2);
plot(hours, y4, 'b-', 'LineWidth', 2);
plot(hours, y5, 'm-', 'LineWidth', 2);
legend('气温', '二次函数', '三次函数', '四次函数', '高斯函数');
title('Least Squares Fit to Temperature Data');
hold off;

% 输出误差平方和
fprintf('二次函数误差平方和: %.2f\n', err2);
fprintf('三次函数误差平方和: %.2f\n', err3);
fprintf('四次函数误差平方和: %.2f\n', err4);
fprintf('高斯函数误差平方和: %.2f\n', err5);