function [SVMModel] = train_SVMModels(class,svm_subset_histogram,svm_subset_y,clusters)

for class_index = 1:size(class,2)
    new_class_order = class;
    idx = find(new_class_order==class(class_index));
    if idx ~= 1
        temp = new_class_order(1);
        new_class_order(1) = class(class_index);
        new_class_order(class_index) = temp;
    end
    cf = svm_training(new_class_order,svm_subset_histogram,svm_subset_y,clusters);
    SVMModel{class_index} = cf;
end
   