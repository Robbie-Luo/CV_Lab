run('VLFEATROOT/toolbox/vl_setup')
clc;clear all;close all;
Ia=imread("boat1.pgm");
Ib=imread("boat2.pgm");
imshow([Ia Ib]) ;
[fa,fb]=keypoint_matching(Ia,Ib);

perm=randperm(size(fa,2));
sel=perm(1:10);

hold on;
h1 = vl_plotframe(fa(:,sel)) ;
set(h1,'color','y','linewidth',3) ;
fb(1,:) = fb(1,:) + size(Ia,2) ;
h2 = vl_plotframe(fb(:,sel)) ;
set(h2,'color','y','linewidth',3) ;
hold on;
[best_trans]=RANSAC(fa,fb)
for s = sel
   [x_t,y_t]=transform(fa(1,s),fa(2,s),best_trans);
   scatter(x_t,y_t,'g')
end

xa = fa(1,sel) ;
xb = fb(1,sel) ;
ya = fa(2,sel) ;
yb = fb(2,sel) ;
hold on ;
h = line([xa ; xb], [ya ; yb]) ;
set(h,'linewidth', 1, 'color', 'r') ;

function [x_t,y_t]=transform(x,y,trans)
    x_t=trans(1,1)*x+trans(2,1)*y+trans(5,1);
    y_t=trans(3,1)*x+trans(4,1)*y+trans(6,1);
end