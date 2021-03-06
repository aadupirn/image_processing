%e
im = double(imread('circuitboard_gaussian.tif'));
arImage = aMean(im,5,5);
geoImage = geoMean(im,5,5);
figure, imshowpair(arImage, geoImage, 'montage');
title('e) aMean and geoMean on circuitboardgaussian');

%f
salt = double(imread('circuitboard_salt.tif'));
pepper = double(imread('circuitboard_pepper.tif'));
salt2 = ctharMean(salt,5,5,-1);
pepper2 = ctharMean(pepper,5,5,1);
figure, imshowpair(salt2, pepper2, 'montage');
title('f) Filtered Salt on Left and Pepper on Right');

%g
filterEverything = double(imread('cirbuitboard_saltandpepper.tif'));
everythingFiltered = medianFilter(filterEverything,3,3);
figure, imshow(everythingFiltered,'DisplayRange',[0,255]);
title('Filter Salt and Pepper Noise');



function f_hat = aMean(g, m, n)
[x,y] = size(g);
f_hat = zeros(x,y);
    for i = 1:x
        for j = 1:y
            s = 0;
            for k = ceil(-m/2):floor(m/2)
                for l = ceil(-n/2):floor(n/2)
                    if( i+k < x && i+k > 1)
                        if(j+l > 1 && j+l < y)
                            s = s + g(i+k,j+l);
                        end
                    end
                end
            end
            s = s/(m*n);
            f_hat(i,j) = floor(s);
        end
    end 
end

function f_hat = geoMean(g, m, n)
[x,y] = size(g);
f_hat = zeros(x,y);
    for i = 1:x
        for j = 1:y
            mu = 1;
            for k = ceil(-m/2):floor(m/2)
                for l = ceil(-n/2):floor(n/2)
                    if(i+k < x && i+k > 1)
                        if(j+l > 1 && j+l < y)
                            mu = mu * g(i+k,j+l);
                        end
                    end
                end
            end
            f_hat(i,j) = floor(nthroot(mu,m*n));
        end
    end 
end

function f_hat = ctharMean(g, m, n, q)
[x,y] = size(g);
f_hat = zeros(x,y);
    for i = 1:x
        for j = 1:y
            s1 = 0;
            s2 = 0;
            for k = ceil(-m/2):floor(m/2)
                for l = ceil(-n/2):floor(n/2)
                    if( i+k < x && i+k > 1 )
                        if(j+l > 1 && j+l < y)
                            s1 = s1 + (g(i+k,j+l)^(q+1));
                            s2 = s2 + (g(i+k,j+l)^(q)); 
                        end
                    end
                end
            end
            f_hat(i,j) = round(s1/s2);
        end
    end 
end

function f_hat = medianFilter(g, m, n)
[x,y] = size(g);
f_hat = zeros(x,y);
    for i = 1:x
        for j = 1:y
            array = zeros(m,n);
            for k = ceil(-m/2):floor(m/2)
                for l = ceil(-n/2):floor(n/2)
                    if(i+k > 1 && i+k < x)
                        if(j+l > 1 && j+l < y)
                            s1 = k+ceil(m/2);
                            s2 = l+ceil(n/2);
                            array(s1,s2) = g(i+k,j+l);
                        end
                    end
                end
            end
            new = zeros(1,m*n);
            for k = 1:m
                for l = 1:n
                    new((m*(k-1) + l)) = array(k,l);
                end
            end
            f_hat(i,j) = median(new);
        end
    end 
end