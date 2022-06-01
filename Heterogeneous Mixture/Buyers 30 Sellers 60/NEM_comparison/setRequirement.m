% Calling function: start

function [node] = setRequirement(node)  
% This function sets the requirement of sellers and buyers in the network. 
    
import = matfile('random_request.mat');   % Importing randomly generated supply and demand requests.

supply = import.supply;                  % Importing demnad matrix of buyers
demand = import.demand;                  % Importing supply matrix of sellersg1;
% Retreiving network constants
[CONST] = networkConstants();
n = CONST.n;
total_sellers = CONST.total_sellers;    % Total number of sellers in the network.

total_buyers = n - total_sellers;       % Total number of buyers in the network.

[sellers,buyers] = list_sellers_buyers(node); % Function returns list of a seller and buyer for the current round.

% Adjusting the requirement of sellers
for itrs=1:total_sellers
    node(sellers(itrs)).service = supply(itrs);     
    node(sellers(itrs)).ini_service = node(sellers(itrs)).service;
end
for itrb=1:total_buyers
    node(buyers(itrb)).request = demand(itrb);
    node(buyers(itrb)).ini_request = node(buyers(itrb)).request;
end
end

