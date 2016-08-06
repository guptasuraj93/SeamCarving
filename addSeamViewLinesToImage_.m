function image = addSeamViewLinesToImage_(image,optSeamMask)
	for i = 1:size(optSeamMask,1)
        for j=1:size(optSeamMask,2)
        	if(optSeamMask(i,j) == 0)
        		image(i,j,1) = 255;
        		image(i,j,2) = 0;
        		image(i,j,3) = 0;  
        	end
  		end
    end 
end
