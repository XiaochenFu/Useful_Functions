% Read in image.
clear
rgbImage = imread ('Capture5.JPG');
subplot(1, 2, 1);
imshow(rgbImage);
title('Original Image', 'FontSize', 20);
% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Now switch color channels.
image_switch(:,:,1)= rgbImage(:,:,3);
image_switch(:,:,2)= rgbImage(:,:,2);
image_switch(:,:,3)= rgbImage(:,:,1);
% Display switched image.
subplot(1, 2, 2);
imshow(image_switch);
title('Red and Blue Switched', 'FontSize', 20);
imwrite(image_switch,'Capture5_Swap.jpg')