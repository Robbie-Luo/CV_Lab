function [X,Y,U,V] = lucas_kanade(image1,image2,region_size,corners)

img1=im2double(image1);
img2=im2double(image2);

%%Divide input images on non-overlapping regions, each region being 15 × 15.   
[height,width]=size(img1);
numRow = floor(height/region_size);
numCol = floor(width/region_size);
img1=imresize(img1,[numRow*region_size,numCol*region_size]);
img2=imresize(img2,[numRow*region_size,numCol*region_size]);
%%Define Regions
t1 = (0:numRow-1)*region_size + 1; 
t2 = (1:numRow)*region_size;
t3 = (0:numCol-1)*region_size + 1; 
t4 = (1:numCol)*region_size;
k = 0;
Res=zeros(numRow,numCol,2);
for i = 1 : numRow
    for j = 1 : numCol
        k = k + 1;
        img1_sub = img1(t1(i):t2(i), t3(j):t4(j), :);
        img2_sub = img2(t1(i):t2(i), t3(j):t4(j), :);
        %  For each region compute A, AT and b. Then, estimate optical flow
        [Ix,Iy]=gradient(img1_sub);
        Ix=reshape(Ix,[region_size*region_size,1]);
        Iy=reshape(Iy,[region_size*region_size,1]);
        A=[Ix Iy];
        It=img1_sub-img2_sub;
        b=reshape(It,[region_size*region_size,1]);
        v=inv(A'*A)*A'*b;
        Res(i,j,1)=v(1);
        Res(i,j,2)=v(2);
    end
end
figure;
imshow(img1)
hold on
offset=floor(region_size/2);
X=1+offset:region_size:numRow*region_size+offset;
Y=1+offset:region_size:numCol*region_size+offset;
U = Res(:,:,1);
V = Res(:,:,2);
quiver(X,Y,U,V,'r')
end
