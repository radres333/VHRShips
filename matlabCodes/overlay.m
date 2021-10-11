function [imresized] = overlay(input_im, destination_h, destination_w)
%% Get an image overlay it with new size

[input_h, input_w, input_c] = size(input_im);

top_plus_bottom_border = destination_h - input_h;
left_plus_right_border = destination_w - input_w;

%  resim ortada her yöne geni?le
topborder = floor(top_plus_bottom_border/2); 
bottomborder = top_plus_bottom_border - topborder;
leftborder = floor(left_plus_right_border/2); 
rightborder = left_plus_right_border - leftborder;

imresized = imreflect(input_im,topborder, bottomborder, leftborder, rightborder);
end