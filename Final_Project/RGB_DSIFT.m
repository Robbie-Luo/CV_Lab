function [descriptors]=RGB_DSIFT(ImageSet)
% Input: set of images. For example trainx = [2500,96,96,3].
%        2500 means 2500 images. 96,96 are the width and height of each
%        image. 3 means each image has three channels.
%
% Output: A collection of descriptors from all images. For example d = [128,93675]
%         128 means the number of directions. 93675 is the number of
%         descriptors.

% Extract RGB SIFT descripters from set of images.
descriptors = [];

% fprintf('Extracting RGB SIFT descripters from set of images. \n');

% For each image, Feature locations are extracted from the grayscaled image
% Then the real descriptors are extracted at those locations from each color 
% channel separately and concatenated.
for i = 1:size(ImageSet,1)
%     [f,d] = vl_sift(I);
    R = single(squeeze(ImageSet(i,:,:,1)));
    G = single(squeeze(ImageSet(i,:,:,2)));
    B = single(squeeze(ImageSet(i,:,:,3)));
    % Extract descriptors form each channel seperately.      
   [R_frames,R_discriptor] = vl_dsift(R, 'Step', 5, 'Size', 21);
   [G_frames,G_discriptor] = vl_dsift(G, 'Step', 5, 'Size', 21);
   [B_frames,B_discriptor] = vl_dsift(B, 'Step', 5, 'Size', 21);
  
    
    % Concatenate the descriptors from three channels.     
    descriptors = cat(2,descriptors,R_discriptor,G_discriptor,B_discriptor);
end
