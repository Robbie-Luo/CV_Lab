function [ H ] = harris_corner_detector()

imgRGB = imread("person_toy/00000001.jpg");

img = im2double(imgRGB);

img = rgb2gray(img);


% Calculate the direction both directions.

Ix = edge(img,'sobel','vertical');

Iy = edge(img,'sobel','horizontal');

G = fspecial('gaussian');
[Gx,Gy] = gradient(G);

% Aplify the gradient to get more signal 
A =  conv2(Ix.^ 2, Gx,'same' );  % x_gradient.^2;
C =  conv2(Iy.^ 2, Gy,'same' );  % x_gradient.*y_gradient;
B =  conv2(Ix.* Iy ,G, 'same'); 
% Compute the sum of products ie smoothing 

H = (A.*C - B.^2) - 0.04*((A+C).^2);
threshold = 40;
% Check for the Non-max suppression.
[row, column] = size(H);
imshow(imgRGB);
hold on
for x = 2:row-1
    for y= 2:column-1
        if H(x,y)>0
            point1 = H(x-1,y-1);
            point2 = H(x,y-1);
            point3 = H(x+1,y-1);
            point4 = H(x-1,y);
            point5 = H(x+1,y);
            point6 = H(x-1,y+1);
            point7 = H(x,y+1);
            point8 = H(x+1,y+1);
            negibours =[point1,point2,point3,point4,point5,point6,point7,point8];
            if(H(x,y)<max(negibours))
                H(x,y) = 0;
            else
                H(x,y) = H(x,y)*150;
            end
            % Check fo the threshold.
            if(H(x,y)<threshold)
                H(x,y) = 0;
            else
                r = 10;
                th = 0:pi/50:2*pi;
                yunit = r * cos(th) + x;
                xunit = r * sin(th) + y;
                plot(xunit, yunit);
            end
        else
            H(x,y) = 0;
        end
    end
end
hold off

