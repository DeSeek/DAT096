% Discrete Cosine Transformation via MATLAB
% version alpha 2025-2-6
% just a demo, should be modifed and optimized
% Written by Yuxin Xia, assisted by DeepSeek AI
% 图像分块DCT变换演示
% Image Block-wise 8x8 DCT Transformation Demo
clear; clc; close all;    % Refreshing
%% Image reading and preprocessing 
originalImg = imread('goldenball.png'); % Read input image
if size(originalImg,3) == 3
    originalImg = rgb2gray(originalImg); % Convert to grayscale
end
originalImg = im2double(originalImg); % Convert to double precision
[height, width] = size(originalImg);

%% 8*8 seperating DCT
% Apply block processing with DCT2
dctImg = blockproc(originalImg, [8 8], @(block) dct2(block.data));

%% Visualize DCT Coefficients
% Logarithmic scaling for better coefficient visualization
figure('Name','DCT Transform Results');
subplot(2,2,1), imshow(originalImg), title('Original Image');
ylabel('Colormap: HSV');
colormap hsv; freezeColors;
subplot(2,2,2), imshow(log10(abs(dctImg) + 1e-5), []);
title('8x8 Block DCT Coefficients (Log Scale)');
colormap hsv; colorbar; freezeColors;
subplot(2,2,3), imshow(originalImg), title('Original Image');
ylabel('Colormap: JET');
subplot(2,2,4), imshow(log10(abs(dctImg) + 1e-5), []);
title('8x8 Block DCT Coefficients (Log Scale)');
colormap jet; colorbar;
%% Inverse DCT and image reconstruction
% Apply block-wise IDCT transformation
recoveredImg = blockproc(dctImg, [8 8], @(block) idct2(block.data));

% Crop to original dimensions (handle block size mismatch)
recoveredImg = recoveredImg(1:height, 1:width);

%% Results Comparison and Error Analysis
figure('Name','Reconstruction Comparison');
subplot(2,2,1), imshow(originalImg), title('Original Image');
subplot(2,2,2), imshow(recoveredImg), title('Reconstructed Image');
subplot(2,2,3), imshow(abs(originalImg - recoveredImg), [])
title('Difference Map'); colorbar;

vryoriImg = imread("goldenball.png");
% Show the very original image
subplot(2,2,4), imshow(vryoriImg), title('The Most Original Image');

% Calculate PSNR for quality evaluation
mse = mean((originalImg(:) - recoveredImg(:)).^2);
psnrValue = 10*log10(1/mse);
fprintf('Reconstructed Image PSNR: %.2f dB\n', psnrValue);

