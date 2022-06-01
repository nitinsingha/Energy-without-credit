%Calling function: [node]=energy_matching(sellers,buyers,node)

function [node] = performTrade2(node,seller)

requestList = node(seller).requestList;

%get the sorted List
sortedList = getSortedList(requestList); %  This list contains list of buyers. Buyers are sorted by a seller bassed on their bid prices and distance

%for every element in request list find its position in buyers_list and
%update buyers_list
for i= 1:length(sortedList)
    buyers_list  = node(seller).buyers_list;  % The id of the requesters to whom block have been promised by the seller.
    current_request = sortedList(i);
    buyers_id = current_request.buyers_id;
    %check if the buyer already exists
    [isBuyerPresent,index] = checkBuyerPresent(buyers_list,buyers_id);
    
    if(isBuyerPresent)
        node = trade_already_exists(node,seller,buyers_id,index,current_request);
    else
        %find position in the buyers_list. %returns index >0 if it cuurent
        %buyer lies above some of existing requester in preference lsit of
        %current seller, otherwise it returns -1. If current buyer lies above existing requester, then index tells  how many existing requester , have preference higher than current buyer in the preference list.  
        index = getPosition(buyers_list,current_request);
        node = trade_not_present(node,seller,buyers_id,index,current_request);
    end
end  
end
