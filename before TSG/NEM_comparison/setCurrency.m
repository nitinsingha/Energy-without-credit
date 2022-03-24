%Calling function : main
function [avg_currency_rnd, currency1, currency2, currency3, currency4, currency5]=setCurrency()

% Initializing variable storing currency.

% Retreiving network constants
[CONST] = networkConstants();
sim_rnd=CONST.sim_rnd;   % Total simulation in the network;
rnd=CONST.rnd;           % Total rounds in the network;

        % Setting the currency  variable. It stroes currency available with the node
        currency1=zeros(sim_rnd,rnd);
        currency2=zeros(sim_rnd,rnd);
        currency3=zeros(sim_rnd,rnd);
        currency4=zeros(sim_rnd,rnd);
        currency5=zeros(sim_rnd,rnd);
        avg_currency_rnd=zeros(sim_rnd,rnd);   % averge currency per round
        
       

end

