%%Question 1

% Read the image in color
% Automatically displays any image regardless of colors
I = imread('OriginalLena.png'); 

% Convert to grayscale 
G = im2gray(I);

% Add salt & pepper noise (0.02 noise density)
noisy_salt_image = imnoise(G, 'salt & pepper', 0.05);

% Add Gaussian noise with predefined standard deviation
noisy_guaus_image = imnoise(G, 'gaussian', 0.02);

%Combine salt & pepper with gaussian noise
noisy_combine_image = imnoise(noisy_salt_image, 'gaussian', 0.02);

%Smoothing (Averaging) Filter

%Median Filter

%Smootinng-Median Filter



% Display original and noisy image
figure;
subplot(1,3,1);
imshow(G);
title('Original Image');

subplot(1,3,2);
imshow(noisy_salt_image);
title('Image with Salt & Pepper Noise');

subplot(1,3,3);
imshow(noisy_guaus_image);
title('Image with Gaussian Noise');

figure;
subplot(1,2,1);
imshow(noisy_guaus_image);
title('Gaussian Image');

subplot(1,2,2);
imshow(noisy_combine_image);
title('Salt & Pepper and Gaussian');

