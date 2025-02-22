clc; clear; close all;

% Read input image
I = imread('pelvis.png'); % Replace with your image filename
I_gray = rgb2gray(I); % Convert to grayscale if needed
%I_gray = im2gray(I);
I_gray = im2double(I_gray); % Normalize for processing

% Apply bilateral filter
bilateral_result = imbilatfilt(I_gray, 0.1, 2); 

% Apply Nagao-Matsuyama filter (fixed implementation)
window_size = 5;
nagao_result = nagao_filter(I_gray, window_size);

% Display results
figure;
subplot(1,3,1);
imshow(I_gray, []);
title('Original Image');

subplot(1,3,2);
imshow(bilateral_result, []);
title('Bilateral Filter');

subplot(1,3,3);
imshow(nagao_result, []);
title('Nagao-Matsuyama Filter');

% ----------- Fixed Nagao-Matsuyama Filter Implementation -----------
function output = nagao_filter(I, window_size)
    [rows, cols] = size(I);
    pad_size = floor(window_size / 2);
    padded_I = padarray(I, [pad_size pad_size], 'replicate');

    output = zeros(size(I));

    for i = 1:rows
        for j = 1:cols
            % Define 5 different overlapping sub-regions
            regions = {
                padded_I(i:i+pad_size, j:j+pad_size);  % Center
                padded_I(i:i+pad_size, j:j+pad_size-1); % Left
                padded_I(i:i+pad_size, j+1:j+pad_size); % Right
                padded_I(i+1:i+pad_size, j:j+pad_size); % Bottom
                padded_I(i:i+pad_size-1, j:j+pad_size);  % Top
            };

            % Compute variance for each region
            variances = cellfun(@(x) var(x(:)), regions);

            % Find region with least variance
            [~, min_idx] = min(variances);

            % Assign the mean of the selected region
            output(i, j) = mean(regions{min_idx}(:));
        end
    end
end