% SVMModels Testing

% 1.Load the testing data.
% data_x= load("testx.mat");
% data_y = load("testy.mat");
% testx = data_x.testx;
% testy = data_y.testy;

data = load("test.mat");
testx = reshape(data.X, size(data.X,1), 96, 96, 3) ;
testx = testx(1:1000, :,:,:) ; 
testy = reshape(data.y, 1, size(data.y,1)) ; 
testy = testy(:, 1:1000) ; 

% 2.Testing the data.
[avg_precisions] = test_SVMModels(class,SVMModel,centroids,testx,testy,clusters);

% 3.Show the results.
