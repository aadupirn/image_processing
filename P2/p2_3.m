
function H = lpfilterTF(type, P, Q, param)
    mat = zeros(m, m);
    k = 1/(2*pi*sigma^2);
    for i = 1 : m
        for j = 1 : m
            mat(i, j) = k*exp(-((i-m/2)^2 + (j-m/2)^2)/(2*sigma^2));
        end
    end
    w = mat;
end