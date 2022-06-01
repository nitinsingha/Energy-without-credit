function [ttl_S, ttl_B,ttl_D,ttl_C]=get_mal_buy_Bids(m,n,avgB,avgS,D,C,rho,DSO_reward_ratio)
%This function returns bids of sellers and buyers in the network. The bids
%are normalized, such that mean of all the sellers bid is same as sellers average in double price auction.
% Same is for the buyers.


bids=zeros(m,1);                % bid by sellers
bidb=zeros(n,1);                % bids by buyers 

cnt_mal=15; % Counter for malicious buyers
% adjusting bids of sellers
% There are 5 different types of sellers, proving 5 different bids, such
% that average bid of sellers network is same as double price auction. To
% facilitate buyers, the central authority is only showing sellers with
% minimum selling price

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
% D_sel is 1*m matrix, that contains the total supply by all the sellers.
D_sel=sum(D,1);

% We are assuming first 15 buyers are malicious. C_mttl contains total demand of the malicious buyers.
C_mttl=sum(C(1:cnt_mal,:),'all');

% The current requirement for energy, that remains unsatisfied for the malicious buyers. 
C_mcrnt=C_mttl;
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
% We have sorted sellers in incresing order of their bids. indcs contain
% the indices of the sorted element. indcs(1) contain indices of seller
% with the lowest bid.
[bids_sorted,indcs] = sort(bids,'ascend');

% We calculate the supply matrix of seller. Only the seller with lowest
% price, such that they fulfill demand of malicious buyers will be able to
% sell electricity. Remaining sellers supply will be 0.


itrs=1; % Counter for incimenting indc array

D_mttl=0;   % Total supply of all the  seller;
for itrb=1:1:cnt_mal
    crnt_seller = indcs(itrs);
    C_mcrnt = C_mcrnt - rho*D_sel(crnt_seller);   % The unsatisfied demand of malicious buyers
    D_mttl=D_mttl+D_sel(crnt_seller);        % Updating total supply of all the sellers
    if(C_mcrnt<=0.0001)   % It is considering very small of C_mcrnt and generating the error. This small value is generated due to rounding off error.
        break;
    end    
    itrs=itrs+1;
end
ttl_sel=itrs;              % Total amount of sellers involved in trading;
% Updating total bids ,supply and demand variables
ttl_S=sum(bids_sorted(1:ttl_sel,:));     % The average bids by the sellers
ttl_B=DSO_reward_ratio*ttl_S;
ttl_D=D_mttl;
ttl_C= C_mttl;

end

