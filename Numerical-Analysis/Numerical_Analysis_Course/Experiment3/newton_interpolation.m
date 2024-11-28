function yy = newton_interpolation(x, y, xx)
% 用途： Newton 插值法数值求解
% 格式： yy = newton_interpolation(x, y, xx) 
% x 是节点向量，y是节点上的函数值，xx是插值点，yy返回插值
n = length(x);
if length(y) ~= n, error('向量 x 与 y 的长度必须一致'); end

% 计算差分系数表
diff_coeff = zeros(n, n);
diff_coeff(:,1) = y(:); % 第一列是 y

for j = 2:n
    for i = j:n
        diff_coeff(i,j) = (diff_coeff(i,j-1) - diff_coeff(i-1,j-1)) / (x(i) - x(i-j+1)); % 差商
    end
end

% 计算插值
yy = diff_coeff(n, n);
for i = (n-1):-1:1
    yy = yy .* (xx - x(i)) + diff_coeff(i, i); 
end