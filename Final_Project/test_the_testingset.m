x= load("testx.mat");
y = load("testy.mat");

data_x = x.testx;
data_y = y.testy;
new_data_x=[];
new_data_y=[];
classes = [1 2 3 7 9];
for c = 1:5
    for index = 1: size(data_y,2)
        if data_y(:,index)==classes(c)
            entry = data_x(index,:,:,:);
            new_data_x = cat(1, new_data_x, entry);
            new_data_y = [new_data_y,data_y(index)];
        end
    end
end

