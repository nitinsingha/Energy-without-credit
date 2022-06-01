% Calling function: [avg_rnd_income, income_round1, income_round2, income_round3, income_round4, income_round5]=logIncome(node,Id1,Id2,Id3,Id4,Id5);

function [sellers,buyers]=list_sellers_buyers(node)
% Returns list of sellers and buyers

% Retrieving  network constants.
CONST=networkConstants();  
n=CONST.n;   % Total number of nodes in the network;
total_sellers=CONST.total_sellers;   % Total number of sellers in the network;

sellers=zeros(1,total_sellers);   % Maintains list of sellers
buyers=zeros(1,n-total_sellers);  % Maintains list of buyers 
itrb=0;   % Counter tracking buyers
itrs=0;   % Counter tracking sellers
for itr =1:1:n
    if (node(itr).type==0)
        itrb=itrb+1;
        buyers(itrb)=itr;
    elseif (node(itr).type==1)
        itrs=itrs+1;
        sellers(itrs)=itr;
    else
        disp('A node exist which is neither seller nor buyer');
        dasiplay();  % This stops simulation and creates an error
    end    
end
end