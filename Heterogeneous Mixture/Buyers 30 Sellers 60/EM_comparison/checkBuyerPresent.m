%calling function performTrade

%checks whether the buyer already exists and returns the buyers index

function [isPresent,index] = checkBuyerPresent(buyers_list,buyers_id)
% isPresent is 1 if buyer_id is already present in buyer_list
% index gives the position in buyer_list, where the buyer is present.

isPresent = 0;
index = -1;
for i = 1:length(buyers_list)
    if buyers_list(i).buyers_id == buyers_id
        isPresent = 1;
        index = i;
        return ;
    end
end