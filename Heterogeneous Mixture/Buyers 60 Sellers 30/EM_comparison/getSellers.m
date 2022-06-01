%calling function function [node]=energy_matching(sellers,buyers,node)

function [current_sellers] = getSellers(node,sellers)
current_sellers = [];
for i = 1:length(sellers)
    if(~isempty(node(sellers(i)).requestList))
        current_sellers = [current_sellers;sellers(i)];
    end
end