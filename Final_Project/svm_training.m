function [classifier] = svm_training(class,svm_subset_histogram,svm_subset_y,clusters)
% Train a SVM classifier for classification.
related_class_size = 400;
unrelated_class_size = 100;

related_class_histogram=zeros(related_class_size,clusters);
related_class_y=zeros(1,related_class_size);
count = 0;
for image_index = 1:size(svm_subset_histogram,1)
        if(svm_subset_y(image_index)==class(1)&&count<related_class_size)
            count=count+1;
            related_class_histogram(count,:) = svm_subset_histogram(image_index,:);
            related_class_y(count) = 1;
        end
end
            
unrelated_class_histogram=zeros(unrelated_class_size*4,clusters);
unrelated_class_y=zeros(1,unrelated_class_size*4);                        

for class_index = 2:5
    count = 0;
    for image_index = 1:size(svm_subset_histogram,1)
        if(svm_subset_y(image_index)==class(class_index)&&count<unrelated_class_size)
            count=count+1;
            unrelated_class_histogram(unrelated_class_size*(class_index-2)+count,:) = svm_subset_histogram(image_index,:);
            unrelated_class_y(count) = 0;
        end
    end
end


classifier = fitcsvm(cat(1,related_class_histogram,unrelated_class_histogram),cat(2,related_class_y,unrelated_class_y),'KernelFunction', 'rbf', 'Cost',[0,1;4,0]);
%fitcnb(cat(1,related_class_histogram,unrelated_class_histogram),cat(2,related_class_y,unrelated_class_y));

% fitcsvm
% count=0;
% for i=1:200
%     if predict(classifier,svm_subset_histogram(i,:)) == 1
%         count= count+1;
%     end
% end
% count
end
            
            