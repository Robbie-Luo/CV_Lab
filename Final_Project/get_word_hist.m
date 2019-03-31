function [word_hist] = get_word_hist(I, C, colour_space, sampling_size)
% Comapre the descriptors, from e.g. SIFT, of the image I to the centroirds aka
%   words. For each centroid number (aka word) get the count how many
%   features in the image (I) are close to that centorid

I = single(I) ; 

% extract the descriptors with the dims 128 x n_descriptors 
descriptors = extract_descriptors(I, colour_space, sampling_size) ; 
% descriptors_T = descriptors' ; 
% word_hist = zeros(1, size(C, 1)) ; 
[~, idx_test] = pdist2(C,double(descriptors'), 'euclidean','Smallest', 1);
word_hist = get_histogram(idx_test, size(C,1)) ;

end

% function [svm_subset_histogram]= encoding_imgs_hist(centroids,svm_subset_x,clusters)
% %  Encoding Features Using Visual Vocabulary
% %  Representing images by frequencies of visual words
% svm_subset_histogram = zeros(size(svm_subset_x,1),clusters);
% 
% for image_index = 1:size(svm_subset_x,1)
%     img_descriptor = RGB_SIFT(svm_subset_x(image_index,:,:,:));
%     [~, idx_test] = pdist2(centroids,double(img_descriptor'),'euclidean','Smallest',1);
% %     histogram = normalize(hist(idx_test,clusters),'range') ;
%     histogram = get_histogram(idx_test, clusters) ; 
%     svm_subset_histogram(image_index,:) = histogram';
% end 
% 
% function [histogram] = get_histogram(idx_test, clusters)
% % return a normalized histogram of size [n_clusters x 1]
%     vector = tabulate(idx_test) ; 
%     histogram = vector(:, 3) ; 
%     if size(histogram,1) < clusters
%         to_pad = clusters - size(histogram,1) ;
%         histogram = [histogram; zeros(to_pad,1)] ;
%     end 
% end