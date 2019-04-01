% Making the image classifier script .

% Load the feature descriptor, run only once 
% run('VLFEATROOT/toolbox/vl_setup') ;
warning ('off','all');

% Helpers
%    imshow(reshape(X(7,:,:,:), 96, 96, 3))
%    w = warning ('off','all');

%  Loading data 
load('train.mat') ; 

%  Reshaping the X data
X_all = reshape(X, size(X,1), 96, 96, 3) ; 
y_all = y ;

% ------- ** NOTE: Use all classes to make the vocabulary ** -------

% define some global variables 
colour_space = 'rgb' ; 
sampling_type = 'dense' ;
n_vocab = 1000  ;
n_train = 1000 ;
n_clusters = 400 ;
classes = [1, 2, 3, 7, 9] ; 

% Get the data to train the clustering 
[X_vocab_kmeans, selection_vocab] = create_vocab_data(X_all, n_vocab, colour_space, sampling_type) ; 

% Build visual vocabulary where each centroid is a word:
%      - Retrieve 'words' aka centroids 
centroids = create_vocabulary_kmeans(X_vocab_kmeans, n_clusters) ; 

%  ------- ** NOTE: Now train a model for ony 5 classes ** -------

% Select all the images which were not used for creating vocab
%% Getting data for training
selection_other = setdiff(1:size(X_all,1), selection_vocab) ;
X = X_all(selection_other, :, :, :) ; 
y = y_all(selection_other) ; 

% Get only classes: airplanes(1), birds(2), ships(9), horses(7) and cars(3)
mask = ( y == 1 | y==2 | y == 3 | y == 9 | y == 7) ; 
X = X(mask, :, :, :) ;
y = y(mask) ;

% Select some data for traing of a model (e.g. svm)
if size(X,1) >= n_train
    selection_train = randperm(size(X, 1), n_train) ;
else
    selection_train = randperm(size(X, 1), size(X,1)) ;
end

% Get the 'histograms' for all the other images aka image words
%   - do it per image 
X_train = X(selection_train, :, :, :) ; 
X_train_hist =  [] ;
for i=1:size(X_train, 1)
    img = reshape(X_train(i,:,:,:), 96, 96, 3) ;
    word_hist = get_word_hist(img, centroids, colour_space, sampling_type) ; 
    X_train_hist = [ X_train_hist, word_hist ] ;
end

% Do renaming, dont ask why :D
X_train_batch = X_train_hist' ; 
y_trian_batch = y(selection_train) ; 

%% Training
%  ------- ** NOTE: Train binary classifiers ** -------

models = {} ; 

for i=1:size(classes, 2)
    
    class = classes(i) ; 
    
    % binary target
    y = y_trian_batch == class ;
    
    % train a model with some penalties, at least one class should be
    % present in the data otherwise error
    models{class} = fitcsvm(X_train_batch, y, 'KernelFunction', 'rbf', 'Cost', [0,1;4,0]) ;
    
end
    
% Save the data to then load in the test script 
save('train_output.mat', 'centroids', 'models', 'colour_space', 'sampling_type', 'classes') ; 
 
%% see if trained

X_train = X_all(selection_train, :,:,:) ;
y_train = y_all(selection_train) ;

avg_precisions_train = {} ; 

for i=1:size(classes, 2)
    class = classes(i) ; 
    
    % get results of the model on the test set
    [ class_preds{class}, eval_scores{class} ] = predict(models{class}, X_train_batch) ;
    
    % sorts images 
    [~, indicies] = sort(eval_scores{class}(:, 1)) ;
    imgs_sorted{class} = X_train(indicies,:,:,:) ;
    y_sorted{class} = y_train(indicies) ;
    
    % Avg precision calculation formula 
    mask = y_sorted{class} == class ;
    cum_sum = cumsum(mask) ;
    precisions = cum_sum .* mask ./ (1:length(y_sorted{class}))' ;
    avg_precisions_train{class} = sum(precisions) / sum(mask) ;
 end

