function [fa_matches,fb_matches]=keypoint_matching(Ia,Ib)
    Ia=single(Ia);
    Ib=single(Ib);
    [fa, da] = vl_sift(Ia) ;
    [fb, db] = vl_sift(Ib) ;
    [matches, ~] = vl_ubcmatch(da, db) ;
    fa_matches = fa(:,matches(1,:));
    fb_matches = fb(:,matches(2,:));
end

    