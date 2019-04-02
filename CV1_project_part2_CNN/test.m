clear all;close all;
classes = {'airplanes', 'birds', 'ships', 'horses', 'cars'};
data=[];
labels=[];
sets=[];
load('data/train.mat');
for i=1:size(X,1)
    %Select images that are in the classes set
    class=string(class_names(y(i)))+'s';
    res = find(classes==class);
    if(res) 
        %resize the image to (32,32,3)
        I=reshape(X(i,:),96,96,3);
        I2=imresize(I,[32 32]);
        data(:,:,:,end+1)=I2;
        labels(end+1)=res;
        sets(end+1)=1;
    end    
end
load('data/test.mat');
for i=1:size(X,1)
    %Select images that are in the classes set
    class=string(class_names(y(i)))+'s';
    res = find(classes==class);
    if(res) 
        %resize the image to (32,32,3)
        I=reshape(X(i,:),96,96,3);
        I2=imresize(I,[32 32]);
        data(:,:,:,end+1)=I2;
        labels(end+1)=res;
        sets(end+1)=2;
    end    
end


