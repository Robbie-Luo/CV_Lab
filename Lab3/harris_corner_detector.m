function [ H ] = harris_corner_detector()

img = imread("person_toy/00000001.jpg");

img = im2double(img);

img = rgb2gray(img);


% Calculate the direction both directions.
h = [-1 0 1];
v = h';

Ix = edge(img,'sobel','vertical');

Iy = edge(img,'sobel','horizontal');

% Ix = conv2(img,h,'same');
% 
% Iy = conv2(img,v,'same');

G = fspecial('gaussian');

[Gx, Gy] = gradient(G);
% Aplify the gradient to get more signal 
A =  conv2(Ix .^ 2, Gx,'same' );  % x_gradient.^2;
C =  conv2(Iy .^ 2, Gy,'same' );  % x_gradient.*y_gradient;
B =  conv2(Ix .* Iy ,G, 'same'); 
% Compute the sum of products ie smoothing 

H = (A.*C - B.^2) - 0.04.*((A+C).^2);

imshow(H);
