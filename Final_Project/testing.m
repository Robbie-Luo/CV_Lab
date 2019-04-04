% SVMModels Testing

% 1.Load the testing data.
data_x= load("testx.mat");
data_y = load("testy.mat");
testx = data_x.testx;%(1:1000,:,:,:);
testy = data_y.testy;%(:,1:1000);
% data_x= load("trainx.mat");
% data_y = load("trainy.mat");
% testx = data_x.trainx(1:1000,:,:,:);
% testy = data_y.trainy(:,1:1000);
% 2.Testing the data.
[avg_precisions] = test_SVMModels(class,SVMModel,centroids,testx,testy,clusters);

% 3.Show the results.
