% Testing Script

% load trained svm model and centroids
load('train_output.mat') ;  

% take the test dataset, now X, Y are test sets  
load('test.mat') ;
X = reshape(X, size(X,1), 96, 96, 3) ; 

% Select how many pictures you want to classify 
n_test = 1000 ; 
selection_test = randperm(size(X, 1), n_test) ; 

% Extract word histograms from the images
X_test = X(selection_test, :, :, :) ; 
X_test_hist =  [] ;
for i=1:size(X_test, 1)
    img = reshape(X_test(i,:,:,:), 96, 96, 3) ;
    word_hist = get_word_hist(img, centroids, colour_space) ; 
    X_test_hist = [X_test_hist; word_hist ] ;
end

% Predict on the test set with svm model
labels_pred = predict(svm_classifier, X_test_hist) ;
cm = confusionmat(y(selection_test), labels_pred) ; 

