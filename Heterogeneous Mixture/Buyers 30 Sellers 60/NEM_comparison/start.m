
clc;
clear all;
close all;

% Initializing network variable
[avg_currency_rnd, currency1, currency2, currency3, currency4, currency5, avg_service_rnd, avg_request_rnd, trade1, trade2, trade3, trade4, trade5, total_rnd_income, total_rnd_income_DSO, total_rnd_income_sellers, income_round1, income_round2, income_round3, income_round4, income_round5] = log_varibale_Initilization();
% [blocks_1, blocks_2, blocks_3, blocks_4, blocks_5]=setBlock();
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
      % Load data from the previous file.
    [D,C,B,S,rewd]=getData();           
    %Calculating average value of loaded data
    avgD =  round(mean(sum(D,1)));      % Average demand of buyers. The average demand is rounded to the nearest integer.
    avgC =  round(mean(sum(C,1)));      % Average supply by sellers. The average supply is rounded to the nearest integer.
    avgB =  (mean(sum(B,1)));      % Average bid of a buyer. 
    avgS =  (mean(sum(S,1)));      % Average bid by a seller.
    for itrrnd=1:1:rnd
        Simulation = [itrsim itrrnd]
        node=nwk_round_reset(node);    % Resseting the node after end of the round
        node = creating_sellers_buyers(node);   % Creating sellers and buyers for the node
        node = normalization(avgD, avgC, avgB, avgS, node);     % This function normalizes the supply and the demand, selling price, and buying price of sellers and buyers 
        node = energy_trade(node);        
        
        % Generating logs
       [avg_buying_price,avg_selling_price] = get_NormalizedIncome(node);
        avg_buying_price
        avg_selling_price
    end    
end
if(sim_rnd==1)
    avg_total_rnd_income_DSO=total_rnd_income_DSO;
else
    avg_total_rnd_income_DSO=mean(total_rnd_income_DSO);
end    
% save 'D:/Dropbox/code/Energy/Energy without credit/data';
disp('End of simulation');