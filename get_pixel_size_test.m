% initializing filename and reference height
%reference height = tank
filename = 'WIN_20190628_17_24_57_Pro.jpg';
reference_height = 6;

% demonstration of regionprops() and edges()
image = imread(filename);
% figure('Name','Original Image'); imshow(image);
dims = size(image)
bw_cup = rgb2gray(image);

figure('Name','Original Image BW'); 
imshow(bw_cup); imcontrast;
% figure('Name','Original Image BW'); imshow(bw_cup_new);

cup_edges = edge(bw_cup);

cup_stats = regionprops(cup_edges);
figure('Name','Edge Image'); imshow(cup_edges);


initial_guess = [20,200]; %guess for actual system


clean_cup = bwareafilt(cup_edges, initial_guess);
figure('Name','Cleaned Image'); imshow(clean_cup);


% figure('Name','Cleaned Image Juxtaposed'); imshow(clean_cup);
% hold on
% prop_stats = regionprops(clean_cup);
% BB = struct2cell(prop_stats);
% bounding_box = BB(3,:)
% 
% 
% for i = 1:length(abs_heights)
% 
%     water_info = bounding_box{i};
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