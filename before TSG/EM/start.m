
clc;
clear all;
close all;

% Initializing network variable
[avg_currency_rnd, currency1, currency2, currency3, currency4, currency5, avg_service_rnd, avg_request_rnd, trade1, trade2, trade3, trade4, trade5, total_rnd_income, total_rnd_income_DSO, total_rnd_income_sellers, income_round1, income_round2, income_round3, income_round4, income_round5] = log_varibale_Initilization();
%[blocks_1, blocks_2, blocks_3, blocks_4, blocks_5]=setBlock();
% Retreiving network constants
[CONST] = networkConstants();
global COORDINATES;     % This variable stores the loction of all the nodes in the network
COORDINATES = generate_coordinates();   
sim_rnd=CONST.sim_rnd;   % Total simulation in the network;
rnd=CONST.rnd;           % Total rounds in the network;

disp('Start of simulation');
for itrsim=1:1:sim_rnd%5
    Simulaion = itrsim
    % Creating a trading network.
    [node] = create_trading_network();    
    for itrrnd=1:1:rnd%2000
        Simulation = [itrsim itrrnd]
        node=nwk_round_reset(node);    % Resseting the node after end of the round
        node=creating_sellers_buyers(node);   % Creating sellers and buyers for the node
        node = setBids(node);                    % This function set bids of the seler and buyers
        node = setRequirement(node);             % This function sets the requirement of sellers and buyers in the network
        node=energy_trade(node);        
        
        % Generating logs
        Id1=1;Id2=2;Id3=3;Id4=4;Id5=5;
        [avg_currency_rnd(itrsim,itrrnd), currency1(itrsim,itrrnd), currency2(itrsim,itrrnd), currency3(itrsim,itrrnd), currency4(itrsim,itrrnd), currency5(itrsim,itrrnd), avg_service_rnd(itrsim,itrrnd), avg_request_rnd(itrsim,itrrnd), trade1(itrsim,itrrnd), trade2(itrsim,itrrnd), trade3(itrsim,itrrnd), trade4(itrsim,itrrnd), trade5(itrsim,itrrnd), total_rnd_income(itrsim,itrrnd), income_round1(itrsim,itrrnd), income_round2(itrsim,itrrnd), income_round3(itrsim,itrrnd), income_round4(itrsim,itrrnd), income_round5(itrsim,itrrnd)]=logVariables(node);
        [blocks_1(itrsim,itrrnd), blocks_2(itrsim,itrrnd), blocks_3(itrsim,itrrnd), blocks_4(itrsim,itrrnd), blocks_5(itrsim,itrrnd)]=logBlock(node,Id1,Id2,Id3,Id4,Id5);
        [ttl_Incm_Sel, avg_Incm_Sel,ttl_Incm_Buy,avg_Incm_Buy] = getIncome(node); 
        ttl_Incm_Sel
        avg_Incm_Sel
        ttl_Incm_Buy
        avg_Incm_Buy
    end    
end
if(sim_rnd==1)
    avg_total_rnd_income_DSO=total_rnd_income_DSO;
else
    avg_total_rnd_income_DSO=mean(total_rnd_income_DSO);
end    
% save 'D:/Dropbox/code/Energy/Energy without credit/data';

disp('End of simulation');