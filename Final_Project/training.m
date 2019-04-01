%% Load data and do the split for vocabulary creation and svm training

run('VLFEATROOT/toolbox/vl_setup')
clc;clear all;close all;

% data_x= load("trainx.mat");
% data_y = load("trainy.mat");
% 
% trainx = data_x.trainx;
% trainy = data_y.trainy;

data = load("train.mat");
trainx = reshape(data.X, size(data.X,1), 96, 96, 3) ;
% trainx = trainx(1:1000, :,:,:) ; 
trainy = reshape(data.y, 1, size(data.y,1)) ; 
% trainy = trainy(1, 1:1000) ; 
 
% Set up global variables.
subset_size = 1500;
class = [1,2,3,7,9];
clusters = 400;
MaxIteration = 20000;

% Take subset of training images and extract their SIFT descriptors.
[subset_x,subset_y,svm_subset_x,svm_subset_y] = split_training_dataset(trainx,trainy,class,subset_size);

%% Create vocabulary 

% selection = randperm(size(subset_x,1), 1500) ;
% subset_x = subset_x(selection,:,:,:) ; 
% subset_y = subset_y(1, selection) ; 

% Extract SIFT descripters from subset images
descriptors = RGB_SIFT(subset_x);

% Perform K-means clustering.
[points,centroids]=kmeans(double(descriptors'), clusters, 'MaxIter', MaxIteration);
visual_vocabulary = centroids;

%% visualize centroids
% [coeff,score,latent] = pca(centroids)
% 
% coeff_3d = coeff(:,1:3)
% pca_centroids_3d = centroids*coeff_3d
% scatter3(pca_centroids_3d(:,1),pca_centroids_3d(:,2),pca_centroids_3d(:,3))

%% Train SVM's
%  Encoding Features Using Visual Vocabulary
%  Representing images by frequencies of visual words
svm_subset_histogram = encoding_imgs_hist(centroids,svm_subset_x,clusters);

% Train five binary classifiers.
class = [1,2,3,7,9];
SVMModel = train_SVMModels(class,svm_subset_histogram,svm_subset_y,clusters);

%% Test if we trained 
avg_prec = test_SVMModels(class, SVMModel, centroids, trainx,trainy, clusters);

