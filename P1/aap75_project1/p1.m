img = double(imread('Fig0219(rose1024).tif'));
imgmask = mask(1024, 1024, 256, 256, 768, 768);
imshow(img.*imgmask, 'DisplayRange', [0, 255]);
function m = mask(M, N, rUL, cUL, rLR, cLR)
    m = zeros(M, N);
    if rUL < 0 || rUL > M || cUL < 0 || cUL > N || rLR < 0 || rLR > M || cLR < 0 || cLR > N 
        fprintf('error')
        m = 0;
    else
        for i = rUL : rLR
            for j = cUL : cLR
               m(i, j) = 1;    
            end
        end      
    end
end
