im = imread('UTK.tif');
imshow(im,'DisplayRange',[0,255]);
title('Original UTK');
oneArray = ones(3,3);
eroded = morphoErode(morphoErode(morphoErode(im,oneArray),oneArray),oneArray);
dialated = morphoDilate(morphoDilate(morphoDilate(im,oneArray),oneArray),oneArray);
figure, imshowpair(eroded, dialated, 'montage');
title('Eroded 3x on left. Dialated 3x on right');

function E = morphoErode (I, B)
    [m,n] = size(B);
    [M,N] = size(I);
    f = zeros(M+(2*m),N+(2*n));
    for i = m:M
        for j = n:N
            f(i,j) = I(i-m+1,j-n+1);
        end
    end
    
    [X,Y] = size(f);
    E = zeros(M,N);
    for i = m:M+m
        for j = n:N+n
            array = zeros(m,n);
            for k = ceil(-m/2):floor(m/2)
                for l = ceil(-n/2):floor(n/2)
                    if(i+k > 1 && i+k < X)
                        if(j+l > 1 && j+l < Y)
                            s1 = k+ceil(m/2);
                            s2 = l+ceil(n/2);
                            array(s1,s2) = B(s1,s2)*f(i+k,j+l);
                        end
                    end
                end
            end
            new = zeros(1,m*n);
            for k = 1:m
                for l = 1:n
                    new((l + (k-1)*m)) = array(k,l);
                end
            end
            E(i-m+1,j-n+1) = min(new);
        end
    end
end

function E = morphoDilate (I, B)
    [m,n] = size(B);
    [M,N] = size(I);
    f = zeros(M+(2*m),N+(2*n));
    for i = m:M
        for j = n:N
            f(i,j) = I(i-m+1,j-n+1);
        end
    end
    
    [X,Y] = size(f);
    E = zeros(M,N);
    for i = m:M+m
        for j = n:N+n
            array = zeros(m,n);
            for k = ceil(-m/2):floor(m/2)
                for l = ceil(-n/2):floor(n/2)
                    if(i+k > 1 && i+k < X)
                        if(j+l > 1 && j+l < Y)
                            s1 = k+ceil(m/2);
                            s2 = l+ceil(n/2);
                            array(s1,s2) = B(s1,s2)*f(i+k,j+l);
                        end
                    end
                end
            end
            new = zeros(1,m*n);
            for k = 1:m
                for l = 1:n
                    new((l + (k-1)*m)) = array(k,l);
                end
            end
            E(i-m+1,j-n+1) = max(new);
        end
    end
end