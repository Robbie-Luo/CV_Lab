run('/Users/lianghuang/Desktop/ComputerVision/CV_Lab/Lab4/VLFEATROOT/toolbox/vl_setup')
Ia=single(imread("boat1.pgm"));
Ib=single(imread("boat2.pgm"));
% I = single(I) ;
% [f,d] = vl_sift(I) ;
% perm = randperm(size(f,2)) ;
% sel = perm(1:50) ;
% h1 = vl_plotframe(f(:,sel)) ;
% h2 = vl_plotframe(f(:,sel)) ;
% set(h1,'color','k','linewidth',3) ;
% % set(h2,'color','y','linewidth',2) ;


% size(matches)
% 
% size(scores)
% figure;
% imshow("boat1.pgm");
% hold on;

% perm = randperm(size(fa,2)) ;
% sel = perm(1:50) ;
% h1 = vl_plotframe(fa(:,sel)) ;
% h2 = vl_plotframe(fa(:,sel)) ;
% set(h1,'color','k','linewidth',3) ;
% set(h2,'color','y','linewidth',2) ;


% --------------------------------------------------------------------
%                                                    Create image pair
% --------------------------------------------------------------------


% --------------------------------------------------------------------
%                                           Extract features and match
% --------------------------------------------------------------------

[fa, da] = vl_sift(Ia) ;
[fb, db] = vl_sift(Ib) ;
[matches, scores] = vl_ubcmatch(da, db) ;

perm = randperm(size(matches,2)) ;
perm = perm(1:10) ; 

matches = matches(:,perm) ;
scores = scores(perm) ;

figure(1) ; clf ;
imagesc(cat(2, Ia, Ib)) ;
axis image off ;
vl_demo_print('sift_match_1', 1) ;

figure(2) ; clf ;
% imagesc(cat(2, Ia, Ib)) ;
imshow(cat[Ia Ib]) ;

xa = fa(1,matches(1,:)) ;
xb = fb(1,matches(2,:)) + size(Ia,2) ;
ya = fa(2,matches(1,:)) ;
yb = fb(2,matches(2,:)) ;

hold on ;
h = line([xa ; xb], [ya ; yb]) ;
set(h,'linewidth', 1, 'color', 'b') ;

vl_plotframe(fa(:,matches(1,:))) ;
fb(1,:) = fb(1,:) + size(Ia,2) ;
vl_plotframe(fb(:,matches(2,:))) ;
axis image off ;

vl_demo_print('sift_match_2', 1) ;

