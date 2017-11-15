test = double(imread('testpattern.tif'));
moon = double(imread('blurrymoon.tif'));
[moonM, moonN] = size(moon);
[testM, testN] = size(test);
figure, imshow(fdfiltering(moon, lpfilterTF('butterworth', 2*moonM, 2*moonN, [32, 2])), 'DisplayRange', [0, 255])
title('LP Filter Moon')
figure, imshow(fdfiltering(test, lpfilterTF('butterworth', 2*testM, 2*testN, [32, 2])), 'DisplayRange', [0, 255]);
title('LP Filter Test')
figure, imshow(fdfiltering(moon, hpfilterTF('butterworth', 2*moonM, 2*moonN, [16, 2])), 'DisplayRange', [0, 255])
title('HP Filter Moon')
figure, imshow(fdfiltering(test, hpfilterTF('butterworth', 2*testM, 2*testN, [16, 2])), 'DisplayRange', [0, 255]);
title('HP Filter Test')

function g = fdfiltering(f, H)
    [m,n] = size(f);
    p = 2*m;
    q = 2*n;    
    for x = 1: m
        for y = 1 : n
           f(x, y) = f(x, y) * (-1)^(x+y);
        end
    end
    Fuv = fft2(f, p, q);     
    Guv=H.*Fuv;
    gpxy = real(ifft2(Guv)); 
    for x = 1: p
        for y = 1 : q
           gpxy(x, y) = gpxy(x, y) * (-1)^(x+y);
        end
    end
    g = gpxy(1:size(f, 1), 1: size(f, 2));
end

function H = lpfilterTF(type, P, Q, param)
    u = 0:(P-1);
    v = 0:(Q-1);

    duv = zeros(P,Q);
    for x = 1:P
        for y = 1:Q
            duv(x,y) = sqrt((u(x) - P/2)^2 + (v(y) - Q/2)^2);
        end
    end
    
    switch type
        case 'ideal'
            d0 = param;
            H = double(duv <= d0);
        case 'gaussian'
            d0 = param;
            H = exp(-(duv.^2)./(2*(d0^2)));
        case 'butterworth'   
            d0 = param(1);
            n = param(2);
            H = 1./(1+(duv./d0).^(2*n));
        otherwise
            fprintf('Error');
            H=0;
    end
    
end

function H = hpfilterTF(type, P, Q, param)
    u = 0:(P-1);
    v = 0:(Q-1);

    duv = zeros(P,Q);
    for x = 1:P
        for y = 1:Q
            duv(x,y) = sqrt((u(x) - P/2)^2 + (v(y) - Q/2)^2);
        end
    end
    
    switch type
        case 'ideal'
            d0 = param;
            H = double(duv >= d0);
        case 'gaussian'
            d0 = param;
            H = 1-exp(-(duv.^2)./(2*(d0^2)));
        case 'butterworth'   
            d0 = param(1);
            n = param(2);
            H = 1./(1+(d0./duv).^(2*n));
        otherwise
            fprintf('Error');
            H=0;
    end
    
end