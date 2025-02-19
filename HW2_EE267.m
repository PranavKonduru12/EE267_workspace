%%Question 1

%Smoothing (Averaging) Filter

% Read the image in color
% Automatically displays any image regardless of colors
image_color = imread('OriginalLena.png'); 

% Create a figure with two subplots
figure;

% Display the color image in the first subplot
%subplot(1,2,1); % (rows, columns, position)
imshow(image_color);
title('Color Image');