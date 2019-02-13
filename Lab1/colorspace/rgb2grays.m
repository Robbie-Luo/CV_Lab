function [output_image] = rgb2grays(input_image)
% converts an RGB into grayscale by using 4 different methods
% converts an RGB image into normalized rgb
R = input_image(:,:,1);
G = input_image(:,:,2);
B = input_image(:,:,3);

n = input('Enter a number: ');

switch n
    case 1
        % ligtness method
        output_image = (max(max(R,G),B) + min(min(R,G),B))./2;
    case 2
        % average method
        output_image = (R+G+B)./3;
    case 3
        % luminosity method
        output_image = 0.21.*R + 0.72.*G + 0.07.*B;
    case 4
        % built-in MATLAB function 
        output_image = rgb2gray(input_image);
end
end

