figure, imshow(hpfilterTF('ideal', 512, 512, 96))
title('Ideal')
figure, imshow(hpfilterTF('gaussian', 512, 512, 96))
title('Gaussian')
figure, imshow(hpfilterTF('butterworth', 512, 512, [96, 2]))
title('Butterworth')
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