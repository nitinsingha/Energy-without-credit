% Calling function: [node] = normalization(sellers, buyers, node)

function [node] = setNormalized_Bids(avgB, avgS, node)
% Normalizing bids of sellers and buyers for compariosn with other algorithms

% Retreiving network constants
[CONST] = networkConstants();
n = CONST.n;
total_sellers = CONST.total_sellers;    % Total number of sellers in the network.

total_buyers = n - total_sellers;       % Total number of buyers in the network.

[sellers,buyers] = list_sellers_buyers(node); % Function returns list of a seller and buyer for the current round.

% adjusting bids of sellers
% There are 5 different types of sellers, proving 5 different bids, such
% that average bid of sellers network is same as double price auction.
for itrs=1:1:total_sellers
    var=mod(itrs,5);             % Since their are 5 different type of sellers.
    switch var
        case 0
            avgS_perBlock = (avgS-2*(avgS/10))/node(sellers(itrs)).service;           % The avgS contains average price for all the blocks offered by a seller. avgS_perBlock contains average price per unit block. 
            node(sellers(itrs)).bidPrice = avgS_perBlock;
            node(sellers(itrs)).initialBid = node(sellers(itrs)).bidPrice;
        case 1
            avgS_perBlock = (avgS-(avgS/10))/node(sellers(itrs)).service;
            node(sellers(itrs)).bidPrice = avgS_perBlock;
            node(sellers(itrs)).initialBid = node(sellers(itrs)).bidPrice;
        case 2
            avgS_perBlock = avgS/node(sellers(itrs)).service;     
            node(sellers(itrs)).bidPrice = avgS_perBlock;
            node(sellers(itrs)).initialBid = node(sellers(itrs)).bidPrice;
        case 3
            avgS_perBlock = (avgS+(avgS/10))/node(sellers(itrs)).service;
            node(sellers(itrs)).bidPrice = avgS_perBlock;
            node(sellers(itrs)).initialBid = node(sellers(itrs)).bidPrice;
        case 4
            avgS_perBlock = (avgS+2*(avgS/10))/node(sellers(itrs)).service;
            node(sellers(itrs)).bidPrice = avgS_perBlock;
            node(sellers(itrs)).initialBid = node(sellers(itrs)).bidPrice;
    end    
end

% adjusting bids of sellers
% There are 5 different types of sellers, proving 5 different bids, such
% that average bid of buyers in the network is same as double price auction.

for itrb=1:1:total_buyers
    var=mod(itrb,5);     % Since their are 5 different type of buyers.
    switch var
        case 0
            avgB_perBlock = (avgB-2*(avgB/10))/node(buyers(itrb)).request;       % The avgB contains average price quoted for all the blocks demanded by a buyer. avgS_perBlock contains average price per unit block. 
            node(buyers(itrb)).bidPrice = avgB_perBlock;
            node(buyers(itrb)).initialBid = node(buyers(itrb)).bidPrice;
        case 1
            avgB_perBlock = (avgB-(avgB/10))/node(buyers(itrb)).request;
            node(buyers(itrb)).bidPrice = avgB_perBlock;
            node(buyers(itrb)).initialBid = node(buyers(itrb)).bidPrice;
        case 2
            avgB_perBlock = avgB/node(buyers(itrb)).request;
            node(buyers(itrb)).bidPrice = avgB_perBlock;
            node(buyers(itrb)).initialBid = node(buyers(itrb)).bidPrice;
        case 3
            avgB_perBlock = (avgB+(avgB/10))/node(buyers(itrb)).request;
            node(buyers(itrb)).bidPrice = avgB_perBlock;
            node(buyers(itrb)).initialBid = node(buyers(itrb)).bidPrice;
        case 4
            avgB_perBlock = (avgB+2*(avgB/10))/node(buyers(itrb)).request;
            node(buyers(itrb)).bidPrice = avgB_perBlock;
            node(buyers(itrb)).initialBid = node(buyers(itrb)).bidPrice;
    end    
end

end

