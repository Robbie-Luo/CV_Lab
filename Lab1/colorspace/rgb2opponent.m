function [output_image] = rgb2opponent(input_image)
% converts an RGB image into opponent color space
R = input_image(:,:,1);
G = input_image(:,:,2);
B = input_image(:,:,3);

O_1 = (R-G)./sqrt(2);
O_2 = (R+G-2.*B)./sqrt(6);
O_3 = (R+G+B)./sqrt(3);

output_image = cat(3,O_1,O_2,O_3);

imshow(output_image)
end

