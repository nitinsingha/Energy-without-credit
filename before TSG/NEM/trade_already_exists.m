%calling function: [node] = performTrade3(node,seller)
%performing trade on seller if buyer already exists in the buyers_list

function [node] = trade_already_exists(node,seller,buyers_id,index,request,iter)
service  = node(seller).service;   % Returns total block of energy available at seller for selling  
cnt_upto_now = 0;   % The total request of all the buyers who lie above buyer_id in the preference list of the seller, and have already requested the seller.

buyers_list = node(seller).buyers_list;   % The id of the buyers to whom blocks have been sold.

% Calculating demands of requesters who lie above current requester in the
% preference list, and they have requested for service.
for i=1:index
    cnt_upto_now = cnt_upto_now + buyers_list(i).blocks;  
end

% The seller can't provide blocks greater than its capacity. 
min_sold = min(request.blocks,service - cnt_upto_now);   

if(min_sold >0)
    %update buyer
    
    % Updating request variable
    request = updateRequest_strucutre(seller,buyers_id,min_sold,node(seller).bidPrice,node(buyers_id).bidPrice,iter);   % Creteas a request stucture for the request
    isPresent=1;  % The buyer has already requested seller and has been promised block.
    node = updateBuyer_addition(node,isPresent,request);
    
    %update seller and remove extra blocks
    buyers_list(index).blocks = node(seller).buyers_list(index).blocks + min_sold;
    
    cnt_upto_now = cnt_upto_now + min_sold;
    %remove extra blocks
    
    %find the index where cnt > service
    temp_index = -1;
    for i = index+1: length(buyers_list)
        cnt_upto_now = cnt_upto_now + buyers_list(i).blocks;
        if(cnt_upto_now > service)
            temp_index =i;
            break;
        end
    end
    
    if temp_index >0   % The promise of service allocated curently is greater than the capacity of the server.
        %update temp_index one and remove others
        cnt_upto_now = cnt_upto_now - buyers_list(temp_index).blocks;
        
        min_keep = service - cnt_upto_now;
        
        blocks_removed = buyers_list(temp_index).blocks - min_keep;
        
        %update request
        temp_request = updateRequest_strucutre(seller,buyers_list(temp_index).buyers_id,blocks_removed,node(seller).bidPrice,node(buyers_list(temp_index).buyers_id).bidPrice,iter);   % Creteas a request stucture for the request
        
        %updating temp_index buyer
        node = updateBuyer_removal(node,temp_request);
        
        %updating remaining 
        for i = temp_index+1:length(buyers_list)
            blocks_removed = buyers_list(i).blocks;
            
            %update request
            temp_request = updateRequest_strucutre(seller,buyers_list(i).buyers_id,blocks_removed,node(seller).bidPrice,node(buyers_list(i).buyers_id).bidPrice,iter);   % Creteas a request stucture for the request
            node = updateBuyer_removal(node,temp_request);
        end
       
        if min_keep >0
            buyers_list(temp_index).blocks = min_keep;
            buyers_list = buyers_list(1:temp_index);
        else
            buyers_list = buyers_list(1:temp_index-1);
        end
        
        node(seller).buyers_list = buyers_list;
    else
        node(seller).buyers_list = buyers_list;
    end
    
    % Updating the total blocks sold by the seller
    node(seller).sold_blocks =  totalBlocks(node,seller);  
    
    % Updating the total blocks sold by the seller
    node(seller).sold_blocks =  totalBlocks(node,seller);  
end 
end