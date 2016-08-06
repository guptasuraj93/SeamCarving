function resizedImage = getResizedImage_(image)
    resizedImage = impyramid(image, 'reduce');
end