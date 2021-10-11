function reflectedIm = imreflect(im, topborder, bottomborder, leftborder, rightborder)
% IMREFLECT
%   Reflects image on borders. If borders are given negative, it crops
%   the image as specifed.
% samples :
%  %% read image and info
%       I = imread('peppers.png');
%       [h, w, c] = size(I);
% 
%  %% 1) mirror to right
%       topborder = 0; 
%       bottomborder = 0;
%       leftborder = 0;
%       rightborder = w;
%       I2 = imreflect(I, topborder, bottomborder, leftborder, rightborder);
%       figure('Name', 'Input Image'); imshow(I);
%       figure('Name', 'Image is mirrored to right'); imshow(I2);
%       
%   %% 2) reflect 2 times to right. Width of the result will be 3 times the width of the input.
%       rightborder = 2*w;
%       I2 = imreflect(I, topborder, bottomborder, leftborder, rightborder);
%       figure('Name', 'Image is mirrored to right 2 times'); imshow(I2);
%       
%   %% 3) crop image. 
%       topborder = -20; 
%       bottomborder = -40;
%       leftborder = -60;
%       rightborder = -100;
%       I2 = imreflect(I, topborder, bottomborder, leftborder, rightborder);
%       figure('Name', 'Croped Image'); imshow(I2);
%       
%       
%   %% 4) reflect croped image 
%       topborder = -topborder; % +20
%       bottomborder = -bottomborder; % +40
%       leftborder = -leftborder; % +60
%       rightborder = -rightborder; % +100
%       I3 = imreflect(I2, topborder, bottomborder, leftborder, rightborder);
%       figure('Name', 'Croped image is reflected to previous size.'); imshow(I3);


    [h, w, c] = size(im); % height width channel
    
    newH = topborder+h+bottomborder; % new height of the reflected Image with the borders
    newW = leftborder+w+rightborder; % new width of the reflected Image with the borders
    
    reflectedIm = zeros([newH newW c], class(im));
    
    i = 1:newH;
    j = 1:newW;
    
    reflected_i = reflection(1:newH, topborder+1, topborder+h); % 
    reflected_j = reflection(1:newW, leftborder+1, leftborder+w);
    
    image_i = reflected_i-topborder;
    image_j = reflected_j-leftborder;
    reflectedIm(i, j, :) = im(image_i, image_j, :);
end