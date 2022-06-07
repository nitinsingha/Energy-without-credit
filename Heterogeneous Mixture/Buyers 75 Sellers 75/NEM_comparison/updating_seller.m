% Callling function: [node]=energy_matching(sellers,buyers,node,n,total_sellers

function [node]=updating_seller(node,curnt_buyer,curnt_seller,blocks_traded)
%Updating the blocks sold and current transactions done 
 
 past_highest_block_sold_Id=node(curnt_seller).sold_blocks;     % The highest block sold in the past trnsaction.
 curnt_highest_block_sold_Id=past_highest_block_sold_Id+blocks_traded;%node(curnt_seller).service-unsold_blocks;
  if(curnt_highest_block_sold_Id>node(curnt_seller).service)    % Check that nodes highest sold block can't be more than no of blocks available with the node.
      curnt_highest_block_sold_Id=node(curnt_seller).service;
  end    
 % If no change in past and current Id's of highest block sold, 
    % it implies that curnt_seller has not awarded any block to curnt_buyer. 
    if(past_highest_block_sold_Id==curnt_highest_block_sold_Id)
        block_sold='No';  
    else
        block_sold='Yes';
    end
  % If block is sold then only update buyers details into seller
    if (strcmp(block_sold,'Yes'))
    % This provides range of blocks sold by the seller to curnt_buyer
    % The lowest block sold will be the next to highest block sold
    % from the previous node
    
    curnt_lowest_block_sold_id=past_highest_block_sold_Id+1; 
    
  % Updating the Id of the buyer at seller 
      node(curnt_seller).buyers(curnt_lowest_block_sold_id:curnt_highest_block_sold_Id)=curnt_buyer;    
      node(curnt_seller).sold_blocks=curnt_highest_block_sold_Id;
  
    end
end