function visualize(input_image,colorspace)
figure
subplot(2, 2, 1);

Channel1 = input_image(:,:,1);
Channel2 = input_image(:,:,2);
Channel3 = input_image(:,:,3);

imshow(input_image);
title(colorspace);

subplot(2, 2, 2);
imshow(Channel1);
title('Channel 1');

subplot(2, 2, 3);
imshow(Channel2);
title('Channel 2');

subplot(2, 2, 4);
imshow(Channel3);
title('Channel 3');
end

