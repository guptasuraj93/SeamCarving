function image = randomizeImage_(image)
	mask = imread('test5.jpg');
	mask = im2bw(mask);
	for i=1:size(image,1)
		for j=1:size(image,2)
			if(mask(i,j) == 1)
				image(i,j,1) = round(rand(1)*255);
				image(i,j,2) = round(rand(1)*255);
				image(i,j,3) = round(rand(1)*255);
			end
		end
	end
	imwrite(image,strcat('/home/suraj/Desktop/seamCarvingWithPyramid/test6.jpg'));
end