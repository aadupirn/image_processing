test = double(imread('testpattern.tif'));
moon = double(imread('blurrymoon.tif'));
imshow(fdfiltering(test, 0), 'DisplayRange', [0. 255]);

function g = fdfiltering(f, H)
    [m,n] = size(f);
    p = 2*m;
    q = 2*n;
    fpq = zeros(p, q);
    for x = 1 : m
        for y = 1: n
            fpq(m/2+x, n/2+y) = f(x, y);
        end
    end
    g = fpq;
    
end

function H = lpfilterTF(type, P, Q, param)
    u = 0:(P-1);
    v = 0:(Q-1);
    
    idOne = find(u > P/2);
    u(idOne) = u(idOne) - P;
    idTwo = find(v > Q/2);
    v(idTwo) = v(idTwo) - Q;
    [U, V] = meshgrid(u, v);  
    
    d = sqrt(U.^2 + V.^2);
    
    switch type
        case 'ideal'
            d0 = param;
            H = double(d <= d0);
        case 'gaussian'
            d0 = param;
            H = exp(-(d.^2)./(2*(d0^2)));
        case 'butterworth'   
            d0 = param(1);
            n = param(2);
            H = 1./(1+(d./d0).^(2*n));
        otherwise
            fprintf('Error');
            H=0;
    end
    
end

function H = hpfilterTF(type, P, Q, param)
    u = 0:(P-1);
    v = 0:(Q-1);
    
    idOne = find(u > P/2);
    u(idOne) = u(idOne) - P;
    idTwo = find(v > Q/2);
    v(idTwo) = v(idTwo) - Q;
    [U, V] = meshgrid(u, v);  
    
    d = sqrt(U.^2 + V.^2);
    
    switch type
        case 'ideal'
            d0 = param;
            H = double(d >= d0);
        case 'gaussian'
            d0 = param;
            H = 1-exp(-(d.^2)./(2*(d0^2)));
        case 'butterworth'   
            d0 = param(1);
            n = param(2);
            H = 1./(1+(d0./d).^(2*n));
        otherwise
            fprintf('Error');
            H=0;
    end
    
end