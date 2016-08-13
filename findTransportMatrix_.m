function [T, transBitMask] = findTransportMatrix_(sizeReduction, image)
    %disp(sizeReduction);
    T = zeros(sizeReduction(1) + 1, sizeReduction(2) + 1, 'double');
    transBitMask = ones(size(T)) * -1;

%    getEnergy = @getEnergy_;
    generateSeams = @generateSeams_;
    reduceImageVertical = @reduceImageVertical_;
    reduceImageHorizontal = @reduceImageHorizontal_;
    detectFaces = @detectFaces_;
    getEnergyWithFaceMask = @getEnergyWithFaceMask_;
    maskedImage = detectFaces(image);

    maskedImageNoRow = maskedImage;
    imageNoRow = image;
    for i = 2 : size(T, 1)
        disp(i);
%        energy = getEnergy(imageNoRow,0);
        tic
        energy = getEnergyWithFaceMask(imageNoRow, maskedImageNoRow);
        disp(toc);
        %disp(energy);
        tic
        [seamEnergyRow, optSeamMaskRow] = generateSeams(energy');
        disp(toc);
        optSeamMaskRowTranspose = optSeamMaskRow';
        imageNoRow = reduceImageHorizontal(imageNoRow, optSeamMaskRowTranspose);
        maskedImageNoRow = reduceImageHorizontal(maskedImageNoRow, optSeamMaskRowTranspose);
        transBitMask(i, 1) = 0;

        T(i, 1) = T(i - 1, 1) + seamEnergyRow;
    end;

    maskedImageNoColumn = maskedImage;
    imageNoColumn = image;
    for j = 2 : size(T, 2)
        disp(j);
%        energy = getEnergy(imageNoColumn,1);   
        tic;
        energy = getEnergyWithFaceMask(imageNoColumn, maskedImageNoColumn);   
        disp(toc);
        %disp(energy);
        tic;
        [seamEnergyColumn, optSeamMaskColumn] = generateSeams(energy);
        %seamEnergyColumn
        disp(toc);
        imageNoColumn = reduceImageVertical(imageNoColumn, optSeamMaskColumn);
        maskedImageNoColumn = reduceImageVertical(maskedImageNoColumn, optSeamMaskColumn);
        transBitMask(1, j) = 1;
        T(1, j) = T(1, j - 1) + seamEnergyColumn;
    end;
    for i = 2 : size(T, 1)
        %tic;
        %disp('Row');
        disp(i);
        imageWithoutRow = image;
        maskedImageWithoutRow = maskedImage;
        for j = 2 : size(T, 2)
            disp(j);
%            energyHorizontal = getEnergy(imageWithoutRow,0);
            energyHorizontal = getEnergyWithFaceMask(imageWithoutRow, maskedImageWithoutRow); 
            [seamEnergyRow, optSeamMaskRow] = generateSeams(energyHorizontal');
            optSeamMaskRowTranspose = optSeamMaskRow';
            imageNoRow = reduceImageHorizontal(imageWithoutRow, optSeamMaskRowTranspose);
            maskedImageNoRow = reduceImageHorizontal(maskedImageWithoutRow, optSeamMaskRowTranspose);

%            energyVertical = getEnergy(imageWithoutRow,1);
            energyVertical = getEnergyWithFaceMask(imageWithoutRow,maskedImageWithoutRow);
            [seamEnergyColumn, optSeamMaskColumn] = generateSeams(energyVertical);
            imageNoColumn = reduceImageVertical(imageWithoutRow, optSeamMaskColumn);
            maskedImageNoColumn = reduceImageVertical(maskedImageWithoutRow, optSeamMaskColumn);

            neighbors = [(T(i - 1, j) + seamEnergyRow) (T(i, j - 1) + seamEnergyColumn)];
            [val, ind] = min(neighbors);

            T(i, j) = val;
            transBitMask(i, j) = ind - 1;
            imageWithoutRow = imageNoColumn;
            maskedImageWithoutRow = maskedImageNoColumn;
        end;
        %disp(toc);
%        energy = getEnergy(image,0);
        energy = getEnergyWithFaceMask(image,maskedImage);
        [seamEnergyRow, optSeamMaskRow] = generateSeams(energy');
        optSeamMaskRowTranspose = optSeamMaskRow';
        image = reduceImageHorizontal(image, optSeamMaskRowTranspose);
        maskedImage = reduceImageHorizontal(maskedImage, optSeamMaskRowTranspose);
    end;

end