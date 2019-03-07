run('VLFEATROOT/toolbox/vl_setup')
Ia=single(imread("boat1.pgm"));
Ib=single(imread("boat2.pgm"));
% I = single(I) ;
% [f,d] = vl_sift(I) ;
% perm = randperm(size(f,2)) ;
% sel = perm(1:50) ;
% h1 = vl_plotframe(f(:,sel)) ;
% h2 = vl_plotframe(f(:,sel)) ;
% set(h1,'color','k','linewidth',3) ;
% set(h2,'color','y','linewidth',2) ;
[fa, da] = vl_sift(Ia) ;
[fb, db] = vl_sift(Ib) ;
[matches, scores] = vl_ubcmatch(da, db) ;