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

%%Smoothing (Averaging) Filter

% Convert G to double for proper convolution
G_double = double(noisy_combine_image);

% Define a smoothing kernel (can also use fspecial function)
smoothing_kernel = (1/8) * [ 1 1 1; 
                             1 1 1; 
                             1 1 1];

% Apply convolution (may need to use imfilter when using fspecial) 
smoothing_result = conv2(G_double, smoothing_kernel, 'same');


%%Median Filter

%%Smootinng-Median Filter



% Display original and noisy image
% figure;
% subplot(1,3,1);
% imshow(G);
% title('Original Image');
% 
% subplot(1,3,2);
% imshow(noisy_salt_image);
% title('Salt & Pepper Noise');
% 
% subplot(1,3,3);
% imshow(noisy_guaus_image);
% title('Gaussian Noise');
% 
% figure;
% subplot(1,2,1);
% imshow(noisy_guaus_image);
% title('Gaussian Image');
% 
% subplot(1,2,2);
% imshow(noisy_combine_image);
% title('Salt & Pepper and Gaussian');

figure;
subplot(1,2,1);
imshow(noisy_combine_image);
title('Salt & Pepper and Gaussian');

subplot(1,2,2);
imshow(smoothing_result, []);
title('Smooth Filter');

