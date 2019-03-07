function [x_t,y_t]=transform(x,y,trans)
    x_t=trans(1,1)*x+trans(2,1)*y+trans(5,1);
    y_t=trans(3,1)*x+trans(4,1)*y+trans(6,1);
end