% 求满足 \sum_{n=0}^m ln(1 + n) > 100 的最小整数 m

sum_ln = 0;
m = 0;

% 迭代求解
while sum_ln <= 100
    sum_ln = sum_ln + log(1 + m);
    m = m + 1;
end

m = m - 1;
disp(['The smallest integer m that satisfies the condition is: ', num2str(m)]);
