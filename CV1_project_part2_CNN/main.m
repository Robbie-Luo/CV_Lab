%% main function 
addpath 'liblinear-2.1/matlab';
addpath 'tSNE_matlab/'
%% fine-tune cnn

[net, info, expdir] = finetune_cnn();

%% extract features and train svm

% TODO: Replace the name with the name of your fine-tuned model
nets.fine_tuned = load(fullfile(expdir, 'net-epoch-40.mat')); nets.fine_tuned = nets.fine_tuned.net;
nets.pre_trained = load(fullfile('data', 'pre_trained_model.mat')); nets.pre_trained = nets.pre_trained.net; 
data = load(fullfile(expdir, 'imdb-stl.mat'));
data.images.set=single(data.images.set);
data.images.labels=single(data.images.labels);
%%
svm=train_svm(nets, data);

pre_trained_features=full(svm.pre_trained.trainset.features);
pre_trained_labels=svm.pre_trained.trainset.labels;
mappedX_pt=tsne(pre_trained_features,pre_trained_labels);
fine_tuned_features=full(svm.fine_tuned.trainset.features);
fine_tuned_labels=svm.fine_tuned.trainset.labels;
mappedX_ft=tsne(fine_tuned_features,fine_tuned_labels);
close all;
classes = {'airplanes', 'birds', 'ships', 'horses', 'cars'};
figure(1);
legend={};
for i=1:size(pre_trained_labels,1)
    legend(:,i)=classes(pre_trained_labels(i));
end
gscatter(mappedX_pt(:,1), mappedX_pt(:,2),legend');
title("pre-trained features");
figure(2);
legend={};
for i=1:size(fine_tuned_labels,1)
    legend(:,i)=classes(fine_tuned_labels(i));
end
gscatter(mappedX_ft(:,1), mappedX_ft(:,2),legend');
title("fine-tuned features");











