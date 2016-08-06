function optSeamMask = findOptSeamMaskUsingIndex_(index, imageSize, seamsEnergy, optSeamMask)
	MAX_ENERGY = 1000000000000;
	j = index;
	tempEnergyArray = [];

	for i=imageSize(1):-1:1
		optSeamMask(i,j) = 1;
		if(i ~= 1)
			if (j==1)
				tempEnergyArray = [MAX_ENERGY seamsEnergy(i-1,j) seamsEnergy(i-1,j+1)];
			elseif(j==imageSize(2))
				tempEnergyArray = [seamsEnergy(i-1,j-1) seamsEnergy(i-1,j) MAX_ENERGY];
			else
				tempEnergyArray = [seamsEnergy(i-1,j-1) seamsEnergy(i-1,j) seamsEnergy(i-1,j+1)];
			end
			[minTempEnergy, minIndex] = min(tempEnergyArray);
			j = j+minIndex-2;
		end
	end

end