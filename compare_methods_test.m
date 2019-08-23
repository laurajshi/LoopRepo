I = imread('tank1_shrunk_shrunk.jpg');
I_bw = rgb2gray(I);
BW1 = edge(I_bw, 'Canny');
BW2 = edge(I_bw, 'Prewitt');
BW3 = edge(I_bw, 'Sobel');
BW4 = edge(I_bw, 'Roberts');
BW5 = edge(I_bw, 'log');
BW6 = edge(I_bw, 'zerocross');
BW7 = edge(I_bw, 'approxcanny');

% figure('Name','Canny and Prewitt'); imshowpair(BW1,BW2,'montage');
% figure('Name','Sobel and log'); imshowpair(BW3,BW5,'montage');
% figure('Name','Roberts and zerocross'); imshowpair(BW4,BW6,'montage');
% 
% figure('Name','approxcanny'); imshow(BW7);

figure('Name', 'Prewitt'); imshow(BW2);
figure('Name', 'Sobel'); imshow(BW3);
figure('Name', 'Roberts'); imshow(BW4);