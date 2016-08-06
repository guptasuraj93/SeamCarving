function [T, transBitMask] = findTransportMatrix_(sizeReduction, image)
    %disp(sizeReduction);
    T = zeros(sizeReduction(1) + 1, sizeReduction(2) + 1, 'double');

    transBitMask = ones(size(T)) * -1;

    getEnergy = @getEnergy_;
    generateSeams = @generateSeams_;
    reduceImageVertical = @reduceImageVertical_;
    reduceImageHorizontal = @reduceImageHorizontal_;

    imageNoRow = image;
    for i = 2 : size(T, 1)
        energy = getEnergy(imageNoRow,0);
        %disp(energy);
        [seamEnergyRow, optSeamMaskRow] = generateSeams(energy');
        optSeamMaskRowTranspose = optSeamMaskRow';
        imageNoRow = reduceImageHorizontal(imageNoRow, optSeamMaskRowTranspose);
        transBitMask(i, 1) = 0;

        T(i, 1) = T(i - 1, 1) + seamEnergyRow;
    end;

    imageNoColumn = image;
    for j = 2 : size(T, 2)
        energy = getEnergy(imageNoColumn,1);
        
        %disp(energy);

        [seamEnergyColumn, optSeamMask] = generateSeams(energy);
        imageNoColumn(:,:,1);
        imageNoColumn = reduceImageVertical(imageNoColumn, optSeamMask);
        transBitMask(1, j) = 1;
        T(1, j) = T(1, j - 1) + seamEnergyColumn;
    end;
    for i = 2 : size(T, 1)
        %tic;
        %disp('Row');
        %disp(i);
        imageWithoutRow = image;

        for j = 2 : size(T, 2)
            energyHorizontal = getEnergy(imageWithoutRow,0);
            [seamEnergyRow, optSeamMaskRow] = generateSeams(energyHorizontal');
            optSeamMaskRowTranspose = optSeamMaskRow';
            imageNoRow = reduceImageHorizontal(imageWithoutRow, optSeamMaskRowTranspose);

            energyVertical = getEnergy(imageWithoutRow,1);
            [seamEnergyColumn, optSeamMaskColumn] = generateSeams(energyVertical);
            imageNoColumn = reduceImageVertical(imageWithoutRow, optSeamMaskColumn);

            neighbors = [(T(i - 1, j) + seamEnergyRow) (T(i, j - 1) + seamEnergyColumn)];
            [val, ind] = min(neighbors);

            T(i, j) = val;
            transBitMask(i, j) = ind - 1;
            imageWithoutRow = imageNoColumn;
        end;
        %disp(toc);
        energy = getEnergy(image,0);
        [seamEnergyRow, optSeamMaskRow] = generateSeams(energy');
        optSeamMaskRowTranspose = optSeamMaskRow';
        image = reduceImageHorizontal(image, optSeamMaskRowTranspose);
    end;

end