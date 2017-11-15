figure, imshow(lpfilterTF('ideal', 512, 512, 96))
title('Ideal')
figure, imshow(lpfilterTF('gaussian', 512, 512, 96))
title('Gaussian')
figure, imshow(lpfilterTF('butterworth', 512, 512, [96, 2]))
title('Butterworth')
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