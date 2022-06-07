%Calling function: [node]=energy_matching(sellers,buyers,node)


function [node] = performTrade3(node,seller,iter)
% It is similar to perform Trade2, except that when buyer is offering more
% than the selling price, then only matching is done.

% Retrieving constants
[CONST] = networkConstants();
Total_iter =CONST.Total_iter;   % Total number of iterations

requestList = node(seller).requestList;

%get the sorted List
sortedList = getSortedList(requestList); %  This list contains list of buyers. Buyers are sorted by a seller based on their bid prices and distance

%for every element in request list find its position in buyers_list and
%update buyers_list
for i= 1:length(sortedList)
    buyers_list  = node(seller).buyers_list;  % The id of the requesters to whom block have been promised by the seller.
    current_request = sortedList(i);
    if ((node(seller).bidPrice <= current_request.bid_price)||(iter == Total_iter)) %Check that bid submitted by buyer is more than price demanded by seller. In last round IEM algorithm behaves like EM algorithm. So the OR statement is added
        buyers_id = current_request.buyers_id;
        %check if the buyer already exists
        [isBuyerPresent,index] = checkBuyerPresent(buyers_list,buyers_id);

        if(isBuyerPresent)
            node = trade_already_exists(node,seller,buyers_id,index,current_request,iter);
        else
            %find position in the buyers_list. %returns index >0 if it cuurent
            %buyer lies above some of existing requester in preference lsit of
            %current seller, otherwise it returns -1. If current buyer lies above existing requester, then index tells  how many existing requester , have preference higher than current buyer in the preference list.  
            index = getPosition(buyers_list,current_request);
            node = trade_not_present(node,seller,buyers_id,index,current_request,iter);
        end
    end
end

end
