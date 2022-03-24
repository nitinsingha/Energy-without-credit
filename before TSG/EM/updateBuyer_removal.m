%Calling functions:
%1.[node] = trade_already_exists(node,seller,buyers_id,index,request)
%2.[node] = trade_not_present(node,seller,buyers_id,index,current_request)
%updates the buyers mapping list

function [node] = updateBuyer_removal(node,request)
sellers_id = request.sellers_id;
blocks_sold = request.blocks;
buyers_id = request.buyers_id; 


mapping = node(buyers_id).mapping;

%find the index of seller in the mapping function
index  = -1;
for i = 1:length(mapping)
    if mapping(i).sellers_id == sellers_id
    index = i;
    break
    end
end
% if total blocks are removed
if mapping(index).blocks  == blocks_sold
    %remove it from mapping
    mapping  = [mapping(1:index-1);mapping(index+1:end)];
else
    mapping(index).blocks = mapping(index).blocks - blocks_sold;
end
node(buyers_id).mapping = mapping;
node(buyers_id).request_fullfilled = node(buyers_id).request_fullfilled - blocks_sold;
node(buyers_id).required = node(buyers_id).required + blocks_sold;
node(buyers_id).rejected_last = 1;
end
        
    
                
       