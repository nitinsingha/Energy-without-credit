% Calling function: start.m
function [node] = normalization(avgD, avgC, avgB, avgS, node)
% This function normalizes the supply and the demand, selling price, and buying price of sellers and buyers 

%normalizing supply and demand       
node = setNormalized_SupplyDemand(avgD, avgC, node);

% normalizing bids of sellers and buyers
node = setNormalized_Bids(avgB, avgS, node);
end

