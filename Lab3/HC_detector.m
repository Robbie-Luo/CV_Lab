function [ ] = harris_corner_detector()

clear all 

img = imread("person_toy/00000001.jpg");

% This is really weird!  Why dont we detect edges when we work with
% normalized images!
% img = im2double(img);

img = rgb2gray(img);

% Do edge detection with first order gerivative of a Guassian  
G = fspecial('gaussian', [7,7], 2) ;
[Gx, Gy] = gradient(G) ;

img_edges_x = conv2(img, Gx, 'same') ;
img_edges_y = conv2(img, Gy, 'same') ;


% Calculate the directio derivative in both directions.
G_kernel_x = fspecial('gaussian', [1,7], 1.3) ;
G_kernel_y = fspecial('gaussian', [7,1], 1.3) ;

% Aplify the gradient to get more signal AND use gaussian kernel for smoothing 
A =  conv2(img_edges_x .^2, G_kernel_x, 'same') ;
Ix = conv2(img_edges_x .^2, G_kernel_x, 'same') ;
C = conv2(img_edges_y .^2, G_kernel_y, 'same') ;
Iy = conv2(img_edges_y .^2, G_kernel_y, 'same') ;
B = conv2(img_edges_x .* img_edges_y, G, 'same') ; 
Ixy = conv2(img_edges_x .* img_edges_y, G, 'same') ; 

% Now, Ix, Iy are smoothed derivatives of the image 

% Alternatively, matrix Q should be apmplified even more => this does not
% work! Ix and Iy have values close to zero. 
% A = Ix .^2 ;
% C = Iy .^2 ;
% B = Ix .* Iy ;


% Compute the sum of products ie smoothing 
H = (A.*C - B.^2) - 0.04.*((A+C).^2) ;


%% Aproach nr 1: wrong, but still can produce more or less correct result
% Now, compare all the values with their neighbours 

% lets get the means of the columns, create a fishie threshold
mu = mean(H) ;
th = max(mu) - median(mu) ; 

% create a mask
mask = H>th ;  

% use the mask to remove low values 
result_1 = H .* mask ;

%% Approach nr 2: what they describe in the assignment, this is very slow:(
window = [17, 17] ;

A = zeros(size(img,1), size(img,2)) ;

for i = 1: size(H,1) - window(1) 
    for j = 1:size(H, 2) - window(2)  
        
        th = max(max(H(i: i + window(1), j: j + window(2)))) - max(max(H(i: i + window(1), j: j + window(2))))*0.1  ;
        
        if H(i,j) > th
            A(i,j) = H(i,j) ; 
        else
            % do nothing
        end
    end 
end 

% we can actually skip this part coz nothing is that part of the pic :P
for i = size(H,1) : -1 :  size(H,1) - window(1) 
    for j =  size(H,2) : -1 : size(H, 2) - window(2)
        
        th = max(max(H(i: i - window(1), j: j - window(2)))) - mean(mean(H(i: i - window(1), j: j - window(2)))) ;
        
        if H(i,j) > th  
            A(i,j) = H(i,j) ; 
        else
            % do nothing
        end
    end 
end 

result_2 = A ;

fig1 = figure(1) ; 
imshow(img) ;
fig1 = title('Original image') ;

fig2 = figure(2) ;
imshow(H) ;
fig2 = title('H matrix') ;

fig3 = figure(3) ;
imshow(result_1) ; 
fig3 = title('no neighborhood approach') ;

fig4 = figure(4) ;
imshow(result_2) ;
fig4 = title('neighborhood approach') ;


end
