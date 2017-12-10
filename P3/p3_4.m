building = imread('building.tif');
figure, imshow(building,'DisplayRange',[0,255]);
title('Original Building');
magnitude = edgeMag(building, 'prewitt', .5);
figure, imshow(magnitude,'DisplayRange',[0,255]);
title('Edge Magnitude Building');
magnitude = edgeAngle(building, 'prewitt', .5);
figure, imshow(magnitude,'DisplayRange',[0,255]);
title('Angle Image Building');


function g = edgeMag(f, type, T)
    [g, Q] = imgradient(f, type);
    switch(type)
        case 'prewitt'
            maskx = [-1,-1,-1;0,0,0;1,1,1];
            masky = [-1,0,1;-1,0,1;-1,0,1];
        case 'sobel'
            maskx = [-1,-2,-1;0,0,0;1,2,1];
            masky = [-1,0,1;-2,0,2;-1,0,1];
    end
    [X,Y] = size(f);
    g2 = zeros(X,Y);
    for i = 1:X
        for j = 1:Y
            gx = 0;
            gy = 0;
            for k = -1:1
                for l = -1:1
                    if(i+k > 0 && i+k <= X)
                        if(j+l > 0 && j+l <= Y)
                            gx = gx + maskx(2+k,2+l)*f(i+k,j+l);
                            gy = gy + masky(2+k,2+l)*f(i+k,j+l);
                        end
                    end
                end
            end
            g2(i,j) = sqrt(double(gx^2+gy^2));
        end
    end
    
end

function ang = edgeAngle(f, type, T)    
    [P, ang] = imgradient(f, type);
end