function x = thomas(A, b)
    tic;

    n = length(b);
    x = zeros(n, 1);
    c = zeros(n, 1);
    d = zeros(n, 1);

    c(1) = A(1, 2) / A(1, 1);
    d(1) = b(1) / A(1, 1);

    for i = 2 : n - 1
        denominator = A(i, i) - A(i, i - 1) * c(i - 1);
        c(i) = A(i, i + 1) / denominator;
        d(i) = (b(i) - A(i, i - 1) * d(i - 1)) / denominator;
    end

    d(n) = (b(n) - A(n, n - 1) * d(n - 1)) / (A(n, n) - A(n, n - 1) * c(n - 1));

    x(n) = d(n);
    for i = n - 1 : -1 : 1
        x(i) = d(i) - c(i) * x(i + 1);
    end
    toc;
end