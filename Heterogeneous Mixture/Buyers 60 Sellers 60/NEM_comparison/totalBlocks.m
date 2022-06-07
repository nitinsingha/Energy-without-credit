%calling function: 
%1. [node] = trade_already_exists(node,seller,buyers_id,index,request)
%2. [node] = trade_not_present(node,seller,buyers_id,index,current_request)

function [ttl_blck]= totalBlocks(node,seller)
%Returns the total blocks promised by the seller to different buyers

ttl_blck = 0;  % Stores the total blocks sold by a seller


for itr_buyer = 1:length(node(seller).buyers_list)
        ttl_blck = ttl_blck + node(seller).buyers_list(itr_buyer).blocks;
end
end

