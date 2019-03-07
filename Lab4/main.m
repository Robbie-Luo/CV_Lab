clc;clear all;close all;
Ia=im2double(imread("boat1.pgm"));
Ib=im2double(imread("boat2.pgm"));
[fa,fb]=keypoint_matching(Ia,Ib);
[best_trans]=RANSAC(fa,fb)
% transform using imwarp
T=[best_trans(1) best_trans(2) 0;
   best_trans(3) best_trans(4) 0;
   best_trans(5) best_trans(6) 1;]
tform = affine2d(T);
subplot(1,2,1)
imshow(Ia)
subplot(1,2,2)
Ia_t=imwarp(Ia,tform,'nearest');
imshow(Ia_t)
