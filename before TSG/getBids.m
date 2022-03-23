function [bids, bidb]=getBids(m,n,avgB,avgS)
%This function returns bids of sellers and buyers in the network. The bids
%are normalized, such that mean of all the sellers bid is same as sellers average in double price auction.
% Same is for the buyers.


bids=zeros(m,1);                % bid by sellers
bidb=zeros(n,1);                % bids by buyers 

% adjusting bids of sellers
% There are 5 different types of sellers, proving 5 different bids, such
% that average bid of sellers network is same as double price auction.
for itrs=1:1:m
    var=mod(itrs,5);             % Since their are 5 different type of sellers.
    switch var
        case 0
            bids(itrs)=avgS-2*(avgS/10);
        case 1
            bids(itrs)=avgS-(avgS/10);
        case 2
            bids(itrs)=avgS;
        case 3
            bids(itrs)=avgS+(avgS/10);
        case 4
            bids(itrs)=avgS+2*(avgS/10);
    end    
end

% adjusting bids of sellers
% There are 5 different types of sellers, proving 5 different bids, such
% that average bid of buyers in the network is same as double price auction.

for itrb=1:1:n
    var=mod(itrb,5);     % Since their are 5 different type of buyers.
    switch var
        case 0
            bidb(itrb)=avgB-2*(avgB/10);
        case 1
            bidb(itrb)=avgB-(avgB/10);
        case 2
            bidb(itrb)=avgB;
        case 3
            bidb(itrb)=avgB+(avgB/10);
        case 4
            bidb(itrb)=avgB+2*(avgB/10);
    end    
end


end

