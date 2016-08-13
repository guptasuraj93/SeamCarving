function Gmag = getEnergyWithFaceMask_(I, imageWithFacesMask)
	MAX_ENERGY = 10000;
    [Gmag, Gdir] = imgradient(rgb2gray(I),'prewitt');
    faceElements = find(imageWithFacesMask(:,:,1)==0);
    
    Gmag(faceElements) = Gmag(faceElements) + MAX_ENERGY;

    %for i=1: size(Gmag,1)
    %	for j=1:size(Gmag,2)
    %		if(imageWithFacesMask(i,j) == 0)
    %			Gmag(i,j) = Gmag(i,j) + MAX_ENERGY;
    %		end
    %	end
    %end
end
