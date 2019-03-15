% Testing 

% take the test dataset, now X, Y are test sets  
load('test.mat') ; 
X = reshape(X, size(X,1), 96, 96, 3) ; 
y = Y ; 

n_test = 1000 ; 
selection_test = randperm(size(X, 1), n_test) ; 

X_test = X(selection_test, :, :, :) ; 
X_test_hist =  [] ;
for i=1:size(X_train, 1)
    img = reshape(X_test(i,:,:,:), 96, 96, 3) ;
    word_hist = get_image_words(img, centroids, colour_space) ; 
    X_test_hist = [X_test_hist; word_hist ] ;
end


% predict on the test set with svm model
labels_pred = predict(svm_classifier, X_test_hist) ;
confusionmat(y(selection_test), labels_pred) ; 

function [word_hist] = get_image_words(I, C, colour_space)
% comapre the descriptors from sift of the image I to the centroirds aka
%  words. for each centroid number (aka word) get the count how many
%  features there is
I = single(I) ; 

% extract the descriptors with the dims 128 by n_descriptors 
descriptors = extract_features(I, colour_space) ; 
descriptors_T = descriptors' ; 
distance_min = inf ; 
word_hist = zeros(1,size(C, 1)) ; 
for i=1:size(descriptors, 2)
    distannces = pdist([descriptors_T(i,:); C]) ; 
    [distance_min, pos] = min(distannces(1:127)) ; 
    word_hist(pos) = word_hist(pos) + 1 ;    
end 

end


function [result_descriptors] = extract_features(I, colour_space) 
% Extracts features based on SIFT; different images may have different
% number of descriptors thus do SIFT per image 
% Args:
%     I (single) : image matrix of type 
% Return:
%     matrix of 128 by n_descriptors x 3 (or 1) channels

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

% Approach 1: ADVANCED Extract real key points, of particular scale 
%   find the area key_point_1(x_center_1+rx,y_center_1+ry, scale/widthof
%   the square, rotation/radians) 

% Approach 1: NAIVE way when each channel is treated as an individual picture
%  for each channel extract feaures and stack 'm !
 if size(I,3) == 3
    [~, descriptors_r] = vl_sift(I(:,:,1)) ;
    [~, descriptors_g] = vl_sift(I(:,:,2)) ;
    [~, descriptors_b] = vl_sift(I(:,:,3)) ;
    % n is the min number of descriptors in either of the channels
    n_min = min([size(descriptors_r,2), size(descriptors_g,2), size(descriptors_b,2)]) ; 
    result_descriptors = [descriptors_r(:, 1:n_min), descriptors_b(:, 1:n_min) , descriptors_r(:, 1:n_min)] ;   
elseif size(I, 3) == 1 
    [~, descriptors_single] = vl_sift(I(:,:,1)) ;
    result_descriptors = descriptors_single ; 
end 

end

function [I_op] = rgb2opponent(I) 
    R  = im(:,:,1) ;
    G  = im(:,:,2) ;
    B  = im(:,:,3) ;
    O1 = (R-G)./sqrt(2) ;
    O2 = (R+G-2*B)./sqrt(6) ;
    O3 = (R+G+B)./sqrt(3) ;
    I_op = [O1; O2; O3] ;
end 