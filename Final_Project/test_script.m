% Testing Script

% Get 
n_test = 1000 ; 

% load trained svm model and centroids
load('train_output.mat') ;  

% take the test dataset, now X, Y are test sets  
load('test.mat') ;
X = reshape(X, size(X,1), 96, 96, 3) ; 

% Select how many pictures you want to classify 
selection_test = randperm(size(X, 1), n_test) ; 

% Extract word histograms from the images
X_test = X(selection_test, :, :, :) ; 
X_test_hist =  [] ;
for class=1:size(X_test, 1)
    img = reshape(X_train(i,:,:,:), 96, 96, 3) ;
    word_hist = get_word_hist(img, centroids, colour_space, sampling_type) ; 
    X_test_hist = [ X_train_hist, word_hist ] ;
end

% Evaluate for each class 
class_preds = {} ;
eval_scores = {} ; 

X_test = X(selection_test, :,:,:) ;
y_test = y(selection_tes_test_batch ;t) ;

X_test_batch = X_train_hist' ; 
y_test_batch = y_test ; 
avg_precisions = {} ; 

for i=1:size(classes, 2)
    class = classes(i) ; 
    
    % get results of the model on the test set
    [ class_preds{class}, eval_scores{class} ] = predict(models{class}, X_test_batch) ;
    
    % sorts images 
    [~, indicies] = sort(eval_scores{class}(:, 1)) ;
    imgs_sorted{class} = X_test(indicies,:,:,:) ;
    y_sorted{class} = y_test(indicies) ;
    
    % Avg precision calculation formula 
    mask = y_sorted{class} == class ;
    cum_sum = cumsum(mask) ;
    precisions = cum_sum .* mask ./ (1:length(y_sorted{class}))' ;
    avg_precisions{class} = sum(precisions) / sum(mask) ;
    
    figure(class)
    top_im = [imgs_sorted{class}(1,:,:,:), imgs_sorted{class}(2,:,:,:), imgs_sorted{class}(3,:,:,:), imgs_sorted{class}(4,:,:,:), imgs_sorted{class}(5,:,:,:)] ;
    imshow(reshape(top_im, 480, 96, 3)) ; 
   
    figure(class*2)
    bottom_imgs= [imgs_sorted{class}(end - 4,:,:,:), imgs_sorted{class}(end - 3,:,:,:), imgs_sorted{class}(end - 2,:,:,:), imgs_sorted{class}(end - 1,:,:,:), imgs_sorted{class}(end,:,:,:)] ;
    imshow(reshape(bottom_imgs, 480, 96, 3)) ; 

end

pres = 0 ; 
for class=1:size(classes,2)
    class = classes(i) ; 
    pres = pres + avg_precisions{class} ; 
end
pres = pres/size(classes,2) ;


