function [X_vocab_kmeans, selection_vocab] =  create_vocab_data(X, n_vocab, colour_space, sampling_type)
%  create vocabulary to get the centroids 

%  Extract SIFT features (per channel==Approach 1)
%    X_vocab = data used to get the centroids aka vocabulary 
%              - select randomly some pictures for visual vocabulary building
% n_vocab = 10 ; 
selection_vocab = randperm(size(X, 1), n_vocab) ; 

X_vocab = X(selection_vocab, :, :, :) ; 
X_vocab_kmeans = [] ;
for i=1:size(X_vocab, 1)
    descriptors = extract_descriptors(reshape(X(i,:,:,:), 96, 96, 3), colour_space, sampling_type) ; 
    X_vocab_kmeans = [X_vocab_kmeans, descriptors] ; 
end 

end 