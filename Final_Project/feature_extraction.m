function [descriptors]=feature_extraction(ImageSet, sampling_method,img_type)
descriptors = [];

switch sampling_method
    case "dense"
        descriptors = DSIFT(ImageSet,img_type);
    case "keypoint"
        descriptors = SIFT(ImageSet,img_type);
end
        