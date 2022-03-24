% Calling function: [node]=energy_trade(node)
function [node] = updateBlocks_traded(sellers,buyers,node)
%This function updates request_fulfilled variable (for buyer) and
%sold_blocks varible (for seller)

% Udating solf_blocks variable for each seller
for itrs = 1:length(sellers) 
    sold_blocks = 0; % Keeps count of blocks sold
    if(~isempty(node(sellers(itrs)).final_buyers_list))
        for itr =1:length(node(sellers(itrs)).final_buyers_list) 
            sold_blocks = sold_blocks + node(sellers(itrs)).final_buyers_list(itr).blocks;
        end
    end
    node(sellers(itrs)).sold_blocks = sold_blocks;
end

% Udating request_fulfilled variable for each buyer
for itrb = 1:length(buyers) 
    request_fulfilled = 0;   % Keeps count of request fulfilled for  buyer
    if(~isempty(node(buyers(itrb)).final_mapping))
        for itr =1:length(node(buyers(itrb)).final_mapping) 
            request_fulfilled = request_fulfilled + node(buyers(itrb)).final_mapping(itr).blocks;
        end
    end
    node(buyers(itrb)).request_fulfilled = request_fulfilled;
end
end

