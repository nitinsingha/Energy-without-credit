%calling function : logVriable;

function [avg_currency_rnd, currency1, currency2, currency3, currency4, currency5]=logCurrency(node,Id1,Id2,Id3,Id4,Id5)
% Collect currency of various nodes

% Retrieving  network constants.
CONST=networkConstants(); 
n=CONST.n;   % Total nodes in the network

% Total currency available with node for a given time; 
currency1=node(Id1).currency;                   
currency2=node(Id2).currency; 
currency3=node(Id3).currency; 
currency4=node(Id4).currency; 
currency5=node(Id5).currency; 


total_currency_rnd=0;    % The total currency available with all the nodes in a given round.
for itr=1:1:n   % Calculating total_currency_rnd
    total_currency_rnd=total_currency_rnd+node(itr).currency;
end
avg_currency_rnd=mean(total_currency_rnd);   % Average currency at a node in a given round
end

