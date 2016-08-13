function imageReduced = deleteVerticalSeamFromOriginalImage_(image,optSeamMask)
	optSeamMaskForOriginal = ones(size(image,1),size(image,2),'uint8');
	for i=1:size(optSeamMask,1)
		for j=1:size(optSeamMask,2)
			if(optSeamMask(i,j) == 0)
				optSeamMaskForOriginal(2*i-1,2*j-1) = 0;
				optSeamMaskForOriginal(2*i-1,2*j) = 0;
				optSeamMaskForOriginal(2*i,2*j-1) = 0;
				optSeamMaskForOriginal(2*i,2*j) = 0;
			end
		end
	end 
	imageReduced = zeros(size(image, 1), size(image, 2) - 2, size(image, 3));
    for i = 1 : size(optSeamMaskForOriginal, 1)
    	newRow = find(optSeamMaskForOriginal(i,:) == 1);
    	size(newRow)
        imageReduced(i, :, 1) = image(i, newRow, 1);
        imageReduced(i, :, 2) = image(i, newRow, 2);
        imageReduced(i, :, 3) = image(i, newRow, 3);
    end

end