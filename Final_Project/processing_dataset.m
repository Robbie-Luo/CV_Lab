function []=processing_dataset(train_data_name, output_name1,output_name2)
% Load the training data and testing data.
train_data = load(train_data_name);
train_X = train_data.X;
train_y = train_data.y;

% Process the training and testing data.
train_X = reshape(train_X,size(train_y,1),96,96,3);

testx=[];
testy=[];


% Select the five classes for training.
for i = 1: size(train_y)
    if ismember(train_y(i),[1,2,3,7,9])        
        entry = train_X(i,:,:,:);
        testx = cat(1, testx, entry);
        testy = [testy,train_y(i)];
    end
end

save(output_name1,'testx')
save(output_name2,'testy')


        