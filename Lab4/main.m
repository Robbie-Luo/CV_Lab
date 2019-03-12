run('VLFEATROOT/toolbox/vl_setup')
clc;clear all;close all;
%% Image Alignment 
Ia=imread("boat1.pgm");
Ib=imread("boat2.pgm");
imshow([Ia Ib]) ;
[fa,fb]=keypoint_matching(Ia,Ib);

% Take a random subset (with set size set to 10) 
perm=randperm(size(fa,2));
sel=perm(1:10);

%Plot the frames
figure(1);
hold on;
h1 = vl_plotframe(fa(:,sel)) ;
set(h1,'color','y','linewidth',3) ;
fb(1,:) = fb(1,:) + size(Ia,2) ;
h2 = vl_plotframe(fb(:,sel)) ;
set(h2,'color','y','linewidth',3) ;
hold on;
[best_trans]=RANSAC(fa,fb);
for s = sel
   [x_t,y_t]=transform(fa(1,s),fa(2,s),best_trans);
   scatter(x_t,y_t,'g')
end

% Connect matching pairs with lines.
xa = fa(1,sel) ;
xb = fb(1,sel) ;
ya = fa(2,sel) ;
yb = fb(2,sel) ;
hold on ;
h = line([xa ; xb], [ya ; yb]) ;
set(h,'linewidth', 2) ;

% Perform the RANSAC algorithm
Ia=imread("boat1.pgm");
Ib=imread("boat2.pgm");
[fa,fb]=keypoint_matching(Ia,Ib);

% Transformations from image1 to image2
[best_trans]=RANSAC(fa,fb);
figure(2);
subplot(2,2,1)
T=[best_trans(1) -best_trans(2) 0;
   -best_trans(3) best_trans(4) 0;
   best_trans(5) best_trans(6) 1;];
tform = affine2d(T);
Ia_t=imwarp(Ia,tform,'nearest');
imshow(Ia_t);
title("Image1 transformed");
subplot(2,2,2)
imshow(Ib)
title("Image2");

% Transformations from image2 to image1
[best_trans]=RANSAC(fb,fa);
figure(2);
subplot(2,2,3)
T=[best_trans(1) -best_trans(2) 0;
   -best_trans(3) best_trans(4) 0;
   best_trans(5) best_trans(6) 1;];
tform = affine2d(T);
Ib_t=imwarp(Ib,tform,'nearest');
imshow(Ib_t);
title("Image2 transformed")
subplot(2,2,4)
imshow(Ia)
title("Image1");

%% Image Stitching
Ia=imread("left.jpg");
Ib=imread("right.jpg");
figure(3);
subplot(1,3,1)
imshow(Ia);
subplot(1,3,2)
imshow(Ib);
subplot(1,3,3)
I=stitch(Ia,Ib);
imshow(I);