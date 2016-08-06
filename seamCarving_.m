function [reducedImage, resizedImage1] = seamCarving_(ReducedSize, image)
    tic;
    getEnergy = @getEnergy_;
    generateSeams = @generateSeams_;
    reduceImageVertical = @reduceImageVertical_;
    reduceImageHorizontal = @reduceImageHorizontal_;
    findTransportMatrix = @findTransportMatrix_;
    getResizedImage = @getResizedImage_;
    deleteHorizontalSeamFromOriginalImage = @deleteHorizontalSeamFromOriginalImage_;
    deleteVerticalSeamFromOriginalImage = @deleteVerticalSeamFromOriginalImage_;

	originalImageSize = size(image);
	sizeReduction = round([(originalImageSize(1)-ReducedSize(1))/2 (originalImageSize(2)-ReducedSize(2))/2]);
    resizedImage = getResizedImage(image);
    disp('creating tranportMatrix...');
	[T, transBitMask] = findTransportMatrix(sizeReduction, resizedImage);
    disp('tranportMatrix created');
	i = size(transBitMask, 1);
    j = size(transBitMask, 2);

    for it = 1 : (sizeReduction(1) + sizeReduction(2))
        if (transBitMask(i, j) == 0)
        	energy = getEnergy(resizedImage,0);
            [minSeamEnergy,optSeamMask] = generateSeams(energy');
            optSeamMaskTranspose = optSeamMask';   
            resizedImage = reduceImageHorizontal(resizedImage,optSeamMaskTranspose);
            image = deleteHorizontalSeamFromOriginalImage(image,optSeamMaskTranspose);
            i = i - 1;
            disp('Horizontal');
        else
        	energy = getEnergy(resizedImage,1);
            [minSeamEnergy,optSeamMask] = generateSeams(energy);
            resizedImage = reduceImageVertical(resizedImage,optSeamMask);
            image = deleteVerticalSeamFromOriginalImage(image,optSeamMask);
            j = j - 1;
            disp('Vertical');
        end;

    end;

    reducedImage = zeros(size(image),'uint8');
    reducedImage(:,:,1) = image(:,:,1);
    reducedImage(:,:,2) = image(:,:,2);
    reducedImage(:,:,3) = image(:,:,3);

    resizedImage1 = zeros(size(resizedImage),'uint8');
    resizedImage1(:,:,1) = resizedImage(:,:,1);
    resizedImage1(:,:,2) = resizedImage(:,:,2);
    resizedImage1(:,:,3) = resizedImage(:,:,3);
    
    disp(toc);
end