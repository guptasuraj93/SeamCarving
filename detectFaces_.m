function detectFaces_(imageName)
	FDetect = vision.CascadeObjectDetector;

	%Read the input image
	I = imread(imageName);
	I = rgb2gray(I);

	[mserRegions, mserConnComp] = detectMSERFeatures(I,'RegionAreaRange',[200 8000],'ThresholdDelta',4);
	%Returns Bounding Box values based on number of objects
	%BB = step(FDetect,I);

	figure,
	imshow(I); hold on
	%for i = 1:size(BB,1)
    	%rectangle('Position',BB(i,:),'LineWidth',2,'LineStyle','-','EdgeColor','r');
    	%rectangle('Position',finalBoundingBoxes(i,1:4),'LineWidth',2,'LineStyle','-','EdgeColor','r');
	%end
	plot(mserRegions, 'showPixelList', true,'showEllipses',false);
	title('Face Detection');
	hold off;
end