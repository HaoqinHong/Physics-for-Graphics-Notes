% 分别用 for 和 while 循环结构编写程序, 求出 K = \sum_{i=1}^{10^6} \frac{sqrt(3)}{i^2} 的值.
% 并考虑一种避免循环语句的程序设计, 比较不同算法的运行时间

% 使用for循环计算
tic
K_for = 0;
for i = 1:10^6
    K_for = K_for + sqrt(3) / i^2;
end
toc
disp(['使用for循环计算k: ', num2str(K_for)]);

% 使用while循环计算
tic
K_while = 0;
i = 1;
while i <= 10^6
    K_while = K_while + sqrt(3) / i^2;
    i = i + 1;
end
toc
disp(['使用while循环计算k: ', num2str(K_while)]);

% 避免使用循环语句 
% 向量化计算
tic
i = 1:10^6;
K_no_loop = sum(sqrt(3) ./ i.^2);
toc
disp(['避免使用循环语句计算k: ', num2str(K_no_loop)]);