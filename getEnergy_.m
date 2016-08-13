function Gmag = getEnergy_(I,flag)
   [Gmag, Gdir] = imgradient(rgb2gray(I),'prewitt');
end

%function res = getEnergy_(I,flag)
%    res = energyGrey(I(:, :, 1)) + energyGrey(I(:, :, 2)) + energyGrey(I(:, :, 3));
%end

%function res = energyGrey(I)
%    res = abs(imfilter(I, [-1,0,1], 'replicate')) + abs(imfilter(I, [-1;0;1], 'replicate'));
%end