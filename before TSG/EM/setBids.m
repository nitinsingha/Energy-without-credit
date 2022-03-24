% Calling function : start

function [node] = setBids(node)
% This function sets bids of the sellers and buyrs in the network.


% Retreiving network constants
[CONST] = networkConstants();
n = CONST.n;
total_sellers = CONST.total_sellers;    % Total number of sellers in the network.

total_buyers = n - total_sellers;       % Total number of buyers in the network.

[sellers,buyers] = list_sellers_buyers(node); % Function returns list of a seller and buyer for the current round.

% adjusting bids of sellers
% There are 5 different types of sellers, proving 5 different bids, viz., 5,6,7,8,9,10.
for itrs=1:1:total_sellers
    vars=mod(itrs,5);             % Since their are 5 different type of sellers.
    switch vars
        case 0
             node(sellers(itrs)).bidPrice = 10;
        case 1
            node(sellers(itrs)).bidPrice = 6;
        case 2
            node(sellers(itrs)).bidPrice = 7;
        case 3
            node(sellers(itrs)).bidPrice = 8;
        case 4
            node(sellers(itrs)).bidPrice = 9;
    end    
end

% adjusting bids of buyers
% There are 5 different types of buyers, proving 5 different bids, viz., 5,6,7,8,9,10.

for itrb=1:1:total_buyers
    varb=mod(itrb,5);     % Since their are 5 different type of buyers.
    switch varb
        case 0
            node(buyers(itrb)).bidPrice = 10;
        case 1
            node(buyers(itrb)).bidPrice = 6;
        case 2
            node(buyers(itrb)).bidPrice = 7;
        case 3
            node(buyers(itrb)).bidPrice = 8;
        case 4
            node(buyers(itrb)).bidPrice = 9;
    end    
end

end

