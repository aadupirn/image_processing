utk = imread('UTK.tif');
figure, imshow(imbinarize(utk));
title('Original UTK');

B = [[0,0,0;-1,1,-1;1,1,1],[-1,0,0;1,1,0;1,1,-1],[1,-1,0;1,1,0;1,-1,0],[1,1,-1;1,1,0;-1,0,0],[1,1,1;-1,1,-1;0,0,0],[-1,1,1;0,1,1;0,0,-1],[0,-1,1;0,1,1;0,-1,1],[0,0,-1;0,1,1;-1,1,1]];
utkThin = morphoThin(utk, B);
figure, imshow(utkThin);
title('Thinned UTK');

utkPruned = morphoPrun(utkThin, 1, 7);
figure, imshow(utkPruned);
title('Pruned UTK');

function T = morphoThin(I,B)
%Eventually you want I n (I (hit or miss) B)
    T = bwmorph(imbinarize(I), 'thin', 5);
end

function P = morphoPrun(I, numthin,nnumdil)
    P = bwmorph(I, 'spur', nnumdil);
end