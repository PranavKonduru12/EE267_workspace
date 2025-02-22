clc; clear; close all;

% Read and normalize image
I = im2double(imread('pelvis.png')); % Change to your image

% Add noise for a clearer effect
I_noisy = imnoise(I, 'gaussian', 0, 0.01);

% Bilateral filter parameters
spatial_sigma = 3;  % Controls neighborhood size
range_sigma = 0.1;  % Controls intensity similarity
window_size = 2 * ceil(2 * spatial_sigma) + 1;

% Traditional Bilateral Filter
bilateral_result = bilateral_filter(I_noisy, spatial_sigma, range_sigma, window_size);

% Modified Bilateral Filter (Replacing G(I) with division-based approximations)
modified_result1 = modified_bilateral_filter(I_noisy, spatial_sigma, window_size, 1); % G(D)/I
modified_result2 = modified_bilateral_filter(I_noisy, spatial_sigma, window_size, 2); % G(D)/I^2

% Display results
figure;
subplot(2,2,1); imshow(I_noisy, []); title('Noisy Image');
subplot(2,2,2); imshow(bilateral_result, []); title('Traditional Bilateral Filter');
subplot(2,2,3); imshow(modified_result1, []); title('Modified Bilateral (G(D)/I)');
subplot(2,2,4); imshow(modified_result2, []); title('Modified Bilateral (G(D)/I^2)');

% Compute quantitative metrics
psnr_bilateral = psnr(bilateral_result, I);
psnr_mod1 = psnr(modified_result1, I);
psnr_mod2 = psnr(modified_result2, I);

ssim_bilateral = ssim(bilateral_result, I);
ssim_mod1 = ssim(modified_result1, I);
ssim_mod2 = ssim(modified_result2, I);

fprintf('PSNR Traditional: %.2f dB, Modified (G(D)/I): %.2f dB, Modified (G(D)/I^2): %.2f dB\n', ...
    psnr_bilateral, psnr_mod1, psnr_mod2);
fprintf('SSIM Traditional: %.4f, Modified (G(D)/I): %.4f, Modified (G(D)/I^2): %.4f\n', ...
    ssim_bilateral, ssim_mod1, ssim_mod2);

% Functions for Filters
% Traditional Bilateral Filter
function output = bilateral_filter(I, spatial_sigma, range_sigma, window_size)
    [rows, cols] = size(I);
    output = zeros(size(I));
    half_w = floor(window_size / 2);
    
    % Create spatial Gaussian kernel
    [X, Y] = meshgrid(-half_w:half_w, -half_w:half_w);
    G_spatial = exp(-(X.^2 + Y.^2) / (2 * spatial_sigma^2));
    
    % Apply filter
    for i = 1:rows
        for j = 1:cols
            % Define neighborhood
            r_min = max(i-half_w, 1);
            r_max = min(i+half_w, rows);
            c_min = max(j-half_w, 1);
            c_max = min(j+half_w, cols);
            
            % Extract neighborhood
            patch = I(r_min:r_max, c_min:c_max);
            
            % Compute intensity difference weights
            diff = patch - I(i,j);
            G_range = exp(-(diff.^2) / (2 * range_sigma^2));
            
            % Combine spatial and range weights
            weights = G_spatial(1:size(patch,1), 1:size(patch,2)) .* G_range;
            weights = weights / sum(weights(:)); % Normalize
            
            % Apply filter
            output(i,j) = sum(patch(:) .* weights(:));
        end
    end
end

% Modified Bilateral Filter
function output = modified_bilateral_filter(I, spatial_sigma, window_size, mode)
    [rows, cols] = size(I);
    output = zeros(size(I));
    half_w = floor(window_size / 2);
    
    % Create spatial Gaussian kernel
    [X, Y] = meshgrid(-half_w:half_w, -half_w:half_w);
    G_spatial = exp(-(X.^2 + Y.^2) / (2 * spatial_sigma^2));
    
    % Apply filter
    for i = 1:rows
        for j = 1:cols
            % Define neighborhood
            r_min = max(i-half_w, 1);
            r_max = min(i+half_w, rows);
            c_min = max(j-half_w, 1);
            c_max = min(j+half_w, cols);
            
            % Extract neighborhood
            patch = I(r_min:r_max, c_min:c_max);
            
            % Compute modified weight based on G(D)/I or G(D)/I^2
            if mode == 1
                weights = G_spatial(1:size(patch,1), 1:size(patch,2)) ./ max(abs(patch), 1e-5); % Avoid divide by zero
            else
                weights = G_spatial(1:size(patch,1), 1:size(patch,2)) ./ max(patch.^2, 1e-5); % Avoid divide by zero
            end
            
            weights = weights / sum(weights(:)); % Normalize
            
            % Apply filter
            output(i,j) = sum(patch(:) .* weights(:));
        end
    end
end