function imOut = compute_LoG(image, LOG_type)

switch LOG_type
    case 1
        %method 1
        k_gauss = fspecial('gaussian', 5, 0.5);
        k_laplace = fspecial('laplacian');
        smoothed = imfilter(image, k_gauss, 'same', 'conv');
        imOut = imfilter(smoothed, k_laplace, 'same', 'conv');
    case 2
        %method 2
        k_laplace = fspecial('log', 5, 0.5);
        imOut = imfilter(image, k_laplace, 'same', 'conv');
    case 3
        %method 3
        k_gauss1 = fspecial('gaussian', 5, 0.5);
        k_gauss2 = fspecial('gaussian', 5, 30);
        gaussian1 = imfilter(image, k_gauss1, 'same', 'conv');
        gaussian2 = imfilter(image, k_gauss2, 'same', 'conv');
        imOut = gaussian1 - gaussian2;
end
end

