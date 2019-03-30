run('VLFEATROOT/toolbox/vl_setup')
clc;clear all;close all;

% data_x= load("trainx.mat");
% data_y = load("trainy.mat");
% 
% trainx = data_x.trainx;
% trainy = data_y.trainy;

data = load("train.mat");
trainx = reshape(data.X, size(data.X,1), 96, 96, 3) ;
trainy = reshape(data.y, 1, size(data.y,1)) ; 
 
% Set up global variables.
subset_size = 100;
class = [1,2,3,7,9];
clusters = 600;
MaxIteration = 20000;

% Take subset of training images and extract their SIFT descriptors.
[subset_x,subset_y,svm_subset_x,svm_subset_y] = split_training_dataset(trainx,trainy,class,subset_size);

% Extract SIFT descripters from subset images
descriptors = RGB_SIFT(subset_x);

% Perform K-means clustering.
[points,centroids]=kmeans(double(descriptors'),clusters, 'MaxIter',MaxIteration);
visual_vocabulary = centroids;

%  Encoding Features Using Visual Vocabulary
%  Representing images by frequencies of visual words
svm_subset_histogram = encoding_imgs_hist(centroids,svm_subset_x,clusters);

% Train five binary classifiers.
class = [1,2,3,7,9];
SVMModel = train_SVMModels(class,svm_subset_histogram,svm_subset_y,clusters);
