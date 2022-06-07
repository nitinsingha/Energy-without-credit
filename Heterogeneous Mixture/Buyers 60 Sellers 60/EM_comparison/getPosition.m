%calling function performTrade
%finds the position of current_request in the buyers_list  of the seller 

%returns index >0 if it can replace anything
%returns -1 if it is last in the list 
function [index] = getPosition(buyers_list,current_request)
size = length(buyers_list);
for i = 1:size
    req = buyers_list(i);
    
    % compareRequests returns 1 if request cooresponding to req has higher preference
    % over current_request, else retruns -1
    cmp = compareRequests(req,current_request);
    if(cmp==-1)
        index = i;
        return;
    end
end
index = -1;
    


    
