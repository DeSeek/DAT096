import cv2
import numpy as np
import matplotlib.pyplot as plt

def dct_compress(image, block_size=8, keep_fraction=0.3):
    """对图像进行分块DCT压缩"""
    h, w = image.shape
    # 计算填充后的尺寸（确保能被block_size整除）
    h_pad = ((h + block_size - 1) // block_size) * block_size
    w_pad = ((w + block_size - 1) // block_size) * block_size
    padded = np.zeros((h_pad, w_pad), dtype=np.float32)
    padded[:h, :w] = image  # 填充边缘
    
    recon = np.zeros_like(padded)
    for i in range(0, h_pad, block_size):
        for j in range(0, w_pad, block_size):
            # 提取当前块并应用DCT
            block = padded[i:i+block_size, j:j+block_size]
            dct_block = cv2.dct(block)
            
            # 保留左上角的系数（其他置零）
            num_keep = int(block_size * keep_fraction)
            dct_block[num_keep:, :] = 0
            dct_block[:, num_keep:] = 0
            
            # 逆DCT重建块
            recon_block = cv2.idct(dct_block)
            recon[i:i+block_size, j:j+block_size] = recon_block
    
    return recon[:h, :w]  # 裁剪回原始尺寸

# 读取图像并转为灰度
image = cv2.imread('input.jpg', cv2.IMREAD_GRAYSCALE)
if image is None:
    raise FileNotFoundError("Please give an input image")

# 转换为浮点型并压缩
im_float = np.float32(image)
im_recon = dct_compress(im_float, block_size=8, keep_fraction=0.1)

# 转换为uint8类型并限制范围
im_recon = np.uint8(np.clip(im_recon, 0, 255))

# 显示结果
plt.figure(figsize=(10, 5))
plt.subplot(121), plt.imshow(image), plt.title('Original Image')
plt.subplot(122), plt.imshow(im_recon), plt.title('DCT Compression(Remain 30% Cofficent)')
plt.show()