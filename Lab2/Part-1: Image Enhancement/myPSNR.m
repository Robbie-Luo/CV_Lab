function [PSNR] = myfoo( orig_image, approx_image )

m = size(orig_image, 1);
n = size(approx_image, 2);

mse = 1/ (m*n) * sum(sum((orig_image - approx_image).^2)) ; 

I_max = double(max( max(orig_image) )) ; 

score_1 = 10 * log10( I_max ^2 / mse) ;

PSNR = score_1 ; 

end
