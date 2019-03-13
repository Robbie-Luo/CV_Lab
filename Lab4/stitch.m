function [I_s]=stitch(Ia,Ib)
Ia=im2double(Ia);
Ib=im2double(Ib);
if size(Ia,3)==3
    [fa,fb]=keypoint_matching(rgb2gray(Ia),rgb2gray(Ib));
else
    [fa,fb]=keypoint_matching(Ia,Ib);
end
[best_trans]=RANSAC(fb,fa);
Ib_t = our_imwrap(Ib,best_trans);
% find corners of image1
[h_a,w_a,~]=size(Ia);
corners_a = [0 0;0 h_a;w_a 0;w_a h_a]';
% find corners of image2
[h_b,w_b,~]=size(Ib);
corners_b = [0 0;0 h_b;w_b 0;w_b h_b]';
% find corners of transformed image2
params=best_trans;
M = [params(1), params(2); params(3), params(4)] ; 
t = [params(5); params(6)];
corners_b_t = round(M * corners_b + t); 
% new corners
corners_new = [corners_a corners_b_t];
x_min = min(corners_new(1,:));
x_max = max(corners_new(1,:));
y_min = min(corners_new(2,:));
y_max = max(corners_new(2,:));
% calculate the size of the new image
w_new = x_max-x_min;
h_new = y_max-y_min;
if size(Ia,3)==1
    I_s = zeros(h_new, w_new);
    for i = 1:w_new
     for j = 1:h_new
         x_a = i + x_min;
         y_a = j + y_min;
         if x_a>=1 && x_a<=w_a && y_a>=1 && y_a<=h_a
            I_s(j,i) = Ia(y_a,x_a);
         else 
            xy_tmp = [i+x_min;j+y_min];
            xy_old = inv(M)*(xy_tmp-t);
            if xy_old(1)>=1 && xy_old(1)<=w_b && xy_old(2)>=1 && xy_old(2)<=h_b
                I_s(j,i) = Ib(round(xy_old(2)),round(xy_old(1)));
            end
         end
     end
    end
end
if size(Ia,3)==3
    I_s = zeros(h_new, w_new, 3);
    for i = 1:w_new
     for j = 1:h_new
         x_a = i + x_min;
         y_a = j + y_min;
         if x_a>=1 && x_a<=w_a && y_a>=1 && y_a<=h_a
            I_s(j,i,:) = Ia(y_a,x_a,:);
         else 
            xy_tmp = [i+x_min;j+y_min];
            xy_old = inv(M)*(xy_tmp-t);
            if xy_old(1)>=1 && xy_old(1)<=w_b && xy_old(2)>=1 && xy_old(2)<=h_b
                I_s(j,i,:) = Ib(round(xy_old(2)),round(xy_old(1)),:);
            end
         end
     end
    end
end
end

