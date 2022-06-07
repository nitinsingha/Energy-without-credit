% Calling function: main

function [node]=energy_trade(node)
% This function caters to the trading process between the nodes.

[sellers,buyers] = list_sellers_buyers(node); % Function returns list of a seller and buyer for the current round.

[node] = energy_matching(sellers,buyers,node); % Forming groups of sellers with buyers

[node]=updateIncome(node);   % This function updates the income variable of diffderen users.

end

