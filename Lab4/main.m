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
subplot(2,4,1)
imshow(Ia);
title("Image1");
%transform using bulit-in function
subplot(2,4,2)
Ia_t=bulit_in_imwrap(Ia,best_trans);
imshow(Ia_t);
str = sprintf('bulit-in imwarp %d*%d', size(Ia_t,2),size(Ia_t,1));
title(str);
%transform using our imwarp function
subplot(2,4,3)
Ia_t=our_imwrap(Ia,best_trans);
imshow(Ia_t);
str = sprintf('our imwarp %d*%d', size(Ia_t,2),size(Ia_t,1));
title(str);
subplot(2,4,4)
imshow(Ib);
title("Image2");

% Transformations from image2 to image1
[best_trans]=RANSAC(fb,fa);

subplot(2,4,5)
imshow(Ib);
title("Image2");
%transform using bulit-in function
subplot(2,4,6)
Ib_t=bulit_in_imwrap(Ib,best_trans);
imshow(Ib_t);
str = sprintf('bulit-in imwarp %d*%d', size(Ib_t,2),size(Ib_t,1));
title(str);
%transform using our imwarp function
subplot(2,4,7)
Ib_t=our_imwrap(Ib,best_trans);
imshow(Ib_t);
str = sprintf('our imwarp %d*%d', size(Ib_t,2),size(Ib_t,1));
title(str);
subplot(2,4,8)
imshow(Ia);
title("Image1");

%% Image Stitching
Ia=imread("boat1.pgm");
Ib=imread("boat2.pgm");
figure(3);
subplot(2,2,1)
imshow(Ia);
title("boat1.pgm");
subplot(2,2,2)
imshow(Ib);
title("boat2.pgm");
subplot(2,2,3)
I=stitch(Ia,Ib);
imshow(I);
title("boat1+boat2");
subplot(2,2,4)
I=stitch(Ib,Ia);
imshow(I);
title("boat2+boat1");

Ia=imread("left.jpg");
Ib=imread("right.jpg");
figure(4);
subplot(2,2,1)
imshow(Ia);
title("left.jpg");
subplot(2,2,2)
imshow(Ib);
title("right.jpg");
subplot(2,2,3)
I=stitch(Ia,Ib);
imshow(I);
title("left+right");
subplot(2,2,4)
I=stitch(Ib,Ia);
imshow(I);
title("right+left");

