function [centroids] = create_vocabulary_kmeans(X_descriptors) 
%  X_descriptors is 128xn_descriptors 
%       each descriptor is a 'land mark' aka feature in a image

X_descriptors = double(X_descriptors) ; 
[idx, centroids] = kmeans(X_descriptors', 400) ; 
end