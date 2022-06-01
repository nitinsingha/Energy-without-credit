%calling function main

function [blocks_1, blocks_2, blocks_3, blocks_4, blocks_5]=setBlock()

% Initializing variable storing blocks.

% Retreiving network constants
[CONST] = networkConstants();
sim_rnd=CONST.sim_rnd;   % Total simulation in the network;
rnd=CONST.rnd;           % Total rounds in the network;

        %  It stores how much blocks  requirement is at node, before the
        %  starting of round
        blocks_1=zeros(sim_rnd,rnd);
        blocks_2=zeros(sim_rnd,rnd);
        blocks_3=zeros(sim_rnd,rnd);
        blocks_4=zeros(sim_rnd,rnd);
        blocks_5=zeros(sim_rnd,rnd);
end