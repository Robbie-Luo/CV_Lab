function [I]=stitch(Ia,Ib)
Ia=im2double(Ia);
Ib=im2double(Ib);
if size(Ia,3)==3
    [fa,fb]=keypoint_matching(rgb2gray(Ia),rgb2gray(Ib));
else
    [fa,fb]=keypoint_matching(Ia,Ib);
end

[best_trans]=RANSAC(fb,fa);
% T=[best_trans(1) -best_trans(2) 0;
%    -best_trans(3) best_trans(4) 0;
%    best_trans(5) best_trans(6) 1;];
% tform = affine2d(T);
% Ib_t=imwarp(Ib,tform,'nearest');
Ib_t = our_imwrap(Ib,best_trans);
% find corners
[h_a,w_a,~]=size(Ia);
corners_a = [0 0;0 h_a;w_a 0;w_a h_a]';

[h_b,w_b,~]=size(Ib);
corners_b = [0 0;0 h_b;w_b 0;w_b h_b]';

params=best_trans;
M = [params(1), params(2); params(3), params(4)] ; 
t = [params(5); params(6)];
corners_b_t = M * corners_b + t ; 




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
            I(j,i,:)=Ib_t(j-rec_bt(3),wbt-(ws-i)-1,:);
            end
        end
    end
end
end

