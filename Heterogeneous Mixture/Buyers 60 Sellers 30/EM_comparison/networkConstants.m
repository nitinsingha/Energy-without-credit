function [CONST] = networkConstants()
% Stores and returns all the constant values in the network


CONST.n=90;100;  % Total number of members in the network
CONST.total_sellers = 30; % Total number of sellers in a given round. Floor function used, so that sellers are always integer in number
CONST.DSO_block_cost=20;      % Cost of single enrgy block in the network
CONST.sim_rnd=1;          % Total simulations in the network.
CONST.rnd=1;2000;1000;
end

