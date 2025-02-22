%% Question 2

%applying some noise
noise = imnoise(I, 'salt & pepper', 0.05);

noise_gray = im2gray(noise);

noise_double = double(noise_gray);

%guassian filter
gaussian_kernel = (1/16) * [ 1 2 1; 
                            2 4 2; 
                            1 2 1];
%apply convolution
gaussian_result = conv2(noise_double, gaussian_kernel, 'same');

figure;
subplot(1,2,1);
imshow(noise_gray, []);
title('Noise in grayscale');

subplot(1,2,2);
imshow(gaussian_result, []);
title('Gaussian filter');