function imageReduced = reduceImageVertical_(image, seamMask)
    imageReduced = zeros(size(image, 1), size(image, 2) - 1, size(image, 3),'uint8');
   	%disp(find(seamMask(size(seamMask,1),:) == 0));
    
    for i = 1 : size(seamMask, 1)
    	newRow = find(seamMask(i,:) == 1);
        imageReduced(i, :, 1) = image(i, newRow, 1);
        imageReduced(i, :, 2) = image(i, newRow, 2);
        imageReduced(i, :, 3) = image(i, newRow, 3);
    end
end