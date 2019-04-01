function [subset_x,subset_y,svm_subset_x,svm_subset_y] = split_training_dataset(trainx,trainy,class,subset_size)
% Input: trainx,trainy,class
% Output: subset_x,subset_y,svm_subset_x,svm_subset_y

subset_x =[];
subset_y=[];
svm_subset_x=[];
svm_subset_y=[];

count = 0;
for class_index = 1:5
    fprintf('Process the training dataset. Progress: %f \n',class_index/5.0)
    for image_index = 1:size(trainy, 2)
        if(count < subset_size)
                entry = trainx(image_index,:,:,:);
                subset_x = cat(1, subset_x, entry);
                subset_y = [subset_y,trainy(image_index)];
                count = count + 1;
        else
            if(trainy(image_index)==class(class_index))
                entry = trainx(image_index,:,:,:);
                svm_subset_x = cat(1, svm_subset_x, entry);
                svm_subset_y = [svm_subset_y,trainy(image_index)];
                count = count + 1;
            end
        end        
    end
end