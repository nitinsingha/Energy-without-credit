function [deltas, deltab] = compute_delta(node,sellers,buyers, iter)

%This function calculates respective deltas for sellers and buyers

% Retrieving network constants 
CONST = networkConstants();
minisp = CONST.DSO_block_requisiton_cost;    % This is block cost offeredd by DSO for purchasing a block from the seller. 
maxibp = CONST.DSO_block_cost;               % The price at which DSO is selling electricity. 


deltas = zeros(length(sellers), 1);
deltab = zeros(length(buyers), 1);

for i=1:length(sellers)
    deltas(i) = (node(sellers(i)).initialBid - minisp)/iter;
end

for i=1:length(buyers)
    deltab(i) = (maxibp - node(buyers(i)).initialBid)/iter;
end
end

