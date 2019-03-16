% Making the image classifier script .

% Load the feature descriptor, run only once 
run('VLFEATROOT/toolbox/vl_setup') ;
warning ('off','all');

% Helpers
%    imshow(reshape(X(7,:,:,:), 96, 96, 3))
%    w = warning ('off','all');

%  Loading data 
load('train.mat') ; 

%  Reshaping the X data
X = reshape(X, size(X,1), 96, 96, 3) ; 

% 
% ** NOTE ** Use all classes to make the vocabulary 
% 

% which colour space do you want 
colour_space = 'rgb'; 

%  Extract SIFT features (per channel==Approach 1)
%    X_vocab = data used to get the centroids aka vocabulary 
%              - select randomly some pictures for visual vocabulary building
n_vocab = 100 ; 
selection_vocab = randperm(size(X, 1), n_vocab) ; 

X_vocab = X(selection_vocab, :, :, :) ; 
X_vocab_kmeans = [] ;
for i=1:size(X_vocab, 1)
    descriptors = extract_descriptors(reshape(X(i,:,:,:), 96, 96, 3), colour_space) ; 
    X_vocab_kmeans = [X_vocab_kmeans, descriptors] ; 
end 

% Build visual vocabulary where each centroid is a word:
%      - Retrieve 'words' aka centroids 
centroids = create_vocabulary_kmeans(X_vocab_kmeans) ; 

% 
% ** NOTE ** Now train a model for ony 5 classes 
% 
 
% Select all the images which were not used for creating vocab
selection_other = setdiff(1:size(X,1), selection_vocab) ;
X = X(selection_other, :, :, :) ; 
y = y(selection_other) ; 

% Get only classes: airplanes(1), birds(2), ships(9), horses(7) and cars(3)
mask = ( y == 1 | y==2 | y == 3 | y == 9 | y == 7) ; 
X = X(mask,:,:,:) ;
y = y(mask) ;

% Select some data for traing of a model (e.g. svm)
n_train = 100 ;
selection_train = randperm(size(X, 1), n_train) ;

% Get the 'histograms' for all the other images aka image words
%   - do it per image 
X_train = X(selection_train, :, :, :) ; 
X_train_hist =  [] ;
for i=1:size(X_train, 1)
    img = reshape(X_train(i,:,:,:), 96, 96, 3) ;
    word_hist = get_word_hist(img, centroids, colour_space) ; 
    X_train_hist = [ X_train_hist; word_hist ] ;
end

% Do renaming, dont ask why :D
X_train_batch = X_train_hist ; 
y_trian_batch = y(selection_train) ; 

% Train a svm model
svm_classifier = fitcecoc(X_train_batch, y_trian_batch) ; 

% Save the data to then load in the test script 
save('train_output.mat', 'centroids', 'svm_classifier') ; 


