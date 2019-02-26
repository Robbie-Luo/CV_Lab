function [Gx, Gy, im_magnitude,im_direction] = temp_compute_gradient(image)

% Approximatoin of the gradient ('intensity gradient') in the X and Y direction <=> Sobel filter  
S_y = [1 +2 +1; 0 0 0; -1 -2 -1]; 
S_x = S_y';

% Compute the gradients in both directions by convolving image and the filter 
Gx = conv2(image, S_x, 'same');
Gy = conv2(image, S_y, 'same');

% Compute the magnitude of the gradient in both directions (i.e. their
% difference... 
im_magnitude = sqrt(Gx .^ 2 + Gy .^ 2);

% Compute the direction of the gradient
im_direction = tanh(Gy ./ Gx) .^ (-1); 

end
