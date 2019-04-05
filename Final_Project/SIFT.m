function [descriptors]=SIFT(ImageSet,img_type,descriptor_type)
% Input: set of images. For example trainx = [2500,96,96,3].
%        2500 means 2500 images. 96,96 are the width and height of each
%        image. 3 means each image has three channels.
%
% Output: A collection of descriptors from all images. For example d = [128,93675]
%         128 means the number of directions. 93675 is the number of
%         descriptors.
% descriptor_type: 'sift','liop' or 'patch' 
descriptor_type = 'sift';

% Extract RGB SIFT descripters from set of images.
descriptors = [];

switch img_type
    case "opponent"
        for i = 1:size(ImageSet,1)
            R = single(squeeze(ImageSet(i,:,:,1)));
            G = single(squeeze(ImageSet(i,:,:,2)));
            B = single(squeeze(ImageSet(i,:,:,3)));
            o1 = (R - G)/sqrt(2);
            o2 = (R + G - 2*B)/sqrt(6);
            o3 = (R+G+B)/sqrt(3);
            
            I = single(rgb2gray(squeeze(ImageSet(i,:,:,:))));
            [f,d] = vl_sift(I);
            % Extract descriptors form each channel seperately.      
            [~,o1_discriptor] = vl_covdet(R, 'frames', f, 'descriptor', descriptor_type);
            [~,o2_discriptor] = vl_covdet(G, 'frames', f, 'descriptor', descriptor_type);
            [~,o3_discriptor] = vl_covdet(B, 'frames', f, 'descriptor', descriptor_type);
            % Concatenate the descriptors from three channels.     
            descriptors = cat(2,descriptors,o1_discriptor,o2_discriptor,o3_discriptor);
        end
    case "gray"
        for i = 1:size(ImageSet,1)
            I = single(rgb2gray(squeeze(ImageSet(i,:,:,:))));
            [~,d] = vl_sift(I);
            descriptors = cat(2,descriptors,d);
        end
    case "rgb"
        for i = 1:size(ImageSet,1)
            I = single(rgb2gray(squeeze(ImageSet(i,:,:,:))));
            [f,d] = vl_sift(I);

            % Extract descriptors form each channel seperately.      
            R = single(squeeze(ImageSet(i,:,:,1)));
            G = single(squeeze(ImageSet(i,:,:,2)));
            B = single(squeeze(ImageSet(i,:,:,3)));
            [~,R_discriptor] = vl_covdet(R, 'frames', f,'descriptor', descriptor_type);
            [~,G_discriptor] = vl_covdet(G, 'frames', f,'descriptor', descriptor_type);
            [~,B_discriptor] = vl_covdet(B, 'frames', f,'descriptor', descriptor_type);

            % Concatenate the descriptors from three channels.     
            descriptors = cat(2,descriptors,R_discriptor,G_discriptor,B_discriptor);
        end
end