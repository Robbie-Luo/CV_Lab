% run('VLFEATROOT/toolbox/vl_setup');
clc;clear all;close all;
Ia=imread("boat1.pgm");
Ib=imread("boat2.pgm");
[fa,fb]=keypoint_matching(Ia,Ib);
[best_trans,best_count]=RANSAC(fa,fb)
% transform using imwarp
figure(1);
subplot(1,2,1)
T=[best_trans(1) -best_trans(2) 0;
   -best_trans(3) best_trans(4) 0;
   best_trans(5) best_trans(6) 1;];
tform = affine2d(T);
Ia_t=imwarp(Ia,tform,'nearest');
imshow(Ia_t);
title("Image1 transformed");
subplot(1,2,2)
imshow(Ib)
title("Image2");

[best_trans,best_count]=RANSAC(fb,fa)
% transform using imwarp
figure(2);
subplot(1,2,1)
T=[best_trans(1) -best_trans(2) 0;
   -best_trans(3) best_trans(4) 0;
   best_trans(5) best_trans(6) 1;];
tform = affine2d(T);
Ib_t=imwarp(Ib,tform,'nearest');
imshow(Ib_t);
title("Image2 transformed")
subplot(1,2,2)
imshow(Ia)
title("Image1");
