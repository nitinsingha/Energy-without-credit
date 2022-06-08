%calling function: [node] = performTrade2(node,seller)
%returns sorted request list for a seller based on bid price and distance.
%Higher the bid price, greater the preference given to buyer. In case of
%tie, nearest buyer is preffered.

function [sortedList] = getSortedList(requestList)
        sortedList =  nestedSortStruct(requestList,{'bid_price','distance'},[-1,1]);
        % [-1,1]: -1 implies that sorting is done in descendin order of bid_price,
        % and 1 implies that in case of tie sorting is done in ascending
        % order of distance
end
