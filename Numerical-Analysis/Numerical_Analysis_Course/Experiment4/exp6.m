% 考虑用欧拉格式、隐式欧拉格式、中点欧拉格式、改进欧拉格式、4阶经典龙格-库塔格式求解微分方程
% y’= -50y,
% 取步长h = 0.1，0.05，0.025，0.001，试验其稳定性。

dyfun = @(x, y) -50*y;
xspan = [0, 5];
y0 = 1; % 初始条件

h_values = [0.1, 0.05, 0.025, 0.001];
for h = h_values
    % 调用不同的求解方法
    [x_explicit, y_explicit] = naeuler(dyfun, xspan, y0, h);
    [x_implicit, y_implicit] = naeulerb(dyfun, xspan, y0, h);
    [x_midpoint, y_midpoint] = midpointeuler(dyfun, xspan, y0, h);
    [x_improved, y_improved] = improvedeuler(dyfun, xspan, y0, h);
    [x_rungeKutta, y_rungeKutta] = rungeKutta4(dyfun, xspan, y0, h);

    % 绘图以比较结果
    figure;
    plot(x_explicit, y_explicit, 'b', x_implicit, y_implicit, 'r', ...
         x_midpoint, y_midpoint, 'g', x_improved, y_improved, 'c', ...
         x_rungeKutta, y_rungeKutta, 'm');
    legend('Explicit Euler', 'Implicit Euler', 'Midpoint Euler', ...
           'Improved Euler', 'Runge-Kutta 4');
    title(['Solution with h = ', num2str(h)]);
    xlabel('x');
    ylabel('y');
end
