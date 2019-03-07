function [corners] = harris_corner_detector(img_path, blur_level, threshold, rotate, strength)
% imgRGB = imread("pingpong/0000.jpeg");
imgRGB = imread(img_path);
imgRGB = imrotate(imgRGB,rotate);

img = im2double(imgRGB);

img = imgaussfilt(img,blur_level);

img = rgb2gray(img);

corners = [];
% Calculate the direction both directions.

Ix = edge(img,'sobel','vertical');

Ix = Ix.*5; 

Iy = edge(img,'sobel','horizontal');

Iy = Iy.*5; 

figure
subplot(2,2,1);
imshow(Ix);
title('Image derivatives Ix');

subplot(2,2,2);
imshow(Iy);
title('Image derivatives Iy');

G = fspecial('gaussian').*strength;
[Gx,Gy] = gradient(G);

% Aplify the gradient to get more signal 
A =  conv2(Ix.^ 2, Gx,'same' );  % x_gradient.^2;
C =  conv2(Iy.^ 2, Gy,'same' );  % x_gradient.*y_gradient;
B =  conv2(Ix.* Iy ,G, 'same'); 

% Compute the sum of products ie smoothing 

H = (A.*C - B.^2) - 0.04*((A+C).^2);

% Check for the Non-max suppression.

[row, column] = size(H);

% Plot fighures



subplot(2,2,[3,4]);
imshow(imgRGB);
title('Original image and detected corners');
hold on
for x = 3:row-2
    for y= 3:column-2
        % Appy Non-maximum suppression with 24 neighbours(5*5 window) around each pixel.         
        if H(x,y)>0
            point1 = H(x-1,y-1);
            point2 = H(x,y-1);
            point3 = H(x+1,y-1);
            point4 = H(x-1,y);
            point5 = H(x+1,y);
            point6 = H(x-1,y+1);
            point7 = H(x,y+1);
            point8 = H(x+1,y+1);
            point9 = H(x-2,y-2);
            point10 = H(x-2,y-1);
            point11 = H(x-2,y);
            point12 = H(x-2,y+1);
            point13 = H(x-2,y+2);
            point14 = H(x-1,y-2);
            point15 = H(x-1,y+2);
            point16 = H(x,y+2);
            point17 = H(x,y-2);
            point18 = H(x+1,y+2);
            point19 = H(x+1,y-2);
            point20 = H(x+2,y-2);
            point21 = H(x+2,y-1);
            point22 = H(x+2,y);
            point23 = H(x+2,y+1);
            point24 = H(x+2,y+2);
            negibours =[point1,point2,point3,point4,point5,point6,point7,point8,point9,point10,point11,point12,point13,point14,point15,point16,point17,point18,point19,point20,point21,point22,point23,point24];
            if(H(x,y)<=max(negibours))
                H(x,y) = 0;
            end
            % Check fo the threshold.
            if(H(x,y)<threshold)
                H(x,y) = 0;
            else
                corners = [corners; [x y]];
                r = 10;
                th = 0:pi/100:2*pi;
                yunit = r * cos(th) + x;
                xunit = r * sin(th) + y;
                plot(xunit, yunit, 'LineWidth',1.5);
            end
        else
            H(x,y) = 0;
        end
    end
end
hold off

