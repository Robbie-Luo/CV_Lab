function G = gauss2D( sigma , kernel_size )
    %% solution
    % 1-D gaussian kernel along x-axis.
    x=gauss1D(sigma, kernel_size);
    % 1-D gaussian kernel along y-axis.
    y=transpose(gauss1D(sigma, kernel_size));
    
    G= y*x;
end
