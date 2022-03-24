% Callling function: start
function [avg_buying_price,avg_selling_price] = getIncome(node)
% Calculate the total income earned by buyers and sellers in the round
ttl_Incm_Sel = 0;   % Stores total income earned by all the sellers in a round.
avg_Incm_Sel = 0;   % Stores average income of all the sellers in a round.
ttl_Incm_Buy = 0;   % Stores total income earned by all the buyers in a round.
avg_Incm_Buy = 0;   % Stores avergae income of all the buyers in a round.

% Since buyers end up spending, so their income is negative

% Retrieving  network constants.
CONST=networkConstants();  
n=CONST.n;   % Total number of nodes in the network;


for itr =1:1:n
    if (node(itr).type==0)  % Buyer
        ttl_Incm_Buy = ttl_Incm_Buy + node(itr).income_round;
    elseif(node(itr).type==1)   % Seller
        ttl_Incm_Sel = ttl_Incm_Sel + node(itr).income_round;
    end
end   
avg_Incm_Buy = ttl_Incm_Buy/(n/2); 
avg_Incm_Sel = ttl_Incm_Sel/(n/2);  

