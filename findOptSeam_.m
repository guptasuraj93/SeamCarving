function [optSeamMask, seamEnergy] = findOptSeam_(energy)
    M = padarray(energy, [0 1], realmax('double')); % to avoid handling border elements

    sz = size(M);
    for i = 2 : sz(1)
        for j = 2 : (sz(2) - 1)
            neighbors = [M(i - 1, j - 1) M(i - 1, j) M(i - 1, j + 1)];
            M(i, j) = M(i, j) + min(neighbors);
        end
    end

    [val, indJ] = min(M(sz(1), :));
    seamEnergy = val;

    optSeamMask = zeros(size(energy), 'uint8');
    
    for i = sz(1) : -1 : 2
        optSeamMask(i, indJ - 1) = 1;
        neighbors = [M(i - 1, indJ - 1) M(i - 1, indJ) M(i - 1, indJ + 1)];
        [val, indIncr] = min(neighbors);
        
        seamEnergy = seamEnergy + val;
        
        indJ = indJ + (indIncr - 2); 
    end

    optSeamMask(1, indJ - 1) = 1;
    optSeamMask = ~optSeamMask;
    
end