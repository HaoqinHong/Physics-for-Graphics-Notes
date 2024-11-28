function result = my_integral(func, a, b)
    % 这个函数使用梯形规则计算在a到b之间的定积分
    % func是一个函数句柄，表示你要积分的函数
    % a和b是积分的下限和上限
    % n是分割的区间数
    
    n = 1000;
    h = (b - a) / n; % 计算每个小区间的宽度
    x = a:h:b; % 创建x的值
    y = func(x); % 计算每个x的函数值
    result = h * (0.5*y(1) + sum(y(2:end-1)) + 0.5*y(end)); % 使用梯形规则计算积分
end