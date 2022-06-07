% Calling function: main
function [points] = generate_coordinates()
% This function generates the coordinates for the node

%  Retrieving  network constants.
CONST=networkConstants(); 
R = 2*CONST.n;
N = CONST.n;
points  =[];

for i = 1:N    % The coordinates of all nodes are generated. 
    r = R * sqrt(rand());
    theta = rand() * 2 * pi;
    pt.x = r * cos(theta);
    pt.y = r * sin(theta);
    points = [points,pt];
end






