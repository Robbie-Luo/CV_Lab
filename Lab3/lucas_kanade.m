clc;clear all;close all;
image_id = 'sphere';
switch image_id
    case 'synth'
        img1 = imread('synth1.pgm');
        img2 = imread('synth2.pgm');
    case 'sphere'
        img1 = rgb2gray(imread('sphere1.ppm'));
        img2 = rgb2gray(imread('sphere2.ppm'));
    otherwise
        error("Image not found");
end 
img1=im2double(img1);
img2=im2double(img2);
figure;
subplot(1,2,1)
imshow(img1);
subplot(1,2,2)
imshow(img2);
%%Divide input images on non-overlapping regions, each region being 15 × 15.   
[height,width]=size(img1);
region_size = 15; 
numRow = floor(height/region_size);
numCol = floor(width/region_size);
img1=imresize(img1,[numRow*region_size,numCol*region_size]);
img2=imresize(img2,[numRow*region_size,numCol*region_size]);

t1 = numRow*region_size-(1:numRow)*region_size+1;
t2 = numRow*region_size-(0:numRow-1)*region_size; 
t3 = (0:numCol-1)*region_size + 1; 
t4 = (1:numCol)*region_size;
k = 0;
for i = 1 : numRow
    for j = 1 : numCol
        k = k + 1;
        img1_sub = img1(t1(i):t2(i), t3(j):t4(j), :);
        img2_sub = img2(t1(i):t2(i), t3(j):t4(j), :);
        [Ix,Iy]=gradient(img1_sub);
        Ix=reshape(Ix,[region_size*region_size,1]);
        Iy=reshape(Iy,[region_size*region_size,1]);
        A=[Ix Iy];
        It=img2_sub-img1_sub;
        b=reshape(It,[region_size*region_size,1]);
        v=inv(A'*A)*A'*b;
        Vx(i,j)=v(1);
        Vy(i,j)=v(2);
    end
end
figure;
[X,Y] = meshgrid(1 : numRow ,1 : numCol);
quiver(X,Y,Vx,Vy)
