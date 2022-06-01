% Calling function: main

function [node]=creating_sellers_buyers(node)
% The sellers and buyers are being created inside the network

% Generating buyers for a given round. Initially every node is considered
% buyer. From buyer some nodes are selected as a seller.
node=creating_buyers(node);  
% Creating sellers in a given round
node=creating_sellers(node);
end

