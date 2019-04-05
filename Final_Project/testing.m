% SVMModels Testing
% Sampling method could be dense or keypoint.
sampling_method = "dense";
% Image type could be rgb, gray or opponent.
img_type = "rgb";

% 1.Load the testing data.
data_x= load("testx.mat");
data_y = load("testy.mat");
testx = data_x.testx(1:1000,:,:,:);
testy = data_y.testy(:,1:1000);

% 2.Classification.
[MAP] = test_SVMModels(class,SVMModel,centroids,testx,testy,clusters,sampling_method,img_type);
