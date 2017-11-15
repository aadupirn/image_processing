rose = imread('Fig0219(rose1024).tif');
angiography = imread('Fig0228(b)(angiography_live_ image).tif');
imageHist(rose, 'n')
meanVariance(rose)
imageHist(angiography, 'n')
meanVariance(angiography)
histEqual(rose)
histEqual(angiography)
function h = imageHist(f, op)
    switch op
        case 'u'
            imhist(f);
            h = imhist(f);
        otherwise                       
            [counts,bins] = imhist(f);
            [m, n] = size(f);
            normalizedc = counts/(m*n);
            bar(bins, normalizedc)
            h = [normalizedc, bins];        
    end
end

function [mean, variance] = meanVariance(f)
    h = imageHist(f, 'n');
    counts = h(1:256);
    bins = h(257:512);
    mult = bins.*counts;
    mean = sum(mult)
    variance = sum((bins-mean).^2.*counts)
end

function g = histEqual(f)
    eqhist = zeros(1, 256);
    h = imageHist(f, 'n');
    counts = h(1:256);
    bins = h(257:512);
    currentSum = 0;
    for i = 1 : 256
        currentSum = currentSum + counts(i);
        eqhist(i) = floor(255*currentSum);
    end    
    bar(bins, eqhist)
    [m, n] = size(f);
    g = zeros(m, n);
    for i = 1 : m
       for j = 1 : n 
          imageindex = f(i, j) + 1;
          g(i, j) = eqhist(imageindex);
       end
    end
    imshow(g, 'DisplayRange', [0, 255]);  
end