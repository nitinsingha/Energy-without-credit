function [node] = create_trading_network()
%It creates 100 nodes, where 50 nodes supply energy and 50 nuodes purchase
%energy.
% Nodes are the components which trade energy. 

% Retrieving  network constants.
CONST=networkConstants();  
n=CONST.n;   % Total number of nodes in the network

% Initializing various nodes in the network.
for itr=1:1:n
    node(itr).type=0;          % Type =0 buyer, Type = 1 seller
    node(itr).currency=100;     % Total currency available with node
    node(itr).loan=0;          % Amount of loan taken by the node from the DSO
    node(itr).loand_default=0; % Its value is 1 if a node defaulted on loan. 
    node(itr).sellers=zeros(1,5); % Contains Id of sellers from which blocks are purchased
    node(itr).service=0;       % Total blocks of energy available at node for selling.
    node(itr).buyers=zeros(1,5);  % The id of requesters to whome blocks have been sold.
    node(itr).sold_blocks=0;  % Total blocks sold by the nodes till now. 
    node(itr).block_cost=0;   % It contains the cost at which a seller sells a block;
    % It stores the earning of a node in a give round.
    % If a node is buyer it wil be negative.
    % For seller earning will be positive.
    node(itr).income_round=0; % It stores the earning of a node in a given round
    
    %If a node is acting as a buyer then only these paramters are used.
    node(itr).request=0;       % Total blocks of energy requested by nodes in one round
    node(itr).request_fullfilled=0;   % The total blocks requirement that has been fulfilled at the node.  
    node(itr).unProcessedList = [];  %  It contains list of sellers, who have not been requested for the energy till now.
    node(itr).lsp = 0; % It contains the list of latest service provider to buyer itr
end  


