
im1 = imread('Fig0228(b)(angiography_live_ image).tif');
im2 = imread('Fig0228(a)(angiography_mask_image).tif');
newim = imArithmetic(im1, im2, 'subtract');
imshow(newim);
function g = imArithmetic(f1, f2, op)
    switch op
        case 'add'
            g1 = f1+f2;
        case 'subtract'
            g1 = f1-f2;
        case 'multiply'            
            g1 = f1.*f2;
        case 'divide'
            g1 = f1./f2;
        otherwise
            fprintf('Error'); 
            g = 0;
    end
    
    gm = g1 - min(g1);
    g = 255*(abs(gm./max(gm)));    
end

