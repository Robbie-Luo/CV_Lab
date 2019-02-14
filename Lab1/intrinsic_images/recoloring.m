% recoloring
% Author:Robbie
% Date:2-14-2019
% =========================================================================
close all;clc;clear;
A=imread("ball_albedo.png");
[m n ~] = size(A);
for i=1:m
    for =1:n
        if(A(i,j,1)~=0 && A(i,j,2)~=0 && A(i,j,3)~=0)
            A(i,j,1)=0;
            A(i,j,2)=255;
            A(i,j,3)=0;
        end
    end
end
subplot(1,2,1)
imshow("ball.png");
title("Original Image");
subplot(1,2,2)
Albedo=im2double(A);
Shading=im2double(imread("ball_shading.png"));
imshow(Albedo.*Shading);
title("Recolored");
