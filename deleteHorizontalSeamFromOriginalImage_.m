function imageReduced = deleteHorizontalSeamFromOriginalImage_(image,optSeamMask)
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
	imageReduced = zeros(size(image, 1)-2, size(image, 2), size(image, 3));
    for j = 1 : size(optSeamMaskForOriginal, 2)
    	newColumn = find(optSeamMaskForOriginal(:, j) == 1);
        imageReduced(:, j, 1) = image(newColumn, j, 1);
        imageReduced(:, j, 2) = image(newColumn, j, 2);
        imageReduced(:, j, 3) = image(newColumn, j, 3);
    end

end
