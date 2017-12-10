
polymercell = imread('polymercell.tif');
[im, sep, kstar] = otsuThresh(polymercell);
figure, imshow(im);
title(sprintf('Thresholded using OTSU, sep: %d, kstar: %d', sep, kstar));

function [g, sep, kstar] = otsuThresh(f)
    % find kstar
    bins = 256;
    counts = imhist(f, bins);
    p = counts / sum(counts);
    
    oBackground = 0;
    muBackground = 0;
    
    for i = 1:bins
        oBackground(i) = sum(p(1:i));     
        muBackground(i) = sum(p(1:i).*(1:i)');        
    end
    
    sigma2B = (muBackground(end) .* oBackground-muBackground) .^2 ./(oBackground .* (1-oBackground));
    [~, kstar] = max(sigma2B);
    
    % create binary image g
    [M, N] = size(f);
    g = zeros(M, N);
    for i = 1:M
        for j = 1:N
            if f(i, j) >= kstar
                g(i, j) = 1;
            end          
        end
    end
    
    % create sep      
    sep = kstar/var(double(f(:)))
end