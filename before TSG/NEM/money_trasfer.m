%Calling function:[node]=simple_matching(sellers,buyers,node,n,total_sellers);

function [node]=money_trasfer(node,curnt_buyer,curnt_seller,blocks_traded)
% This function transers money for the blocks transffered from seller
% to receiver.
 
  block_cost=node(curnt_seller).block_cost;     % Cost of a single block, sold by the seller;
  ttl_cost_energy_traded=block_cost*blocks_traded;  % Total cost of energy that is traded;
  
  % The buyer will pay the amount to the seller
  node(curnt_buyer).currency=(node(curnt_buyer).currency)-(ttl_cost_energy_traded);
  node(curnt_seller).currency=(node(curnt_seller).currency)+(ttl_cost_energy_traded);
  
  % Updating income earned by a buyer and seller in the current round
  node(curnt_buyer).income_round=(node(curnt_buyer).income_round)-(ttl_cost_energy_traded);
  node(curnt_seller).income_round=(node(curnt_seller).income_round)+(ttl_cost_energy_traded);
end

