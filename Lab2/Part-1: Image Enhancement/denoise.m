function [ imOut ] = denoise(image, kernel_type, varargin)
I = imread(image);

switch kernel_type
    case 'box'
        filterSize = varargin{1};
        imOut = imboxfilt(I,filterSize);
    case 'median'
        filterSize = varargin{1};
        imOut = medfilt2(I,[filterSize,filterSize]);
    case 'gaussian'
        sigma = varargin{1};
        filterSize = varargin{2};
        G = gauss2D(sigma,filterSize);
        imOut = conv2(I,G,'same');
end

end
