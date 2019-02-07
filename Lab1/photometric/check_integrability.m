function [ p, q, SE ] = check_integrability( normals )
%CHECK_INTEGRABILITY check the surface gradient is acceptable
%   normals: normal image
%   p : df / dx
%   q : df / dy
%   SE : Squared Errors of the 2 second derivatives

% initalization
% p = zeros(size(normals));
% q = zeros(size(normals));
% SE = zeros(size(normals));
[m,n,~]=size(normals);
p=zeros(m,n);
q=zeros(m,n);
SE=zeros(m,n);
% ========================================================================
% YOUR CODE GOES HERE

% Author:Robbie
% Date:2-7-2019

% Compute p and q, where
% p measures value of df / dx
% q measures value of df / dy
[h,w,~]=size(normals);
for x=1:h
    for y=1:w
        a=normals(x,y,1);
        b=normals(x,y,2);
        c=normals(x,y,3);
        p(x,y)=a/c;
        q(x,y)=b/c;
    end
end

% ========================================================================



p(isnan(p)) = 0;
q(isnan(q)) = 0;



% ========================================================================
% YOUR CODE GOES HERE
% approximate second derivate by neighbor difference
% and compute the Squared Errors SE of the 2 second derivatives SE
[dpx,dpy]=gradient(p);
[dqx,dqy]=gradient(q);
SE=(dpy-dqx).*(dpy-dqx);

% ========================================================================




end

