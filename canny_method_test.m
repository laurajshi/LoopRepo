I = imread('tank1_shrunk_shrunk.jpg');
I_bw = rgb2gray(I);
%Calculate a threshold using graythresh. The threshold is normalized to the range [0, 1].

level = graythresh(I_bw);
disp(level);

%Convert the image into a binary image using the threshold.

BW = imbinarize(I_bw,level);
%Display the original image next to the binary image.
figure('Name', 'Juxtaposed Images Canny Method'); imshowpair(I_bw,BW, 'montage');