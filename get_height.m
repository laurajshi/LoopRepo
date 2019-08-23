function abs_height = get_height(filename, reference_height, initial_guess)
% Returns the fluid level in a clear container

% filename is the location of the image
% reference_height is the actual height of the container (in real life)
% Initial guess is the number of pixels associated with each important
% feature of the image. Suggested initial guesses are below. 


% Currently only tested with single container need to make changes for 
% multiple containers 

% Suggested Changes:
% Write function that finds initial guesses for each height level of 
% cylinder, right now, you would have to use regionprops() to figure out a 
% reasonable inital guess
% OR 
% Since camera location doesn't change, we can hard code in initial guesses

% Suggested Initial Guess:
% Smallest value of initial_guess array should correspond with the pixel
% area associated with the smallest expected amount of holdup. Largest
% value should correspond with the area of empty cylinder. To get these
% features use regionprops(), sort by area, and start excluding features
% with bwareaopen() until only regions of interest remain then pass these
% values to this function. 
 

% reading the image 
init_image = imread(filename);

% making the image gray scale 
image_gray = rgb2gray(init_image);

% finding all edges in image 
all_edges = edge(image_gray);

% finding smallest area in initial guess array  
min_area = min(initial_guess);

% finding largest area in initial guess array
max_area = max(initial_guess);

% extracting all features of image that are within the range of the inital
% guess 
clean_image = bwareafilt(all_edges, [min_area, max_area]);

% getting the region properties of the cleaned up image
image_props = regionprops(clean_image);

% image_props is a struct that contains centroid, area, and Bounding Box
% information. We just want the Bounding Box 

% getting Bounding Box by coverting struct to cells 
image_cells = struct2cell(image_props); 
box = image_cells(3,:);

% Pulling height data and putting it into an array
s = size(box);
height = zeros(s(2),1);
for i = 1:s(2)
    height(i) = box{i}(4);
end

% The maximum height in the array corresponds to an empty tank
empty_tank = max(height);

% Converting pixel height to relative height 
rel_height = height./empty_tank;

% Using given reference heights to convert relative heights to absolute
% heights 
abs_height = rel_height.*reference_height;









