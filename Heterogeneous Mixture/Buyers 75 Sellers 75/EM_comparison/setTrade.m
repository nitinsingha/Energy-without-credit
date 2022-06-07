function [avg_service_rnd, avg_request_rnd,trade1, trade2, trade3, trade4, trade5]=setTrade()

% Initializing variable storing blocks.

% Retreiving network constants
[CONST] = networkConstants();
sim_rnd=CONST.sim_rnd;   % Total simulation in the network;
rnd=CONST.rnd;           % Total rounds in the network;

        %  It stores how much blocks  traded by the given nide
        trade1=zeros(sim_rnd,rnd);
        trade2=zeros(sim_rnd,rnd);
        trade3=zeros(sim_rnd,rnd);
        trade4=zeros(sim_rnd,rnd);
        trade5=zeros(sim_rnd,rnd);
        avg_service_rnd=zeros(sim_rnd,rnd);
        avg_request_rnd=zeros(sim_rnd,rnd);
end