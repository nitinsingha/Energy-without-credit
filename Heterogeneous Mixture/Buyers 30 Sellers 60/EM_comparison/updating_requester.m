% Callling function: [node]=simple_matching(sellers,buyers,node,n,total_sellers)

function [node]=updating_requester(node,curnt_buyer,curnt_seller,blocks_traded)
    %Updating the request requiremnt and current transactions done 
    past_highest_block_received_Id=node(curnt_buyer).request_fullfilled;    % The total blocks received before purchasing blocks from curnt_seller
    crnt_highest_block_received_Id=past_highest_block_received_Id+blocks_traded; %node(curnt_buyer).request-blocks_required;   % The total blocks received after purchasing blocks from curnt_seller
    if(crnt_highest_block_received_Id>node(curnt_buyer).request)     % Check that highest id of the block purchased cannot be greater than the  
        crnt_highest_block_received_Id=node(curnt_buyer).request;
    end    
    % If no change in past and current requirement fullfilled, 
    % it implies that curnt_seller has not awarded any block to curnt_buyer. 
    if(past_highest_block_received_Id==crnt_highest_block_received_Id)
        block_purchased='No';  
    else
        block_purchased='Yes';
    end
 
    % If block is purchased then only update seller details into requester/buyer
    if (strcmp(block_purchased,'Yes'))
    % This provides range of blocks received by receiver from the serving node
    % The lowest block eeceived will be the next to highest block received
    % from the previous node
        crnt_lowest_block_received_Id= past_highest_block_received_Id+1;  
           
    % Updating the Id of the seller at the receiving node
        node(curnt_buyer).sellers(crnt_lowest_block_received_Id:crnt_highest_block_received_Id)=curnt_seller;    
    
        node(curnt_buyer).request_fullfilled=crnt_highest_block_received_Id;
    end   
 
  
end

