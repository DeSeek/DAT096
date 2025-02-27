% written on 27th Feb. 2025 by Yuxin Xia
% DCT manually calculation without calling DCT function


function dct_out = dct8manual(block)
    % 计算 8x8 DCT 变换
    N = 8;
    dct_mat = zeros(N, N);
    for u = 1:N
        for x = 1:N
            if u == 1
                alpha = sqrt(1/N);
            else
                alpha = sqrt(2/N);
            end
            dct_mat(u, x) = alpha * cos((pi * (2 * (x-1) + 1) * (u-1)) / (2*N));
        end
    end
    dct_out = dct_mat * double(block) * dct_mat'; % 计算 2D DCT
end
