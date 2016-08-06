function Gmag = getEnergy_(I,flag)
	%disp('x');
    [Gmag, Gdir] = imgradient(rgb2gray(I),'prewitt');
end