function detectFaces_(image)
	peopleDetector = vision.PeopleDetector('UprightPeople_96x48')
I = imread('test3.jpg');

[bboxes,scores] = step(peopleDetector,I);

I = insertObjectAnnotation(I,'rectangle',bboxes,scores);
figure, imshow(I)
title('Detected people and detection scores');
end