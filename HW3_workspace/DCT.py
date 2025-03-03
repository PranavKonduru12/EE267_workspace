import numpy as np
import matplotlib.pyplot as plt
from scipy.fftpack import dct, idct

# Function to generate 8x8 DCT basis functions
def dct_basis(N=8):
    basis = np.zeros((N, N, N, N))
    for u in range(N):
        for v in range(N):
            for x in range(N):
                for y in range(N):
                    alpha_u = np.sqrt(1 / N) if u == 0 else np.sqrt(2 / N)
                    alpha_v = np.sqrt(1 / N) if v == 0 else np.sqrt(2 / N)
                    basis[u, v, x, y] = alpha_u * alpha_v * np.cos(((2*x+1) * u * np.pi) / (2 * N)) * np.cos(((2*y+1) * v * np.pi) / (2 * N))
    return basis

# Display all 64 basis functions
basis_functions = dct_basis()
fig, axes = plt.subplots(8, 8, figsize=(10, 10))
for i in range(8):
    for j in range(8):
        axes[i, j].imshow(basis_functions[i, j], cmap='gray')
        axes[i, j].axis('off')
plt.suptitle("8x8 DCT Basis Functions")
plt.show()

# Example: Apply DCT and IDCT on an 8x8 block from Lena (simulated block)
lena_block = np.array([
    [52, 55, 61, 66, 70, 61, 64, 73],
    [63, 59, 55, 90, 109, 85, 69, 72],
    [62, 59, 68, 113, 144, 104, 66, 73],
    [63, 58, 71, 122, 154, 106, 70, 69],
    [67, 61, 68, 104, 126, 88, 68, 70],
    [79, 65, 60, 70, 77, 68, 58, 75],
    [85, 71, 64, 59, 55, 61, 65, 83],
    [87, 79, 69, 68, 65, 76, 78, 94]
])

# Apply 2D DCT
dct_block = dct(dct(lena_block.T, norm='ortho').T, norm='ortho')

# Reconstruct using IDCT
reconstructed_block = idct(idct(dct_block.T, norm='ortho').T, norm='ortho')

# Display original, DCT coefficients, and reconstructed image
fig, ax = plt.subplots(1, 3, figsize=(15, 5))
ax[0].imshow(lena_block, cmap='gray')
ax[0].set_title("Original 8x8 Block")
ax[1].imshow(dct_block, cmap='gray')
ax[1].set_title("DCT Coefficients")
ax[2].imshow(reconstructed_block, cmap='gray')
ax[2].set_title("Reconstructed Block")
for a in ax:
    a.axis('off')
plt.show()
