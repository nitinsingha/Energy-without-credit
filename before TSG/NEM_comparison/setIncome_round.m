%Calling function: main
function [total_rnd_income, total_rnd_income_DSO, total_rnd_income_sellers, income_round1, income_round2, income_round3, income_round4, income_round5]=setIncome_round()

% Initializing variable storing cost.

% Retreiving network constants
[CONST] = networkConstants();
sim_rnd=CONST.sim_rnd;   % Total simulation in the network;
rnd=CONST.rnd;           % Total rounds in the network;

            
        % Setting the net income in the current round. Income will be
        % positive if node is seller, otherwise it will be negative.
        income_round1=zeros(sim_rnd,rnd);
        income_round2=zeros(sim_rnd,rnd);
        income_round3=zeros(sim_rnd,rnd);
        income_round4=zeros(sim_rnd,rnd);
        income_round5=zeros(sim_rnd,rnd);
        total_rnd_income=zeros(sim_rnd,rnd);
        total_rnd_income_DSO=zeros(sim_rnd,rnd);
        total_rnd_income_sellers=zeros(sim_rnd,rnd);
        

end

