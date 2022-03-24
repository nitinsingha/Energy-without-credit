% Calling function: [node]=energy_trade(node,n,total_sellers)

function [sellers,buyers]=list_sellers_buyers_iter(node)
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
        if (node(itr).ini_request ~= node(itr).request_fulfilled)
            itrb=itrb+1;
            buyers(itrb)=itr;
        end
    elseif (node(itr).type==1)
        if (node(itr).ini_service ~= node(itr).sold_blocks)
            itrs=itrs+1;
            sellers(itrs)=itr;
        end
    else
        disp('A node exist which is neither seller nor buyer');
        dasiplay();  % This stops simulation and creates an error
    end    
end
buyers = buyers(1:find(buyers,1,'last'));
sellers = sellers(1:find(sellers,1,'last'));
end