% Define the 8x8 image matrix G
G = [139 144 149 153 155 155 155 155;
     144 151 153 156 159 156 156 156;
     150 155 160 163 158 156 156 156;
     159 161 162 160 160 159 159 159;
     159 160 161 162 162 155 155 155;
     161 161 161 161 160 157 157 157;
     162 162 161 163 162 157 157 157;
     162 162 161 161 163 158 158 158];

% Add Gaussian noise with sigma=5
sigma = 5;
noisy_G = G + sigma * randn(size(G));

% Calculate RMSE
rmse = sqrt(mean((G(:) - noisy_G(:)).^2));

% Calculate PSNR
peak_signal = max(G(:));
psnr = 20 * log10(peak_signal / rmse);

% Calculate Entropy
normalized_hist = histcounts(G(:), 0:255, 'Normalization', 'probability');
entropy_val = -sum(normalized_hist .* log2(normalized_hist + eps));

% Display the results
fprintf('RMSE: %.4f\n', rmse);
fprintf('PSNR: %.4f dB\n', psnr);
fprintf('Entropy: %.4f\n', entropy_val);
