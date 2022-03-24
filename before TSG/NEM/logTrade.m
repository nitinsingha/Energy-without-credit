%calling function : logVriable;

function [avg_service_rnd, avg_request_rnd, trade1, trade2, trade3, trade4, trade5]=logTrade(node,Id1,Id2,Id3,Id4,Id5)
% trade = Service- request gives how much blocks sold by node    

% Retrieving  network constants.
CONST=networkConstants();  
n=CONST.n;   % Total number of nodes in the network
if(node(Id1).type==0)
    trade1=-node(Id1).request_fullfilled;
else
    trade1=node(Id1).sold_blocks;
end  
if(node(Id2).type==0)
    trade2=-node(Id2).request_fullfilled;
else
    trade2=node(Id2).sold_blocks;
end   
if(node(Id3).type==0)
    trade3=-node(Id3).request_fullfilled;
else
    trade3=node(Id3).sold_blocks;
end  
if(node(Id4).type==0)
    trade4=-node(Id4).request_fullfilled;
else
    trade4=node(Id4).sold_blocks;
end   
if(node(Id5).type==0)
    trade5=-node(Id5).request_fullfilled;
else
    trade5=node(Id5).sold_blocks;
end  

% I am including all the nodes, eventhough I should include only serving
% nodes. This also gives correct answer as for  nodes which are not serving
% nodes node(itr).sold_blocks is 0
total_service_rnd=0;    % The total service provided by all the serving nodes
for itr=1:1:n   % Calculating total_rnd_income
    total_service_rnd=total_service_rnd+node(itr).sold_blocks;   
end

total_request_rnd=0;    % The total request fullfilled by all the requesting nodes.
for itr=1:1:n   % Calculating total_rnd_income
    total_request_rnd=total_request_rnd+node(itr).request_fullfilled;
end

avg_service_rnd=mean(total_service_rnd);   % Average services provided in a given round
avg_request_rnd=mean(total_request_rnd);   % Average requests generated in a given round
end

