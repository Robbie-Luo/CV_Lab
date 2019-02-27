function [PSNR] = myPSNR( orig_image, approx_image )

orig_image_double = im2double(orig_image);
approx_image_double = im2double(approx_image);

[m,n] = size(orig_image_double);

%MSE = immse(orig_image_double, approx_image_double);
MSE = 0;
for i = 1:m
    for j = 1:n
        MSE = MSE + (orig_image_double(i,j) - approx_image_double(i,j)).^2;
    end
end

MSE = MSE / (m*n);
RMSE = sqrt(MSE);
PSNR = 20 * log10(max(max(orig_image_double)) / RMSE);

end
