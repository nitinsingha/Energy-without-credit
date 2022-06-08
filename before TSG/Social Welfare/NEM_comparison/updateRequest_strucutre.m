%Calling function (The below list is not updated list. Their may be more functions calling the current function)
% 1. [node]=sendRequest(node,buyer)
% 2. [node] = trade_already_exists(node,seller,buyers_id,index,request)
% 3. [node] = trade_not_present(node,seller,buyers_id,index,current_request)

function [request] = updateRequest_strucutre(seller_Id,buyer_Id,blocks,bidPrice_seller,bidPrice_buyer,iter)
% This function returens a strucutre request. This strucutre is exhanges
% between seellers and buyers for trading.
%It has four attributes
% 1. request.buyers_id = Id of buyer;
% 2. request.sellers_id = Id of seller;
% 3. request.blocks = No of blocks traded for this request strucutre;
% 4. request.bid_price = The price offered by buyer_Id to seller_Id for
% 5. request.distance = The distance between nodes sellers_id and buyers_id purchasing that block.
% 6. request.selling_price = The actual price a buyer has to pay, if enery  is traded bettween seller and buyer pertaining to this transaction.
% 7. request.iteration = In which iteration of IEM algorithm, the transaction is taking place

% Retrieving  coordinates of different nodes
global COORDINATES    % This variable returns the position of different nodes.
% Retreiving network constants.
[CONST] = networkConstants();
Total_iter =CONST.Total_iter;   % Total number of iterations


    request.buyers_id = buyer_Id;
    request.sellers_id = seller_Id;
    request.blocks = blocks;
    request.bid_price = bidPrice_buyer;    % This is bidprice offered by the seller
    request.distance = sqrt((COORDINATES(buyer_Id).x - COORDINATES(seller_Id).x)^2 + (COORDINATES(buyer_Id).y - COORDINATES(seller_Id).y)^2 );
    if(iter == Total_iter)
        request.selling_price = max(bidPrice_seller,(bidPrice_seller+bidPrice_buyer)/2);
    else 
        request.selling_price = (bidPrice_seller+bidPrice_buyer)/2;   % Note: else statement if just the extension of the if statement. The grouping for "iter < Total_iter" will happen only when bidPrice_buyer > bidPrice_seller.
    end
    request.iteration = iter;  %
end

