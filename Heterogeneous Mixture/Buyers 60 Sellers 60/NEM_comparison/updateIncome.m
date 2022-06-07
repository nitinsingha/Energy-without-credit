function [node]=updateIncome(node)
% Updates the total income of different users.
% For buyers income will be negative as they have to purchase energy
% For sellers income will be positive as they sell energy

% Retrieving  network constants.
CONST=networkConstants();  
n=CONST.n;   % Total number of nodes in the network;


for itr = 1:1:n
    list = [];       % This list is a structure storing details about the transaction
    if(node(itr).type==0)   % Buyer
        list = node(itr).mapping; % The details about all the transactions made by a buyer are stored in strucutr mapping. Refer file "creating_buyers.m" for details.
        for itr1 =1:1:length(list)
            node(itr).income_round = node(itr).income_round - list(itr1).blocks*list(itr1).selling_price; 
        end  
    elseif (node(itr).type==1)  % Seller
        list = node(itr).buyers_list; % The details about all the transactions made by seller are stored in strucutr buyers_list. Refer file "creating_sellers.m" for details.
        for itr1 =1:1:length(list)
            node(itr).income_round = node(itr).income_round + list(itr1).blocks*list(itr1).selling_price; 
        end  
    end 
end    

end

