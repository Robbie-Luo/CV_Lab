% Function to extract features to form a visual vocabulary 

function [result_descriptors] = extract_descriptors(I, colour_space) 
% Extracts features based on SIFT; different images may have different
% number of descriptors thus do SIFT per image 
% Args:
%     I (single) : image matrix of type 
%     colour_space (sting) : identify in what colour space you want the
%                            descriptors to be extracted. Default 'rgb'
% Return:
%     matrix of 128 x n_descriptors x 3 (or 1) channels

I = single(I) ; 
result_descriptors = [] ; 

% gray and opponent colour spaces should be put explicitly, otherwise work with rgb 
switch colour_space
    case 'gray'
        I = rgb2gray(I) ;
    case 'opponent' 
        I = rgb2opponent(I) ;
    otherwise      
end 

% Approach 1: NAIVE way when each channel is treated as an individual picture
%              * Thus, for each channel extract feaures and stack 'm !
 if size(I,3) == 3
    [~, descriptors_r] = vl_sift(I(:,:, 1)) ;
    [~, descriptors_g] = vl_sift(I(:,:, 2)) ;
    [~, descriptors_b] = vl_sift(I(:,:, 3)) ;
    result_descriptors = [descriptors_r, descriptors_g, descriptors_b] ;   
elseif size(I, 3) == 1 
    [~, descriptors_single] = vl_sift(I(:,:,1)) ;
    result_descriptors = descriptors_single ; 
 end 

% Approach 2: ADVANCED extract real key points, of particular scale 
%   find the area key_point_1(x_center_1+rx,y_center_1+ry, scale/widthof
%   the square, rotation/radians) 

end









