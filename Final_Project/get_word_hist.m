function [word_hist] = get_word_hist(I, C, colour_space, sampling_size)
% Comapre the descriptors, from e.g. SIFT, of the image I to the centroirds aka
%   words. For each centroid number (aka word) get the count how many
%   features in the image (I) are close to that centorid

I = single(I) ; 

% extract the descriptors with the dims 128 x n_descriptors 
descriptors = extract_descriptors(I, colour_space, sampling_size) ; 
descriptors_T = descriptors' ; 
word_hist = zeros(1, size(C, 1)) ; 
for i=1:size(descriptors, 2)
    distannces = pdist([descriptors_T(i,:); C]) ; 
    [distance_min, pos] = min(distannces(1:127)) ; 
    word_hist(pos) = word_hist(pos) + 1 ;    
end 


end