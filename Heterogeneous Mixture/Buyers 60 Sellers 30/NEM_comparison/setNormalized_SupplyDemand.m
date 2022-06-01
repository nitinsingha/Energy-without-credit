% Calling function: [node] = normalization(sellers, buyers, node)

function node = setNormalized_SupplyDemand(avgD, avgC, node)
% Normalizing supply and demand of sellers and buyers for compariosn with other algorithms

% Retreiving network constants
[CONST] = networkConstants();
n = CONST.n;                            % Total number of users in the network. 

for itr =1:1:n
    if(node(itr).type==1)                  % For sellers
        node(itr).service = avgC;          % Setting supply equal to the average supply by the sellers in double auction mechanism. The average supply in double auction mechanism is rounded to nearest integer.
        node(itr).ini_service = node(itr).service;
    elseif(node(itr).type==0)              % For buyers
        node(itr).request = avgD;          % Setting supply equal to the average demand by the buyers in double auction mechanism. The average demand in double auction mechanism is rounded to nearest integer.
        node(itr).ini_request = node(itr).request;
    end    
end 

end