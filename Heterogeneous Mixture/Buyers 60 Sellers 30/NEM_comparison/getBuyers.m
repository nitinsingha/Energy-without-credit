%calling function function [node]=energy_matching(sellers,buyers,node)

% This function returns list of buyers who can participate in energy
% matching process. If their is no buyer left, the enrgy matching algorithm
% terminates.
function [remainingBuyers] = getBuyers(node,buyers)
remainingBuyers =[];
for i = 1:length(buyers)
    if((node(buyers(i)).request > node(buyers(i)).request_fullfilled) && length(node(buyers(i)).unProcessedList)>0)
       remainingBuyers = [remainingBuyers;buyers(i)];
    end
end
        