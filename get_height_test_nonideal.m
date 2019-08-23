% initializing filename and reference height
%reference height = tank
 filename = 'WIN_20190628_17_29_44_Pro.jpg';
% filename = 'cup_test_white_ background.jpg';
% filename = 'cropped_tank_17_27_49_Pro.jpg';
reference_height = 6;

% demonstration of regionprops() and edges()
image = imread(filename);
figure('Name','Original Image'); imshow(image);
dims = size(image)
bw_cup = rgb2gray(image);
cup_edges = edge(bw_cup);
cup_stats = regionprops(cup_edges);
figure('Name','Edge Image'); imshow(cup_edges);


initial_guess = [30,50]; %guess for actual system

%think about ways to make this guess easier to determine
%for clean cup
%initial_guess = [1000,4000];

clean_cup = bwareafilt(cup_edges, initial_guess);
figure('Name','Cleaned Image'); imshow(clean_cup);
hold on
figure('Name','Cleaned Image Juxtaposed'); imshow(clean_cup);
prop_stats = regionprops(clean_cup);
BB = struct2cell(prop_stats);
bounding_box = BB(3,:)

% water_info = bounding_box{3}
% 
% 
% % Showing how to use region props to find appropriate area
% rectangle('Position', water_info, 'FaceColor', 'r')
% 
% % ultimately, this funciton will need to be written into a loop to loop
% % over all images in an experimental run 
% 
% abs_heights = get_height(filename, reference_height,initial_guess)


% for i = 1:length(abs_heights)
% water_info = bounding_box{i};
% 
% 
% % Showing how to use region props to find appropriate area
% rectangle('Position', water_info, 'FaceColor', 'r')
% 
% % ultimately, this funciton will need to be written into a loop to loop
% % over all images in an experimental run 
% 
% abs_heights = get_height(filename, reference_height,initial_guess);
% 
% % Might also want to put Tank 1, Tank 2, Tank 3, Tank 4 into different
% % arrays dynamically then write to csv
% 
% % Also need to exclude heights that dont make sense 
% end
% 
% hold off

abs_heights = get_height(filename, reference_height,initial_guess)