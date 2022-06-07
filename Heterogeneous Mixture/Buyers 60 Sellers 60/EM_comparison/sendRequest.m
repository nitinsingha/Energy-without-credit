%Calling function: [node]=energy_matching(sellers,buyers,node)

function [node]=sendRequest(node,buyer)
% This function submits the bid of the buyer to he seller in the network 
% 1. It updates the unprocessed list of the buyer after sending the bid
% 2. It submits the request to the seller. Reqquest is send to seller in form of strucutre called request
        

        % Retrieve the sellers from the unprocessed list 
        list = node(buyer).unProcessedList;
        bid_sel = list(1);    % The seller hihest in the prioirty list, to which the bid is placed by the buyer in current round
        blocks_requested = node(buyer).request - node(buyer).request_fullfilled;  % The blocks requested from the current seller
        
        % request is a strucutre with four fiels: buyers_id, blocks,
        % bid_price, distance. This strucutre is used to pass information
        % about the current buyer (bidder) to the seller
        request =  updateRequest_strucutre(bid_sel,buyer,blocks_requested,node(bid_sel).bidPrice,node(buyer).bidPrice);
        node(bid_sel).requestList = [node(bid_sel).requestList;request];
        node(buyer).unProcessedList =  node(buyer).unProcessedList(2:end);
end

