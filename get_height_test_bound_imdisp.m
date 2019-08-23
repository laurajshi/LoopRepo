% initializing filename and reference height
% would need to do some preprocessing to get all of the images to be the
% same size

filename = 'tank1_shrunk_shrunk.jpg';

% reference height = tank height
reference_height = 6;

% demonstration of regionprops() and edges()
image = imread(filename);

figure('Name','Tanks Juxtaposed');

subplot(1,2,1), imshow(image,'InitialMagnification',17);
% dims = size(image);
hold on

bw_cup = rgb2gray(image);
subplot(1,2,2), imshow(bw_cup,'InitialMagnification',17);

% bw_cup_imadj = imadjust(bw_cup);
% subplot(2,2,3), imshow(bw_cup_imadj,'InitialMagnification',17);
% 
% bw_cup_hist = histeq(bw_cup);
% subplot(2,2,4), imshow(bw_cup_hist,'InitialMagnification',17);
hold off


cup_edges = edge(bw_cup);
cup_stats = regionprops(cup_edges);
figure('Name', 'Edges_original'); imshow(cup_edges,'InitialMagnification',17);

% cup_edges_imadj = edge(bw_cup_imadj);
% figure('Name', 'Edges_imadjust'); imshow(cup_edges_imadj,'InitialMagnification',17);
% 
% cup_edges_hist = edge(bw_cup_hist);
% figure('Name', 'Edges_hist'); imshow(cup_edges_hist,'InitialMagnification',17);

% think about ways to make this guess easier to determine
% guess is used to extract images of this area range only
initial_guess = [100,500]; 
% potential problem: these values can change depending on image size 
hold off


%dont worry about a clean cup rn
clean_cup = bwareafilt(cup_edges, initial_guess);
figure('Name', 'Cleaned Image'); imshow(clean_cup, 'InitialMagnification',17);

%juxtapose bounding boxes onto the cleaned image
%may be wise in the future to create bounding boxes then remove bounding
%boxes based on ASPECT RATIOS instead of bwareafilt func

hold on
figure('Name', 'Cleaned Image Juxaposed'); imshow(clean_cup,'InitialMagnification',17);
prop_stats = regionprops(clean_cup);
BB = struct2cell(prop_stats);
%where prop_stats fields = area, centroid, boundingBox
bounding_box = BB(3,:);


abs_heights = get_height(filename, reference_height,initial_guess);
%create loop to fill in all the bounding boxes it detects
for i = 1:length(abs_heights)
water_info = bounding_box{i};

% Showing how to use region props to find appropriate area
rectangle('Position', water_info, 'FaceColor', 'r')

% Might also want to put Tank 1, Tank 2, Tank 3, Tank 4 into different
% arrays dynamically then write to csv

% Also need to exclude heights that dont make sense , can use aspect ratios
% for this as well
end

%display juxtaposed boxes
hold off



