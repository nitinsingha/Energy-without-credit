function [node] = price_update_iterative(sellers, buyers, deltas, deltab, node)

% Function to update bids of sellers and buyers in between iterations
for i=1:length(sellers)
    node(sellers(i)).bidPrice = node(sellers(i)).bidPrice - deltas(i);
end

for i=1:length(buyers)
    node(buyers(i)).bidPrice = node(buyers(i)).bidPrice + deltab(i);
end
end

