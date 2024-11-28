function yy = nalagr(x, y, xx)
% 用途： Lagrange 插值法数值求解
% 格式： yy =nalagr(x, y, xx) 
% x 是节点向量，y是节点上的函数值，xx是插值点，yy返回插值
m = length(x); n = length(y);
if m ~= n, error('向量 x 与 y 的长度必须一致'); end

s = 0;
for i = 1 : n
    t = ones(1, length(xx));
    for j = [1 : i - 1, i + 1 : n] 
        t = t .* (xx - x(j)) / (x(i) - x(j)); % 求拉格朗日基函数
    end
    s = s + t * y(i); 
end

yy = s;