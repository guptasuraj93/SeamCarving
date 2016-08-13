function maskedImage =  detectFaces_(image)
	getResizedImage = @getResizedImage_;
	FDetect = vision.CascadeObjectDetector();
	%image = imread('test4.jpg');
	I = rgb2gray(image);
	BB = step(FDetect,I);
	maskedImage = ones(size(image));
	
	for k = 1:size(BB,1)
		x = BB(k,2): BB(k,2) + BB(k,4);
		y = BB(k,1): BB(k,1) + BB(k,3);
		maskedImage(x,y,:) = 0;
	end
end

%function maskedImage = detectFaces_(imageName)
%	getResizedImage = @getResizedImage_;
%
%	maskedImage = imread('test5.jpg');
%	maskedImage = im2bw(maskedImage);
%	maskedImage = getResizedImage(maskedImage);
%	maskedImage(:,:,2) = maskedImage(:,:,1);
%	maskedImage(:,:,3) = maskedImage(:,:,1);
%end