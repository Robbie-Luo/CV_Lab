% iid image formation
% Author:Robbie
% Date:2-14-2019
% =========================================================================
close all;clc;clear;
Albedo=im2double(imread("ball_albedo.png"));
Shading=im2double(imread("ball_shading.png"));
subplot(2,2,1)
imshow("ball.png");
title("Original Image");
subplot(2,2,2)
imshow(Albedo);
title("Albedo");
subplot(2,2,3)
imshow(Shading);
title("Shading");
subplot(2,2,4)
imshow(Albedo.*Shading);
title("Reconstructed");