%Question 1

% Read the image in color
% Automatically displays any image regardless of colors
image_color = imread('OriginalLena.png'); 

% Convert to grayscale
% Displays only the intensity of the image 
% through one channel. Luminance of each pixel was calculated
% based on the sensitivity of the human eye
% Y = 0.2898 * R + 0.5870 * G + 0.1140 * B
image_gray = rgb2gray(image_color);

% Create a figure with two subplots
figure;

% Display the color image in the first subplot
subplot(1,2,1); % (rows, columns, position)
imshow(image_color);
title('Color Image');

% Display the grayscale image in the second subplot
subplot(1,2,2);
imshow(image_gray);
title('Grayscale Image');

%% Question 2

%Using Prewitt matrix to convolve the image
I = imread('OriginalLena.png');
G = rgb2gray(I);

% Convert G to double for proper convolution
G = double(G);

% Define Prewitt kernel for horizontal edges
prewitt_x = [-1 0 1; -1 0 1; -1 0 1];

% Define Prewitt kernel for vertical edges
prewitt_y = [-1 -1 -1; 0 0 0; 1 1 1];

% Apply convolution with the horizontal filter
Gx_p = conv2(G, prewitt_x, 'same');

% Apply convolution with the vertical filter
Gy_p = conv2(G, prewitt_y, 'same');

% Compute the prewitt gradient magnitude (combining both filters)
G_final_p = sqrt(Gx_p.^2 + Gy_p.^2); 

% Display the results for Prewitt
% figure;
% imshow(Gx_p, []);
% title('Horizontal Edge Detection (Prewitt X)');
% 
% figure;
% imshow(Gy_p, []);
% title('Vertical Edge Detection (Prewitt Y)');

figure;
imshow(G_final_p, []);
title('Gradient Magnitude (Combined Prewitt)');

%Using Sobel matrix to convolve the image
% Define Sobel kernel for horizontal edges
sobel_x = [-1 0 1; -2 0 2; -1 0 1];

% Define Sobel kernel for vertical edges
sobel_y = [-1 -2 -1; 0 0 0; 1 2 1];

% Apply convolution with the horizontal filter
Gx_s = conv2(G, sobel_x, 'same');

% Apply convolution with the vertical filter
Gy_s = conv2(G, sobel_y, 'same');

% Compute the sobel gradient magnitude (combining both filters)
G_final_s = sqrt(Gx_s.^2 + Gy_s.^2); 

% Display the results for Sobel
% figure;
% imshow(Gx_s, []);
% title('Horizontal Edge Detection (Sobel X)');
% 
% figure;
% imshow(Gy_s, []);
% title('Vertical Edge Detection (Sobel Y)');

figure;
imshow(G_final_s, []);
title('Gradient Magnitude (Combined Sobel)');

%% Question 3

I = imread('skeleton.tif');
G = im2gray(I);

% Convert G to double for proper convolution
G = double(G);

% Define a Laplacian kernel (4-neighborhood)
laplace_kernel = [ 0 -1  0; 
                  -1  4 -1; 
                   0 -1  0];

% Apply convolution to get the Laplacian image
laplace_result = conv2(G, laplace_kernel, 'same');

% Sharpen the image by subtracting the Laplacian (scaling factor can be adjusted)
alpha = 2.5;  % Sharpen image with this value
I_sharp = G + alpha * laplace_result;

% Optionally, clip the values to [0, 255] if needed
I_sharp(I_sharp < 0) = 0;
I_sharp(I_sharp > 255) = 255;

% Display the original grayscale image
figure;
imshow(uint8(G));
title('Original Grayscale Image');

% Display the Laplacian filtered image
figure;
imshow(laplace_result, []);
title('Laplacian Filtered Image');

% Display the sharpened image
figure;
imshow(uint8(I_sharp));
title('Sharpened Image');
%% Question 4

I = imread('pelvis.png');
G = im2gray(I);

% Convert G to double for proper convolution
G = double(G);

% Define a Laplacian kernel (4-neighborhood)
laplace_kernel = [ 0 -1  0; 
                  -1  4 -1; 
                   0 -1  0];

% Apply convolution to get the Laplacian image
laplace_result = conv2(G, laplace_kernel, 'same');

% Sharpen the image by subtracting the Laplacian (scaling factor can be adjusted)
alpha = 5.0;  % Sharpen image with this value
I_sharp = G + alpha * laplace_result;

% Optionally, clip the values to [0, 255] if needed
I_sharp(I_sharp < 0) = 0;
I_sharp(I_sharp > 255) = 255;

% Display the original grayscale image
figure;
imshow(uint8(G));
title('Original Grayscale Image');

% Display the Laplacian filtered image
figure;
imshow(laplace_result, []);
title('Laplacian Filtered Image');

% Display the sharpened image
figure;
imshow(uint8(I_sharp));
title('Sharpened Image');

