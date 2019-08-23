%lshi 8/15
%this test attempts to visualize the segmentation of a singular inventory
%tank in 7 steps
%inventory tank taken from test data on 7/5
close all
clear 

% step 1: read image
input = imread('tank2_water.jpg');
I = rgb2gray(input);
figure('Name', 'Original Image'); 
% imshow(I, 'InitialMagnification', 17); 
imshow(I);

% step 2: detect entire cell
[~, threshold] = edge(I, 'sobel');
%fudge factor used for sensitivity threshold
fudgeFactor = 0.5;

I_BW = edge(I, 'sobel', threshold * fudgeFactor);
figure('Name', 'Binary Gradient Mask'); 
% imshow(I_BW, 'InitialMagnification', 17);
imshow(I_BW);

%step 3: dilate the image
%creates 2 perp. linear struc. elements by using the strel function to fill
%in the gaps
%would likely have to play around with the locations
se90 = strel('line',3,90);
se0 = strel('line',3,0);
BW_dil = imdilate(I_BW,[se90 se0]);
figure('Name', 'Dilated Gradient Mask'); 
% imshow(BW_dil, 'InitialMagnification', 17);
imshow(BW_dil);

%step 4: fill in gaps by using imfill method w/ param 'holes'
BW_fill = imfill(BW_dil, 'holes');
figure('Name', 'Binary Image Filled'); 
% imshow(BW_fill, 'InitialMagnification', 17);
imshow(BW_fill);

%step 5: remove connected objects, this seems to cause issues because of
%light glare, does not clear out things properly
%as a result, set the value =  0 for the moment

clear_value = 4;
BW_noborder = imclearborder(BW_fill, clear_value);
figure('Name', 'Image no border'); 
% imshow(BW_noborder, 'InitialMagnification', 17);
imshow(BW_noborder)

%step 6: smooth object with diamond struct elem w/ strel function x2
seD = strel('diamond',1);
BW_final = imerode(BW_fill,seD);
BW_final = imerode(BW_final,seD);
figure('Name', 'Segmented Image'); 
% imshow(BW_final, 'InitialMagnification', 17);
imshow(BW_final);

%step 7: finally, visualize segmentation by masking over the original image
% Image_juxt = labeloverlay(I, BW_fill);
Image_juxt = labeloverlay(I, BW_final);
figure('Name', 'Masked Over Original Image'); 
% imshow(Image_juxt, 'InitialMagnification', 17);
imshow(Image_juxt);

%in addition to the mask overall, we could also include an outline
% BW_outline = bwperim(BW_fill);
BW_outline = bwperim(BW_final);
Segout = I; 
Segout(BW_outline) = 255; 
figure('Name', 'Outlined Original Image'); 
% imshow(Segout, 'InitialMagnification', 17)
imshow(Segout);
