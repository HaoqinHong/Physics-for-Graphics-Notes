% 设 x 为一个维数为 n 的数组，编程求下列均值和标准差
% \bar{x} = 1/n * (\sum_{i=1}^n x_i)   s = \sqrt{1/(n-1) \sum_{i=1}^n (x_i ^ 2 - n * (\bar{x}) ^ 2)} 
% 就 x = (81, 70, 65, 51, 76, 66, 90, 87, 61, 77) 计算

x = [81, 70, 65, 51, 76, 66, 90, 87, 61, 77];
n = length(x);

x_bar = sum(x) / n;
s = sqrt(1/(n-1) * (sum(x .^ 2) - n * x_bar ^ 2));

disp(['Mean: ', num2str(x_bar)]);
disp(['Standard deviation: ', num2str(s)]);


