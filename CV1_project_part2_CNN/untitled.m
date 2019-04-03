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
