% transform using bulit-in MATLAB function imwarp
function [I_t] = bulit_in_imwrap(I, params) 
T=[params(1) -params(2) 0;
   -params(3) params(4) 0;
   params(5) params(6) 1;];
tform = affine2d(T);
I_t=imwarp(I,tform,'nearest');
end