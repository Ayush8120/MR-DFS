% TestScript

% small map
map = false(100);

% obstacle
map (1:60, 16) = true;

start_coords = [60, 22];
target_coords  = [80, 91];

close all;

[route, numExpanded] = Astarmap(map, start_coords, target_coords)




function [route,numExpanded] = Astarmap (input_map, start_coords, target_coords)
% set up color map for display
% 1 - white - clear cell
% 2 - black - obstacle
% 3 - red = visited
% 4 - blue  - on list
% 5 - green - start
% 6 - yellow - destination

o_map = [1 1 1; ...
         0 0 0; ...
         1 0 0; ...
         0 0 0.8; ...
         0 1 0; ...
         1 1 0; ...
         0.5 0.5 0.5];

colormap(o_map)

[n_rows, n_cols] = size(input_map);

% map - a table that keeps track of the state of each grid cell
map = zeros(n_rows,n_cols);

map(~input_map) = 1;   % Mark free cells
map(input_map)  = 2;   % Mark obstacle cells

% Generate linear indices of start and target nodes
start_node = sub2ind(size(map), start_coords(1), start_coords(2));
target_node  = sub2ind(size(map), target_coords(1),  target_coords(2));

map(start_node) = 5;
map(target_node)  = 6;

% meshgrid will `replicate grid vectors' nrows and ncols to produce
% a full grid
% type `help meshgrid' in the Matlab command prompt for more information
parent = zeros(n_rows,n_cols);

% 
[X, Y] = meshgrid (1:n_cols, 1:n_rows);

destX = target_coords(1);
destY = target_coords(2);

% Evaluate Heuristic function, H, for each grid cell
% Manhattan distance
H = abs(X - destX) + abs(Y - destY);
H = H';
% Initialize cost arrays
f = Inf(n_rows,n_cols);
g = Inf(n_rows,n_cols);


g(start_node) = 0;
f(start_node) = H(start_node);

% keep track of the number of nodes that are expanded
numExpanded = 0;
map(start_node) = 5;
    map(target_node) = 6;
image(1.5, 1.5, map);
        grid on;
        axis image;
        drawnow;


    
  
    

    
  
  

 
end
