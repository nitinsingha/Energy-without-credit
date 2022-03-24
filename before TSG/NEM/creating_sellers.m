% Calling function [node]=creating_sellers_buyers(node);

function [node]=creating_sellers(node)
% Generating sellers for a given round

% Retrieving  network constants.
CONST=networkConstants();  
n=CONST.n;   % Total number of nodes in the network;
total_sellers=CONST.total_sellers;   % Total number of sellers in the network;
DSO_block_cost=CONST.DSO_block_cost;  % The cost of a single energy block sold by the DSO 

sellers=randperm(n,total_sellers);
    for itr=1:1:total_sellers
        seller_ID=sellers(itr);
        node(seller_ID).type=1;
        node(seller_ID).service=randi([1 5]); % A node can have blocks between 1 to 5 available for selling
        node(seller_ID).ini_service = node(seller_ID).service;   % The value of this variable remains constant in matlab
        node(seller_ID).sold_blocks=0;  % Initially all the blocks remain unsold at the node. 
        
        node(seller_ID).buyers_list = [];  % The informaion about requesters to whom blocks have been promised by seller_ID.
        % node(seller_ID).buyers_list is structure with four attributes. 
        % node(seller_ID).blocks = number of blocks being allocated buye.
        % node(seller_ID).sellers_id  = Id of seller, i.e., seller_Id.
        % node(seller_ID).buyers_id = Id of buyer.
        % node(seller_ID).distance = distance between sellers_id and buyers_id
        % node(seller_ID).bid_price = The amount demanded by the seller_ID for given transaction
        % node(seller_ID).selling_price = The actual price a seller earns, if enery is traded bettween seller and buyer pertaining to this transaction
        % node(seller_ID).iteration = In which iteration of IEM algorithm, the transaction is taking place   
        
         node(seller_ID).final_buyers_list = [];  % This stucture is same as buyers_list. It is used to store final grouping of a seller_ID with buyers. For details refer function updateFinal_list
        node(itr).bidPrice = randi([1 10]); %Seller bid price 
        % The value on initialBid remanins constant in the matlab
        node(itr).initialBid = node(itr).bidPrice;    % This variable stores the inital bid pirce of a node. The bid price of a node may change with iterations but its inital bidpice remain the same
        % Resetting the request variables of the serving node. These
        % variables rare required for the buyers;
        node(seller_ID).request=0;
        node(seller_ID).requestList =[];   % It stores the all the requests received by a seller for a given round.It stores an array of strucutres. Each strucure has four fiels: buyers_id, blocks, bid_price, distance. 
        % This strucutre is used to pass information about the current buyer (bidder) to the seller
        node(seller_ID).block_cost=DSO_block_cost;   % The cost of a single block sold by the seller.
    end    
end

