function [I]=stitch(Ia,Ib)
Ia=im2double(Ia);
Ib=im2double(Ib);
if size(Ia,3)~=1
    [fa,fb]=keypoint_matching(rgb2gray(Ia),rgb2gray(Ib));
else
    [fa,fb]=keypoint_matching(Ia,Ib);
end

[best_trans]=RANSAC(fb,fa);
T=[best_trans(1) -best_trans(2) 0;
   -best_trans(3) best_trans(4) 0;
   best_trans(5) best_trans(6) 1;];
tform = affine2d(T);
Ib_t=imwarp(Ib,tform,'nearest');

% find corners
[ha,wa,~]=size(Ia);
corners_a=[0 0 wa wa;
         0 ha 0 ha];
[hb,wb,~]=size(Ib);
corners_b=[0 0 wb wb;
         0 hb 0 hb];

wbt=size(Ib_t,2);
corners_bt=zeros(2,4);
for i = 1:4
    [x_t,y_t]=transform(corners_b(1,i),corners_b(2,i),best_trans);
    corners_bt(:,i)=[x_t;y_t];
end
corners=[corners_a corners_bt];
rec_bt=[ceil(min(corners_bt(1,:))) ceil(max(corners_bt(1,:))) ceil(min(corners_bt(2,:))) ceil(max(corners_bt(2,:)))];


%Calculate the width and height of the stitched image
ws = ceil(max(corners(1,:)));
hs = ceil(max(corners(2,:)));

if size(Ia,3)~=1
I=zeros(hs,ws,3);
else
I=zeros(hs,ws);   
end
%Generate the stitched image
for i=1:ws
    for j=1:hs
        if i<wa && j<ha
            I(j,i,:)=Ia(j,i,:);
        else
            if j>rec_bt(3) && j<rec_bt(4)-rec_bt(3)
            I(j,i,:)=Ib_t(j-rec_bt(3)+1,wbt-(ws-i)-1,:);
            end
        end
    end
end
end

