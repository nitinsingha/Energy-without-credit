function [bids, bidb,D_mal,C_mal]=get_mal_sel_Bids(m,n,avgB,avgS,D,C,rho)
%This function returns bids of sellers and buyers in the network. The bids
%are normalized, such that mean of all the sellers bid is same as sellers average in double price auction.
% Same is for the buyers.


bids=zeros(m,1);                % bid by sellers
bidb=zeros(n,1);                % bids by buyers 

D_mal=zeros(n,m);               % Malicious supply matrix for sellers. It contains supply profile for 15 most expensive sellers in the market.  

% adjusting bids of sellers
% There are 5 different types of sellers, proving 5 different bids, such
% that average bid of sellers network is same as double price auction.

for itrs=1:1:m
    var=mod(itrs,5);             % Since their are 5 different type of sellers.
    switch var
        case 0
            bids(itrs)=0;
        case 1
            bids(itrs)=0;
        case 2
            bids(itrs)=0;
        case 3
            bids(itrs)=0;
            if(itrs>13)    % There are $15$ malicious sellers in the network. This condition removes first 3 sllers out of 9 sellers in the group
                bids(itrs)=avgS+(avgS/10);
                D_mal(:,itrs)=D(:,itrs);
            end    
        case 4
            bids(itrs)=avgS+2*(avgS/10);
            D_mal(:,itrs)=D(:,itrs);
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

% Adugusting supply and demand
C_mal=rho*D_mal;                  


end

