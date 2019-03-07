clc;clear all;close all;
Ia=imread("boat1.pgm");
Ib=imread("boat2.pgm");
[fa_matches,fb_matches]=keypoint_matching(Ia,Ib);
subplot(1,2,1)
imshow(Ia);
hold on;
h1 = vl_plotframe(fa_matches(:,1:100)) ;
set(h1,'color','y','linewidth',3) ;

subplot(1,2,2)
imshow(Ib);
hold on;
h1 = vl_plotframe(fb_matches(:,1:100)) ;
set(h1,'color','y','linewidth',3) ;

function []=visualize_sift(f,d)
    perm = randperm(size(f,2)) ;
    sel = perm(1:50) ;
    h1 = vl_plotframe(f(:,sel)) ;
    h2 = vl_plotframe(f(:,sel)) ;
    set(h1,'color','k','linewidth',3) ;
    set(h2,'color','y','linewidth',2) ;
    h3 = vl_plotsiftdescriptor(d(:,sel),f(:,sel)) ;
    set(h3,'color','g') ;
end
