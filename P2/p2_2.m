moon = double(imread('blurrymoon.tif'));
blur = imfilter(moon, gaussKernal(100, 1));
mask = moon-blur;
unsharpmask = moon + mask;
highboost = moon + 1.5*mask;
laplacekernal = [0, -1, 0; -1, 4, -1; 0, -1, 0];
laplace = moon+imfilter(moon, laplacekernal);
figure, imshow(unsharpmask, 'DisplayRange', [0. 255])
title('unsharp masking')
figure, imshow(highboost, 'DisplayRange', [0. 255])
title('highboost')
figure, imshow(laplace, 'DisplayRange', [0. 255])
title('Laplace filter')





function w = gaussKernal(m, sigma)
    mat = zeros(m, m);
    k = 1/(2*pi*sigma^2);
    for i = 1 : m
        for j = 1 : m
            mat(i, j) = k*exp(-((i-m/2)^2 + (j-m/2)^2)/(2*sigma^2));
        end
    end
    w = mat;
end