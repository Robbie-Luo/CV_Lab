function [histogram] = get_histogram(idx_test, clusters)
% return a normalized histogram of size [n_clusters x 1]
    vector = tabulate(idx_test) ; 
    histogram = vector(:, 3) ; 
    if size(histogram,1) < clusters
        to_pad = clusters - size(histogram,1) ;
        histogram = [histogram; zeros(to_pad,1)] ;
    end 
end