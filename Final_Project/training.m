run('VLFEATROOT/toolbox/vl_setup')
clc;clear all;close all;

data_x= load("trainx.mat");
data_y = load("trainy.mat");

trainx = data_x.trainx;
trainy = data_y.trainy;

% Set up global variables.
subset_size = 100;
class = [1,2,3,7,9];
MaxIteration = 20000;
% classification_method can be svm or knn.
classification_method = "svm";
clusters = 300;
% Sampling method could be dense or keypoint.
sampling_method = "dense";
% Image type could be rgb, gray or opponent.
img_type = "gray";
% Descriptor type can be 'sift' or 'liop' or 'patch'
descriptor_type = 'sift';

% Take subset of training images and extract their SIFT descriptors.
[subset_x,subset_y,svm_subset_x,svm_subset_y] = split_training_dataset(trainx,trainy,class,subset_size);


% Extract SIFT descripters from subset images
descriptors = feature_extraction(subset_x,sampling_method,img_type);

% Perform K-means clustering.
[points,centroids]=kmeans(double(descriptors'),clusters, 'MaxIter',MaxIteration);
visual_vocabulary = centroids;
 
%% 

%  Encoding Features Using Visual Vocabulary
%  Representing images by frequencies of visual words
svm_subset_histogram = encoding_imgs_hist(centroids,svm_subset_x,clusters,sampling_method,img_type);

% Train five binary classifiers.
class = [1,2,3,7,9];
SVMModel = train_SVMModels(class,svm_subset_histogram,svm_subset_y,clusters,classification_method);
