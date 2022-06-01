% Calling function[node]=creating_sellers_buyers(node)
function [node]=creating_buyers(node,n)
% Creating buyers in a given round 

% Retrieving  network constants.
CONST=networkConstants();  
n=CONST.n;   % Total number of nodes in the network;

% Initially it is assumed that every node is buyer. Thereafter some of the buyers are 
%converted into sellers sellers

for itr=1:1:n
    node(itr).type=0;          % Type =0 buyer,
    % A node can buy 1 to 5 blocks durin a round;
    node(itr).request = randi([1 5]); % no of blocks demanded
    node(itr).required = node(itr).request; % The blocks requirement that remained unfilled at the node. 
    node(itr).request_fullfilled = node(itr).request - node(itr).required; % The block requirement that is fullfilled
    node(itr).bidPrice = randi([1 10]); %Buyer bid price 
    
    % node(itr).mapping  is strcuture with 4 components. It is same as buyer list with seller
    % node(itr).mapping.blocks = number of blocks being allocated buye.
    % node(itr).mapping.sellers_id  = Id of seller, i.e., seller_Id.
    % node(itr).mapping.buyers_id = Id of buyer,i.e., itr.
    % node(itr).mapping.distance = distance between sellers_id and buyers_id
    % node(itr).mapping.bid_price = bid price quoted by the buyer.
    % node(itr).mapping.selling_price = The actual price a buyer has to pay, if enery is traded bettween seller and buyer pertaining to this transaction

    node(itr).mapping  = [];    
    
    node(itr).rejected_last =0;
    node(itr).unProcessedList = [];  %  It contains list of sellers, who have not been requested for the energy till now.
    node(itr).lsp = 0; % It contains the list of latest service provider to buyer itr
end