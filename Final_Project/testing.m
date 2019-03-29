% SVMModels Testing

% 1.Load the testing data.
data_x= load("testx.mat");
data_y = load("testy.mat");
testx = data_x.testx;
testy = data_y.testy;

% 2.Testing the data.
[avg_precisions] = test_SVMModels(class,SVMModel,centroids,testx,testy,clusters);

% 3.Show the results.
