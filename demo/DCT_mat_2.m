function D = dct2_manual(I)
    %% Handwritten calculation of 2D DCT
    [M, N] = size(I);  %Calculate the number of rows M and columns N of the matrix
    D = zeros(M, N);   %Create an all-zero matrix D to store the calculation results

    %Calculate DCT coefficients
    for k = 0:M-1
        for m = 0:N-1
            sum_value = 0;
            for i = 0:M-1
                for j = 0:N-1
                    sum_value = sum_value + I(i+1, j+1) * ...
                                cos(pi * (i + 0.5) * k / M) * ...
                                cos(pi * (j + 0.5) * m / N);
                end
            end

            % 计算归一化因子 α(k) 和 α(m)
            alpha_k = sqrt(1/M) * (k == 0) + sqrt(2/M) * (k > 0);
            alpha_m = sqrt(1/N) * (m == 0) + sqrt(2/N) * (m > 0);

            % 计算最终 DCT 值
            D(k+1, m+1) = alpha_k * alpha_m * sum_value;
        end
    end
end
