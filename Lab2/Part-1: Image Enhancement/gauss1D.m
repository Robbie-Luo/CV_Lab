function G = gauss1D( sigma , kernel_size )
    G = zeros(1, kernel_size);
    if mod(kernel_size, 2) == 0
        error('kernel_size must be odd, otherwise the filter will not have a center to convolve on')
    end
    %% solution
    low = -floor(kernel_size/2);
    high = floor(kernel_size/2);
    
    % Generate input x.     
    x = zeros(1, kernel_size);
    % Assign value for each x.    
    for i = 1: kernel_size
        x(1,i) = low + (i-1)*(high-low)/(kernel_size-1);
    end
   
    % Calculate corresponding Gaussian value for input x.    
    G = sigma*sqrt(2*pi)*exp(-x.^2/(2*sigma.^2));
    
    % Normalise the results.
    G = G./sum(G)
end
