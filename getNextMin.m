function minVal = getNextMin(currMin,seamsEnergy)

	x = sort(seamsEnergy(size(seamsEnergy,1),:));
	x
	j = 1;
	while(true)
		if(x(1,j) <= currMin)
			j = j+1;
		else
			minVal = x(1,j);
			break;
		end
	end
end