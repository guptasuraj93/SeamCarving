function image = findSeams_(image)
	MAX_ENERGY = 1000000000000;
	getEnergy = @getEnergy_;
	Energy = getEnergy(image,0);
	imageSize = size(Energy);
	tempEnergyArray = [];
	seamsEnergy = zeros(imageSize,'double');
	seamsEnergy(1,:) = Energy(1,:);
	for i=2:imageSize(1)
		for j=1:imageSize(2)
			if (j==1)
				tempEnergyArray = [MAX_ENERGY seamsEnergy(i-1,j) seamsEnergy(i-1,j+1)];
			elseif(j==imageSize(2))
				tempEnergyArray = [seamsEnergy(i-1,j-1) seamsEnergy(i-1,j) MAX_ENERGY];
			else
				tempEnergyArray = [seamsEnergy(i-1,j-1) seamsEnergy(i-1,j) seamsEnergy(i-1,j+1)];
			end
			[minTempEnergy, index] = min(tempEnergyArray);
			seamsEnergy(i,j) = double(minTempEnergy) + double(Energy(i,j));
		end
	end
	currMin = -1;
	for num=1:100
		minVal = getNextMin(currMin,seamsEnergy);
		image = getSeamLine(minVal,seamsEnergy,image);
		currMin = minVal;
	end

end

	

function minVal = getNextMin(currMin,seamsEnergy)
	x = sort(seamsEnergy(size(seamsEnergy,1),:));
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

function image = getSeamLine(minVal, seamsEnergy,image)
	MAX_ENERGY = 1000000000000;
	imageSize = size(image);
	minIndex = find(seamsEnergy(size(seamsEnergy,1),:) == minVal);
	tempEnergyArray = [];
	j = minIndex(1);
	for i=imageSize(1):-1:2
		image(i,j,1) = 255;
		image(i,j,2) = 0;
		image(i,j,3) = 0;
		if (j==1)
			tempEnergyArray = [MAX_ENERGY seamsEnergy(i-1,j) seamsEnergy(i-1,j+1)];
		elseif(j==imageSize(2))
			tempEnergyArray = [seamsEnergy(i-1,j-1) seamsEnergy(i-1,j) MAX_ENERGY];
		else
			tempEnergyArray = [seamsEnergy(i-1,j-1) seamsEnergy(i-1,j) seamsEnergy(i-1,j+1)];
		end
		[minTempEnergy, index] = min(tempEnergyArray);
		j = j+ index-2;
	end
end