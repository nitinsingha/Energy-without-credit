% Callling function: start
function [avg_buying_price,avg_selling_price] = get_NormalizedIncome(node)
% Calculate the total income earned by buyers and sellers in the round
ttl_Incm_Sel = 0;       % Stores total income earned by all the sellers in a round.
ttl_supply_Sel= 0;      % Stores total supply by the sellers. 
ttl_spent_Buy = 0;       % Stores total money spent  by all the buyers in a round.
ttl_demand_Buy = 0;     % Stores total demand by buyers
avg_selling_price = 0;  % Stores average selling price per unit supply.
avg_buying_price = 0;   % Stores avergae buying price per unit demand.

% Since buyers end up spending, so their income is negative

% Retrieving  network constants.
CONST=networkConstants();  
n=CONST.n;   % Total number of nodes in the network;


for itr =1:1:n
    if (node(itr).type==0)  % Buyer
        ttl_spent_Buy = ttl_spent_Buy + node(itr).income_round;   % Since buyers end up spending, so their income is negative
        ttl_demand_Buy = ttl_demand_Buy + node(itr).request_fullfilled;
    elseif(node(itr).type==1)   % Seller
        ttl_Incm_Sel = ttl_Incm_Sel + node(itr).income_round; 
        ttl_supply_Sel = ttl_supply_Sel + node(itr).sold_blocks;
    end
end   
avg_buying_price = ttl_spent_Buy/ttl_demand_Buy; 
avg_selling_price = ttl_Incm_Sel/ttl_supply_Sel;  

