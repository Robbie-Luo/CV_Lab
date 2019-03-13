 %transform using our own imwarp
 function [I_t] = our_imwrap(I, params)
    [h,w,~] = size(I);
    corners = [0 0;0 h;w 0;w h]';
    % transformation matrice
    M = [params(1), params(2); params(3), params(4)] ; 
    t = [params(5); params(6)];
    % get new corners
    corners_new = M * corners + t ; 
    x_min = round(min(corners_new(1,:)));
    y_min = round(min(corners_new(2,:)));
    x_max = round(max(corners_new(1,:)));
    y_max = round(max(corners_new(2,:)));
    % calculate the size of the new image
    w_new = x_max - x_min;
    h_new = y_max - y_min;
    % nearest-neighbour interpolation
    if size(I,3)==1
        I_t = zeros(h_new, w_new,'uint8');
        for i = 1:w_new
            for j = 1:h_new
                 xy_tmp = [i+x_min-1;j+y_min-1];
                 xy_old = inv(M)*(xy_tmp-t);
                 if xy_old(1)>=1 && xy_old(1)<=w && xy_old(2)>=1 && xy_old(2)<=h
                    I_t(j,i) = I(round(xy_old(2)),round(xy_old(1)));
                 end
            end
        end
    end
    % For RGB image
    if size(I,3)==3
        I_t = zeros(h_new, w_new, 3);
        for i = 1:w_new
            for j = 1:h_new
                 xy_tmp = [i+x_min-1;j+y_min-1];
                 xy_old = inv(M)*(xy_tmp-t);
                 if xy_old(1)>=1 && xy_old(1)<=w && xy_old(2)>=1 && xy_old(2)<=h
                    I_t(j,i,:) = I(round(xy_old(2)),round(xy_old(1)),:);
                 end
            end
        end
    end
        
 end



