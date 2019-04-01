function [avg_precisions,class_preds] = test_SVMModels(class,SVMModel,centroids,testx,testy,clusters)

count=0;
% for image_index = 1:size(testx,1)
%     test_score = zeros(1,5);
%     img_descriptor = RGB_SIFT(testx(image_index,:,:,:));
%     [~,idx_test] = pdist2(centroids,double(img_descriptor'),'euclidean','Smallest',1);
%     histogram = normalize(hist(idx_test,400),'range');
%     [~,score] = predict(SVMModel{1},histogram);
%     test_score(1) = score(2);
%     [~,score] = predict(SVMModel{2},histogram);
%     test_score(2) = score(2);
%     [~,score] = predict(SVMModel{3},histogram);
%     test_score(3) = score(2);
%     [~,score] = predict(SVMModel{4},histogram);
%     test_score(4) = score(2);
%     [~,score] = predict(SVMModel{5},histogram);
%     test_score(5) = score(2);
%     [MAX_value,index] = max(test_score);
%     if(class(index)==testy(image_index))
%         count=count+1;
%     end
% end

% for image_index = 1:size(testx,1)
%     img_descriptor = RGB_SIFT(testx(image_index,:,:,:));
%     [~,idx_test] = pdist2(centroids,double(img_descriptor'),'euclidean','Smallest',1);
%     histogram = normalize(hist(idx_test,400),'range');
%     [~,score] = predict(SVMModel{1},histogram);
%     test_score(1) = score(2);

X_test_hist = encoding_imgs_hist(centroids,testx,clusters);

% Evaluate for each class 
class_preds = {} ;
eval_scores = {} ;

avg_precisions = {} ; 
classes = [1 2 3 7 9] ;
class = 0;

for i=1:size(classes, 2)
    class = classes(i) ; 
    
    % get results of the model on the test set
    [ class_preds{class}, eval_scores{class} ] = predict(SVMModel{i}, X_test_hist) ;
    
    % sorts images 
    [~, indicies] = sort(eval_scores{class}(:, 1)) ;
    imgs_sorted{class} = testx(indicies,:,:,:) ;
    y_sorted{class} = testy(:,indicies) ;
    
    % Avg precision calculation formula 
    mask = y_sorted{class} == class ;
    cum_sum = cumsum(mask) ;
    precisions = cum_sum .* mask ./ (1:length(y_sorted{class})) ;
    avg_precisions{class} = sum(precisions) / sum(mask) ;
end
