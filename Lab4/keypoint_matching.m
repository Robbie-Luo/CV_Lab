% run('VLFEATROOT/toolbox/vl_setup')
function [fa_matches,fb_matches]=keypoint_matching(Ia,Ib)
    Ia=single(Ia);
    Ib=single(Ib);
    [fa, da] = vl_sift(Ia) ;
    [fb, db] = vl_sift(Ib) ;
    [matches, ~] = vl_ubcmatch(da, db) ;
    fa_matches = fa(:,matches(1,:));
    fb_matches = fb(:,matches(2,:));
end
% subplot(1,2,1);
% imshow("boat1.pgm");
% hold on;
% visualize_sift(fa,da);
% 
% subplot(1,2,2);
% imshow("boat2.pgm");
% hold on;
% visualize_sift(fb,db)





% function []=visualize_match(matches,fa,fb)
%     perm = randperm(size(matches,2)) ;
%     sel1 = matches(1,perm(1:10));
%     sel2 = matched(1,perm(1:10));
%     h1 = vl_plotframe(fa(:,sel)) ;
%     h2 = vl_plotframe(fa(:,sel)) ;
%     set(h1,'color','k','linewidth',3) ;
%     set(h2,'color','y','linewidth',2) ;
% end    
    
    