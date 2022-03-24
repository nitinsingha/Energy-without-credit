%Calling functions:
%1.[node] = trade_already_exists(node,seller,buyers_id,index,request)
%2.[node] = trade_not_present(node,seller,buyers_id,index,current_request)
%updates the buyers mapping list

function [node] = update_buyer(node,isAdd,isPresent,request)
%  request.sellers_id  = sellers_id;
%  request.blocks = blocks_sold;
%  request.buyers_id = buyers_id;
sellers_id = request.sellers_id; 
blocks_sold = request.blocks;
buyers_id = request.buyers_id; 
%isPresent = 1 signifies that buyer has earlier been promised some blocks.
%If buyer has been eralier promised blocks, then new blocks will be added to the existing blocks.

%addition or removal
mapping = node(buyers_id).mapping;
if isAdd == 1
    if isPresent == 1
        %find the seller in the mapping and update blocks
        for i = 1:length(mapping)
            if mapping(i).sellers_id == sellers_id
                %update mapping, i.e., new locks will be added with the existing blocks 
                mapping(i).blocks = mapping(i).blocks + blocks_sold;
                node(buyers_id).mapping = mapping;
                node(buyers_id).request_fullfilled = node(buyers_id).request_fullfilled + blocks_sold;
                node(buyers_id).required = node(buyers_id).required - blocks_sold;
                node(buyers_id).lsp = sellers_id;
            end
        end
    else
        %add the request as it is
        mapping  = [mapping ; request];
        node(buyers_id).mapping = mapping;
        node(buyers_id).request_fullfilled = node(buyers_id).request_fullfilled + blocks_sold;
        node(buyers_id).required = node(buyers_id).required - blocks_sold;
        node(buyers_id).lsp = sellers_id;
    end
else
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
end
        
    
                
       