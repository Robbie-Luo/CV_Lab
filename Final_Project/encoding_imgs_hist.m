function [svm_subset_histogram]= encoding_imgs_hist(centroids,svm_subset_x,clusters,sampling_method,img_type)
%  Encoding Features Using Visual Vocabulary
%  Representing images by frequencies of visual words
svm_subset_histogram = zeros(size(svm_subset_x,1),clusters);

for i = 1:size(svm_subset_x,1)
    
    d = feature_extraction(svm_subset_x(i,:,:,:),sampling_method,img_type);
    d = d';
    [num, ~] = size(d);
    histo = zeros(clusters, 1);
    for s = 1:num
        closest = -1;
        closest_distance = Inf;
        for v = 1:clusters
            distance = norm(centroids(v,:) - double(d(s,:)));
            if distance < closest_distance
                closest = v;
                closest_distance = distance;
            end
        end
        histo(closest, 1) = histo(closest, 1) +1;
    end

    
    svm_subset_histogram(i,:) = histo/sum(histo, 'all');
end