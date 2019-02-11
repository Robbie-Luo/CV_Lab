function [ albedo, normal ] = estimate_alb_nrm( image_stack, scriptV, shadow_trick)
%COMPUTE_SURFACE_GRADIENT compute the gradient of the surface
%   image_stack : the images of the desired surface stacked up on the 3rd
%   dimension
%   scriptV : matrix V (in the algorithm) of source and camera information
%   shadow_trick: (true/false) whether or not to use shadow trick in solving
%   	linear equations
%   albedo : the surface albedo
%   normal : the surface normal


[h, w, ~] = size(image_stack);
if nargin == 2
    shadow_trick = true;
end

% create arrays for 
%   albedo (1 channel)
%   normal (3 channels)
albedo = zeros(h, w, 1);
normal = zeros(h, w, 3);

% =========================================================================
% YOUR CODE GOES HERE

% Author:Robbie
% Date:2-7-2019

% for each point in the image array
warning off
for x=1:h
    for y=1:w
        %   stack image values into a vector i
        i=reshape(image_stack(x,y,:),[],1);
        %   construct the diagonal matrix scriptI
        I_diag=diag(i);
        %   solve scriptI * scriptV * g = scriptI * i to obtain g for this point
        if shadow_trick == false
            g=linsolve(scriptV,i);
        else
            g=linsolve(I_diag*scriptV,I_diag*i);
        end
        %   albedo at this point is |g|
        albedo(x,y,:)=norm(g);
        %   normal at this point is g / |g|
        normal(x,y,:)=g/norm(g);
    end
    
% =========================================================================

end

end

