building = imread('building.tif');
magnitude = edgeMag(building, 'sobel', 0);
figure, imshow(magnitude,'DisplayRange',[0,255]);
title('Edge Magnitude Building');
angle = edgeAngle(building, 'sobel', 1);
figure, imshow(angle,'DisplayRange',[0,255]);
title('Angle Image Building');


function g = edgeMag(f, type, T)
    [g, Q] = imgradient(f, type);    
    
    switch(type)
        case 'prewitt'
            mx = [-1,-1,-1;0,0,0;1,1,1];
            my = [-1,0,1;-1,0,1;-1,0,1];
        case 'sobel'
            mx = [-1,-2,-1;0,0,0;1,2,1];
            my = [-1,0,1;-2,0,2;-1,0,1];
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
                            gx = gx + f(i+k,j+l)*mx(2+k,2+l);
                            gy = gy + f(i+k,j+l)*my(2+k,2+l);
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