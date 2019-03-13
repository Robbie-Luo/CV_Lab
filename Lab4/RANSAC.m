% Create a function that performs the RANSAC algorithm as explained above. The function should return the best  % transformation found. For visualization, show the transformations from image1 to image2 and from
% image2 to image1. Name your script as RANSAC.m.

function [best_trans]=RANSAC(fa,fb)
best_count=0;
N=100;P=10;
for n = 1:N
    perm=randperm(size(fa,2));
    xa=fa(1,perm(1:P));ya=fa(2,perm(1:P));
    xb=fb(1,perm(1:P));yb=fb(2,perm(1:P));
    % calculate the parameters
    trans=get_trans_params(xa,ya,xb,yb);
    % transform using the parameters
    count=0;
    for j=1:size(fa,2)
        [x_t,y_t]=transform(fa(1,j),fa(2,j),trans);
        if(norm([x_t-fb(1,j) y_t-fb(2,j)])<=10)
            count=count+1;
        end
    end
    if count>best_count
        best_count=count;
        best_trans=trans;
    end
end
end

function [trans] = get_trans_params(xa,ya,xb,yb)
    A=zeros(2*size(xa,2),6);b=zeros(2*size(xa,2),1);
    for i=1:size(xa,2)
       A=[A;xa(i) ya(i) 0 0 1 0;
            0 0 xa(i) ya(i) 0 1];
       b=[b;xb(i);yb(i)];
    end
    trans = pinv(A)*b;
end

function [x_t,y_t]=transform(x,y,trans)
    x_t=trans(1,1)*x+trans(2,1)*y+trans(5,1);
    y_t=trans(3,1)*x+trans(4,1)*y+trans(6,1);
end