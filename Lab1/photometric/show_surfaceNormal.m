function show_surfaceNormal(height_map, normals)
% show_surfaceNormal: display the surface normal with arrows
%   height_map: height in z direction, describing the model geometry
% Author: Liang Huang
% Date: 15/Feb/2019

figure
[x_end, y_end, ~] = size(height_map);
x = 1:8:x_end;
y = 1:8:y_end;
quiver3(x, y, height_map(1:8:end, 1:8:end), normals(1:8:end,1:8:end,1), normals(1:8:end,1:8:end,2), normals(1:8:end,1:8:end,3))
title('Surface Normal Demo');

end