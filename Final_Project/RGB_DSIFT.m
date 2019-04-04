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
    I = single(rgb2gray(squeeze(ImageSet(i,:,:,:))));
%     [f,d] = vl_sift(I);
    
    % Extract descriptors form each channel seperately.      
   [R_frames,d] = vl_dsift(I, 'Step', 2, 'Size', 30);
    
  
    
    % Concatenate the descriptors from three channels.     
    descriptors = cat(2,descriptors,d);%,R_discriptor,G_discriptor,B_discriptor);
end
