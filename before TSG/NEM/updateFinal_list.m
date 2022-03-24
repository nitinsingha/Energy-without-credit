% Calling function: [node]=energy_trade(node)
function [node] = updateFinal_list(sellers,buyers,node)
%This function creates final buyer_list for sellers and final mapping list
%for buyers. These final list stores the grouping of sellers with buyers in
%IEM algorithm. The buyer_list and mapping list used for sellers and buyers respectivel used in EM can't be used for stroing final list in IEM. The reason being, these list get updated after each round of IEM algorithm. 

% Updating final list for sellers
for itrs = 1:length(sellers) 
    if(~isempty(node(sellers(itrs)).buyers_list))
        node(sellers(itrs)).final_buyers_list = [node(sellers(itrs)).final_buyers_list; node(sellers(itrs)).buyers_list];
    end
end

% Updating final list for buyers
for itrs = 1:length(buyers) 
    if(~isempty(node(buyers(itrs)).mapping))
     node(buyers(itrs)).final_mapping = [node(buyers(itrs)).final_mapping; node(buyers(itrs)).mapping];
    end
end
end

