function [CONST] = networkConstants()
% Stores and returns all the constant values in the network


CONST.n=90;  % Total number of members in the network
CONST.total_sellers = floor(CONST.n/2); % Total number of sellers in a given round. Floor function used, so that sellers are always integer in number
CONST.DSO_block_cost = 10;      % Cost at which DSO sells a block.
CONST.DSO_block_requisiton_cost = 6;  % Cost of single energy block, offered by DSO to seller.
CONST.sim_rnd=1;          % Total simulations in the network.
CONST.rnd=1;2000;1000;    % Total rounds 
CONST.Total_iter = 6;     % Total iterations in IEM algorithm
end

