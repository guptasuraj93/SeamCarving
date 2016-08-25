function [minSeamEnergy,optSeamMask] = generateSeamsOptimized_(Energy)
	findOptSeamMaskUsingIndex = @findOptSeamMaskUsingIndex_;

	MAX_ENERGY = 1000000000000;
	imageSize = size(Energy);
	tempEnergyArray = [];
	%Movement = zeros(imageSize(1), imageSize(2));
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
			%Movement(i,j) = index-2;
			seamsEnergy(i,j) = double(minTempEnergy) + double(Energy(i,j));

		end
	end
	
	optSeamMask = zeros(imageSize, 'uint8');
	[minSeamEnergy, index] = min(seamsEnergy(imageSize(1),:));
	optSeamMask = findOptSeamMaskUsingIndex_(index, imageSize,seamsEnergy,optSeamMask);
	optSeamMask = ~optSeamMask;

	minStartingIndex = find(optSeamMask(1,:) == 1);

	newEnergy = 

	%optSeamMask = zeros(imageSize, 'uint8');
	%[minSeamEnergy, index] = min(seamsEnergy(imageSize(1),:));
	%j = index(1);
	%for i=imageSize(1):-1:2
	%	optSeamMask(i,j) = 1;
	%		j = j+ Movement(i,j);
	%end
	%optSeamMask(1,j) = 1;
	%optSeamMask = ~optSeamMask;

end