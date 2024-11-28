% 用循环语句形成 Fibonacci 数列 F1 = F2 = 1, Fk = Fk-1 + Fk-2 (k>=3)
% 验证极限 Fk / Fk-1 -> (1 + sqrt(5)) / 2 (计算至两边误差小于精度1e-8)


F = [1, 1];
golden_ratio = (1 + sqrt(5)) / 2;
ratio = 0;

% 生成Fibonacci数列，并计算比值，直到误差小于1e-8
k = 3;
while abs(ratio - golden_ratio) > 1e-8
    F(k) = F(k-1) + F(k-2);
    ratio = F(k) / F(k-1);
    k = k + 1;
end

% 输出结果
disp(['Fibonacci sequence: ', num2str(F)]);
disp(['Final ratio: ', num2str(ratio)]);
