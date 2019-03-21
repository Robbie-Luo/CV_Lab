% Function to extract features to form a visual vocabulary 

function [result_descriptors] = extract_descriptors(I, colour_space, sampling_type) 
% Extracts features based on SIFT; different images may have different
% number of descriptors thus do SIFT per image 
% Args:
%     I (single) : image matrix of type 
%     colour_space (sting) : identify in what colour space you want the
%                            descriptors to be extracted. Default 'rgb'
% Return:
%     matrix of 128 x n_descriptors x 3 (or 1) channels

I = single(I) ; 
I_gray = rgb2gray(I) ; 
result_descriptors = [] ; 

step = 7 ; 
size_sift = 20 ; 

% gray and opponent colour spaces should be put explicitly, otherwise work with rgb 
switch colour_space
    case 'gray'
        I = rgb2gray(I) ;
    case 'opponent' 
        I = rgb2opponent(I) ;
    otherwise      
end 

switch sampling_type
    case "dense"
        % In dense sampling you select every step-th pixel, transform to 
        % sift space and return as feature
         if size(I,3) == 3
            [~, descriptors_r] = vl_dsift(I(:,:, 1), 'Step', step, 'Size', size_sift ) ;
            [~, descriptors_g] = vl_dsift(I(:,:, 2), 'Step', step, 'Size', size_sift) ;
            [~, descriptors_b] = vl_dsift(I(:,:, 3), 'Step', step, 'Size', size_sift) ;
            result_descriptors = [descriptors_r, descriptors_g, descriptors_b] ;   
        elseif size(I, 3) == 1 
            [~, descriptors_single] = vl_dsift(I(:,:,1), 'Step', step, 'Size', size_sift) ;
            result_descriptors = descriptors_single ; 
         end 
     case "keypoints"
        % find the keypoints 
        frames = vl_sift(I_gray);
        % use those keypoints to detect features of those points in each
        % channel 
         if size(I,3) == 3
            [~, descriptors_r] = vl_covdet(I(:,:, 1), 'Step', step, 'Size', size_sift, 'Frames', frames) ;
            [~, descriptors_g] = vl_covdet(I(:,:, 2), 'Step', step, 'Size', size_sift, 'Frames', frames) ;
            [~, descriptors_b] = vl_covdet(I(:,:, 3), 'Step', step, 'Size', size_sift, 'Frames', frames) ;
            result_descriptors = [descriptors_r, descriptors_g, descriptors_b] ;   
        elseif size(I, 3) == 1 
            [~, descriptors_single] = vl_dsift(I(:,:,1), 'Step', step, 'Size', size_sift) ;
            result_descriptors = descriptors_single ; 
         end 
end

% Approach 2: ADVANCED extract real key points, of particular scale 
%   find the area key_point_1(x_center_1+rx,y_center_1+ry, scale/widthof
%   the square, rotation/radians) 

end









