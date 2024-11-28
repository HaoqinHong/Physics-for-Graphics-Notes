% 假定某天的气温变化记录如表格, 试用MATLAB绘制气温变化曲线图
% (1) 作图描述天气变化规律
time = 0:24;
temperature = [15, 14, 14, 14, 14, 15, 16, 18, 20, 22, 23, 25, 28, 31, 32, 31, 29, 27, 25, 24, 22, 20, 18, 17, 16];
figure;
plot(time, temperature, '-o', 'LineWidth', 2);
title('一天中气温变化');
xlabel('时间 (小时)');
ylabel('温度 (°C)');
grid on;
xlim([0 24]);
ylim([min(temperature) - 5, max(temperature) + 5]);
saveas(gcf, 'temperature_variation.png');

% (2)用help或doc查询MATLAB指令dlmwrite的使用方法。
help dlmwrite
doc dlmwrite

% (3)用dlmwrite将(1)的数据输入到一个文本文件中
data = [time; temperature]';
filename = 'temperature_data.txt';
dlmwrite(filename, data, 'delimiter', ' ', 'precision', '%.2f');

% (4)从工具条HOME中选择Import Data导入上述数据文件中的数据
