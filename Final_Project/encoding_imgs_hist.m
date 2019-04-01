function [svm_subset_histogram]= encoding_imgs_hist(centroids,svm_subset_x,clusters)
%  Encoding Features Using Visual Vocabulary
%  Representing images by frequencies of visual words
svm_subset_histogram = zeros(size(svm_subset_x,1),clusters);

for image_index = 1:size(svm_subset_x,1)
    img_descriptor = RGB_SIFT(svm_subset_x(image_index,:,:,:)) ;
    [~, idx_test] = pdist2(centroids,double(img_descriptor'),'euclidean','Smallest',1) ;
%     histogram = normalize(hist(idx_test,clusters),'range') ;
    histogram = get_histogram(idx_test, clusters) ; 
    svm_subset_histogram(image_index,:) = histogram';
end 