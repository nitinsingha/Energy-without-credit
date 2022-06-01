%calling function performTrade

%performing trade on seller if buyer doesnot exist in the buyers_list
function [node] = trade_not_present(node,seller,buyers_id,index,current_request)

service  = node(seller).service;
cnt_upto_now =0;   % The total request of all the buyers who lie above buyer_id in the preference list of the seller, and have already requested the seller.

buyers_list = node(seller).buyers_list;

%index stores position of current  buyer in seller's preference lsit. index >0 if the current buyer lies above some of existing requester in preference lsit of
%current seller, otherwise it returns -1. If current buyer lies above existing requester, then index tells  how many existing requester , have preference higher than current buyer in the preference list.  
       
if index == -1   % The current buyer lies lowest in the preference list, i.e., it is present at the end
    for i = 1:length(buyers_list)
        cnt_upto_now = cnt_upto_now + buyers_list(i).blocks;
    end
    %update seller buyers_list
    remaining  = min(service - cnt_upto_now,current_request.blocks);    % No of unslods blocks with the seller
    if remaining >0
        %update request
        request = updateRequest_strucutre(seller,buyers_id,remaining);   % Creteas a request stucture for the request
        %update buyer
        isPresent=0; % The buyer has never requested seller before. So buyer is not present in mapping list of seller.
        node = updateBuyer_addition(node,isPresent,request);
        buyers_list = [buyers_list;current_request];
        node(seller).buyers_list = buyers_list;    
    end
else
    % if index is not at the end
    for i = 1:index-1
        cnt_upto_now = cnt_upto_now + buyers_list(i).blocks;        % No of blocks remaining with seller, after it has allocated blocks to requester with indexes in range 1 to index-1
    end
    min_sold  = min(service - cnt_upto_now,current_request.blocks);
    
    if min_sold >0
        % update buyer mapping
        %update request
        request = updateRequest_strucutre(seller,buyers_id,min_sold);   % Creteas a request stucture for the request
        %update buyer
        isPresent=0; % The buyer has never requested seller before. So buyer is not present in mapping list of seller.
        node = updateBuyer_addition(node,isPresent,request);
        
        cnt_upto_now = cnt_upto_now + min_sold;
        
        %update buyers_list
        buyers_list = [buyers_list(1:index-1);current_request;buyers_list(index:end)];
        
        %remove extra blocks
    
        %find the index where cnt > service
        temp_index = -1;     % This variable contains Id of the new lowest preffered buyer in the buying list of seller. If it is -1, then all the buyers from the previous list will remain in the updated list.
        for i = index+1: length(buyers_list)
            cnt_upto_now = cnt_upto_now + buyers_list(i).blocks;
            if(cnt_upto_now > service)
                temp_index =i;
                break;
            end
        end
        
        % Now we have a buyers_list, where the cuurent buyer has been added to the buyer list of a seller. However, total blocks sold to
        % differt buyers may be incorrect in this list. This happens because due to addition of new buyer the total energy promised by a seller may be more than energy
        % available with it. The below code tries to correct this scenario. It also informs the nodes who have been deallocated blocks by the
        % given seller
        if temp_index >0
            %update temp_index one and remove others
            cnt_upto_now = cnt_upto_now - buyers_list(temp_index).blocks;
        
            min_keep = service - cnt_upto_now;    % How much amount of energy can be provided to last permissible buyer in the buying list
        
            blocks_removed = buyers_list(temp_index).blocks - min_keep;
            temp_request = updateRequest_strucutre(seller,buyers_list(temp_index).buyers_id,blocks_removed);   % Creteas a request stucture for the request
        
            %updating temp_index buyer
            node = updateBuyer_removal(node,temp_request);
        
            %updating remaining buyers
            for i = temp_index+1:length(buyers_list)
                blocks_removed = buyers_list(i).blocks;
                temp_request = updateRequest_strucutre(seller,buyers_list(i).buyers_id,blocks_removed);   % Creteas a request stucture for the request
                node = updateBuyer_removal(node,temp_request);
            end
        
            if min_keep >0
                buyers_list(temp_index).blocks = min_keep;
                buyers_list = buyers_list(1:temp_index);
            else
                buyers_list = buyers_list(1:temp_index-1);
            end
            
            node(seller).buyers_list =  buyers_list;
        else   % The total blocks demanded are within the capacity of seller. The original buyer_list is correct, and no node needes to be updated for deallocation.
            node(seller).buyers_list = buyers_list;
        end
    end
end

% Updating the total blocks sold by the seller
node(seller).sold_blocks =  totalBlocks(node,seller);    
end
    
    