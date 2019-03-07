clc;close all;
Ia=imread("left.jpg");
Ib=imread("right.jpg");
% Ia=imread("boat1.pgm");
% Ib=imread("boat2.pgm");
% subplot(1,3,1)
% imshow(Ia);
% subplot(1,3,2)
% imshow(Ib);
% subplot(1,3,3)
I=stitch(Ia,Ib);
imshow(I);