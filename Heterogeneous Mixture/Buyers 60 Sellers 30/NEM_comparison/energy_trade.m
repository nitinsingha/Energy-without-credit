% Calling function: main

function [node]=energy_trade(node)
% This function caters to the trading process between the nodes.

% Retreiving network constants.
[CONST] = networkConstants();
Total_iter =CONST.Total_iter;   %Total number of iterations

  
for iter = 1:Total_iter
    
    [sellers, buyers] = list_sellers_buyers_iter(node); % Function returns list of a seller and buyer for the current round.

    [node] = reset_variables(sellers,buyers,node);  %Reset variables for next iteration of energy matching
    
    [deltas, deltab] = compute_delta(node,sellers, buyers,Total_iter); % Function to calculate price change for respective sellers and buyers
    
    [node] = energy_matching(sellers,buyers,node,iter); % Forming groups of sellers with buyers

    [node] = price_update_iterative(sellers,buyers,deltas,deltab,node); % Updating price of sellers and buyers by delta

    [node] = updateFinal_list(sellers,buyers,node);    % This function updated final_buyers_list and final_mappimg. These list contain information about how buyers are grouped with sellers. 
   
    [node] = updateBlocks_traded(sellers,buyers,node);
     
    %[node] = updateIncome(node);   % This function updates the income variable of diffderen users
end
[node] = updateIncome1(node);   % This function updates the income variable of diffderen users based on final_list
CONST = networkConstants();

disp('********* Initial Bid Price ***********');
[sellers, buyers] = list_sellers_buyers(node);
disp('*****Sellers***');
for itrs = 1: length(sellers)
    id(itrs) = sellers(itrs);
    initial_bid(itrs) = node(sellers(itrs)).initialBid;
    initial_service(itrs) = node(sellers(itrs)).ini_service;
end    
ID= id
Initial_bid = initial_bid
Initial_service = initial_service
display('*****Buyers***');
id = [];
initial_bid = [];
for itrb = 1: length(buyers)
    id(itrb) = buyers(itrb);
    initial_bid(itrb) = node(buyers(itrb)).initialBid;
    initial_request(itrb) = node(buyers(itrb)).ini_request;  
end    
ID= id
Initial_bid = initial_bid
Initial_request = initial_request
disp('********************');
disp('Final mapping list');
disp('********************');
    for itr =1: CONST.n
        if(node(itr).type == 0)
            disp('############Buyer node############');
            ID = itr
            lis = node(itr).final_mapping;
            Initial_Request = 0;
            Request = 0;
            Blocks_purchased = 0;
            seller = [];
            blocks = [];
            price = [];
            iteration = [];
            for itr1 =1:1:length(lis)
                seller(itr1) = lis(itr1).sellers_id;
                blocks(itr1) = lis(itr1).blocks;
                price(itr1) = lis(itr1).selling_price;
                iteration(itr1) = lis(itr1).iteration;
            end 
            Initial_Request = node(itr).ini_request
            Request = node(itr).request
            Blocks_purchased = node(itr).request_fulfilled
            SELLER = seller
            Blocks = blocks 
            PRICE = price
            Iteration = iteration
        elseif(node(itr).type== 1)    
            disp('###########Seller node############');
            ID = itr
            lis = node(itr).final_buyers_list;
            Initial_service = 0;
            Service = 0;
            Blocks_sold = 0;
            buyer = [];
            blocks = [];
            price = [];
            iteration = [];
            for itr1 =1:1:length(lis)
                buyer(itr1) = lis(itr1).buyers_id;
                blocks(itr1) = lis(itr1).blocks;
                price(itr1) = lis(itr1).selling_price;
                iteration(itr1) = lis(itr1).iteration;
            end 
            Initial_service = node(itr).ini_service
            Service = node(itr).service
            Blocks_sold = node(itr).sold_blocks
            Buyer = buyer 
            Blocks = blocks 
            PRICE = price
            Iteration = iteration
        end 
    end
end



