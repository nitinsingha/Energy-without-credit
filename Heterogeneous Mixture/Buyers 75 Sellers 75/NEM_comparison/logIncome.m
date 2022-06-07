%calling function : logVriable;

%function [total_rnd_income, total_rnd_income_DSO, total_rnd_income_sellers, income_round1, income_round2, income_round3, income_round4, income_round5]=logIncome(node,Id1,Id2,Id3,Id4,Id5)

function [total_rnd_income, income_round1, income_round2, income_round3, income_round4, income_round5]=logIncome(node,Id1,Id2,Id3,Id4,Id5)
% Retrieving  network constants.
CONST=networkConstants();  
n=CONST.n;   % Total number of nodes in the network
total_sellers=CONST.total_sellers;   % Total number of sellers in the network;

% Net profit earned in a given
income_round1=node(Id1).income_round;
income_round2=node(Id2).income_round;
income_round3=node(Id3).income_round;
income_round4=node(Id4).income_round;
income_round5=node(Id5).income_round;

total_rnd_income=0;    % The total income of all the nodes in a given round.
[sellers,buyers]=list_sellers_buyers(node);            % List of sellers and buyers  

for itr=1:1:total_sellers      % This loop aggregates the income of all the sellers
    current_seller=sellers(itr);
    total_rnd_income=total_rnd_income+node(current_seller).income_round;
end 
end

