function x = hidden_selected_nagauss(a, b, flag)
    tic;
% Gaussian elimination with selected column pivot elements solves linear systems of equations ax = b
% a: Coefficient matrix  b: The right column vector
% flag: Showing intermediate processes, default as 0
% x: Solution vector
    if nargin < 3
        flag = 0;
    end
    n = length(b);
    a = [a, b];

    for k = 1 : (n - 1)
        % Select the column pivot
        [~, p] = max(abs(a(k:n, k)));                % Find the relative position of the largest number in absolute value
        p = p + k - 1;                                      % Converts relative position to absolute position
        if p > k                                                % Swap lines
            t = a(k, :);
            a(k, :) = a(p, :);
            a(p, :) = t;
        end

        % Elimination of elements
        for j = (k + 1) : n
            a(j, k+1:end) = a(j, k+1:end) - a(j, k) / a(k, k) * a(k, k+1:end);
            a(j, k) = 0;
            if flag == 0
                a;
            end
        end
    end

    % Back substitution
    x = zeros(n, 1);
    x(n) = a(n, n+1) / a(n, n);
    for k = n - 1 : -1 : 1
        x(k) = (a(k, n+1) - a(k, k+1:n) * x(k+1:n)) / a(k, k);
    end
    toc;
end