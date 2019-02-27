function [ imOut ] = denoise(image, kernel_type, varargin)

switch kernel_type
    case 'box'
        filterSize = varargin{1};
        imOut = imboxfilt(image, filterSize);
    case 'median'
        filterSize = varargin{1};
        imOut = medfilt2(image,[filterSize, filterSize]);
    case 'gaussian'
        sigma = varargin{1};
        filterSize = varargin{2};
        G = gauss2D(sigma, filterSize);
        imOut = conv2(double(image), double(G), 'same');
end
end
