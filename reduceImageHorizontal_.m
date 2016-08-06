function imageReduced = reduceImageHorizontal_(image, seamMask)
    imageReduced = zeros(size(image, 1)-1, size(image, 2), size(image, 3),'uint8');
    %disp(find(seamMask(:,size(seamMask,2)) == 0));
    for j = 1 : size(seamMask, 2)
        imageReduced(:, j, 1) = image(seamMask(:, j), j, 1);
        imageReduced(:, j, 2) = image(seamMask(:, j), j, 2);
        imageReduced(:, j, 3) = image(seamMask(:, j), j, 3);
    end
end