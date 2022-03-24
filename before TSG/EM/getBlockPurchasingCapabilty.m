% Caling function: getBlocksTraded(node,curnt_buyer,curnt_seller,blocks_required,unsold_blocks)
function [blocks_purchasing_capabilty] = getBlockPurchasingCapabilty(node,curnt_buyer,curnt_seller)
    % The function returns block purchasing capabilty of curnt_buyer w.r.t curnt_seller
    money_available=node(curnt_buyer).currency;
    block_cost=node(curnt_seller).block_cost;
    blocks_purchasing_capabilty=floor(money_available/block_cost);   % The purchasing capabilty of the buyer
end

