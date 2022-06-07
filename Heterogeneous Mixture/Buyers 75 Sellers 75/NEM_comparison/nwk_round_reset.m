function [node]=nwk_round_reset(node)
% This function reset some parameters of nodes during starting of each
% round

% Retrieving  network constants.
CONST=networkConstants(); 
n=CONST.n;   % Total nodes in the network

     for itr=1:1:n
        node(itr).type=0;          % Type =0 buyer, Type = 1 seller
        node(itr).request=0;       % Total blocks of energy requested by nodes in one round
        node(itr).request_fullfilled=0;   % The total blocks requirement that has been fulfilled at the node.  
        node(itr).sellers=zeros(1,5); % Contains Id of sellers from which blocks are purchased
        node(itr).service=0;       % Total blocks of energy available at node for selling.
        node(itr).buyers=zeros(1,5);  % The id of requesters to whome blocks have been sold.
        node(itr).sold_blocks=0;  % Total blocks sold by the nodes till now. 
        node(itr).blocks_cost=0;  % The cost of a block sold by a seller 
        % Resetting income earned by a node in the current round
        node(itr).income_round=0;
    end
end

