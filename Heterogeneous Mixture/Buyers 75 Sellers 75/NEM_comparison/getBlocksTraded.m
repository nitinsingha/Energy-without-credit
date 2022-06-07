% Caling function: simple_matching(sellers,buyers,node)
function [blocks_traded]=getBlocksTraded(node,curnt_buyer,curnt_seller,blocks_required,unsold_blocks)
% Returns how much blocks are traded between curnt_buyer and curnt_seller
    
    % The purchasing capabilty of the buyer
    blocks_purchasing_capabilty= getBlockPurchasingCapabilty(node,curnt_buyer,curnt_seller);   
    blocks_traded=min([blocks_purchasing_capabilty,blocks_required, unsold_blocks]);
end

  