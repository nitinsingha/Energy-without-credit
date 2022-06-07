function [node] = performTrade(node,seller)
%sort the request list based on bid price and distance%
requestList = node(seller).requestList;
sorted_list =  nestedSortStruct(requestList,{'bid_price','distance'});
for i = 1:length(sorted_list)
    buyers_list = node(seller).buyers_list;
    request  = sorted_list(i);
    index = -1;
    total = node(seller).service;
    for j = 1:length(buyers_list)
        if(buyers_list(j).bid_price > request.bid_price)
            continue;
        end
        if (buyers_list(j).bid_price == request.bid_price)
            if (buyers_list(j).distance >= request.distance )
                continue;
            end
            index = j;
            break;
        end
        index = j;
        break;
    end
    if index == -1
        if node(seller).sold_blocks < total
            %(min(total - sold_blocks , requested) are sold)) and buyer and
            %seller mappings gets update
            blocks_requested = request.blocks;
            minimum = min(blocks_requested,total - node(seller).sold_blocks);
            
            
            size = length(node(seller).buyers_list)
            if size >0 && node(seller).buyers_list(size).buyers_id == request.buyers_id
                node(seller).buyers_list(size).blocks = node(seller).buyers_list(end).blocks + minimum;
                %update buyer
                node(request.buyers_id).request_fullfilled =  node(request.buyers_id).request_fullfilled+ minimum;
                mapping  = node(request.buyers_id).mapping;
                for j = 1:length(mapping)
                    if(mapping(j).seller_id == seller)
                        mapping(j).blocks = mapping(j).blocks + minimum;
                    end
                end
                node(request.buyers_id).mapping  = mapping ;
                node(request.buyers_id).lsp = seller;
            else
                request.blocks = minimum;
                node(seller).buyers_list = [node(seller).buyers_list;request];
                node(request.buyers_id).request_fullfilled =  node(request.buyers_id).request_fullfilled+ minimum;
                mapping  = node(request.buyers_id).mapping;
                request.seller_id = seller;
                mapping = [mapping;request];
                node(request.buyers_id).mapping  = mapping ;
                node(request.buyers_id).lsp = seller;
            end
        end
    else
        j = 1;
        blocks_upto_now =0;
        while j<index
            blocks_upto_now = blocks_upto_now + buyers_list(j).blocks ;
            j = j+1;
        end
        blocks_available = node(seller).service - blocks_upto_now;
        min_blocks  = min(blocks_available,request.blocks);
        
        if min_blocks > 0
            %update buyers list of seller
            request.blocks = min_blocks;
            node(seller).buyers_list = [node(seller).buyers_list(1:index-1);request;node(seller).buyers_list(index:end)];
            %update mapping of buyer
            node(request.buyers_id).request_fullfilled =  node(request.buyers_id).request_fullfilled+ minimum;
            mapping  = node(request.buyers_id).mapping;
            request.seller_id = seller;
            mapping = [mapping;request];
            node(request.buyers_id).mapping  = mapping ;
            node(request.buyers_id).lsp = seller;
            
            %now check for removal of extra blocks
            blocks_used = min_blocks + blocks_upto_now;
            
            end_index = -1;
            buyersList = node(seller).buyers_list;
            
            for j = index+1 : length(buyersList)
                if blocks_used + buyersList(j).blocks > node(seller).service
                    end_index = j;
                    break;
                else
                    blocks_used  = blocks_used + buyersList(j).blocks;
                end
            end
            
            
            if end_index >0
                %it may have some boxes to give 
                 blocks_available  = node(seller).service - blocks_used;
                 
                 %update seller buyer's list
                 prev  = buyersList(end_index).blocks;
                 start = end_index;
                 if blocks_available >0
                     buyersList(end_index).blocks  = blocks_available;
                     %update buyers information
                     node(buyersList(end_index).buyers_id).request_fullfilled =  node(buyersList(end_index).buyers_id).request_fullfilled-(prev)+ blocks_available;
                     mapping  = node(request.buyers_id).mapping;
                      %search for this sellers_id and update the mapping
                      for j = 1: length(mapping)
                          if(mapping(j).seller_id == seller)
                              mapping(j).blocks = blocks_available;
                          end
                      end
                      node(buyersList(end_index).buyers_id).rejected_last = 1;
                      
                      %remove all other from buyers_list and update the buyers
                      start = end_index+1;
                 end
                 
                 for j = start : length(buyersList)
                     %update the buyers mapping
                     buyers_id  = buyersList(j).buyers_id;
                     mapping  = node(buyers_id).mapping;
                     
                     %search for seller and delete
                     index  = -1;
                     for k = 1:length(mapping)
                         if(mapping(k).seller_id == seller)
                             index  = k;
                             break;
                         end
                     end
                     index
                     mapping  = [mapping(1:index-1);mapping(index+1:end)];
                     node(buyers_id).mapping = mapping;
                     
                     %update required blocks
                     node(buyers_id).request_fullfilled = node(buyers_id).request_fullfilled - buyersList(j).blocks;
                     %update rejected variable;
                     node(buyers_id).rejected_last = 1; 
                 end
                 buyersList = buyersList(1:end_index);
            else
                if blocks_used == node(seller).service
                    buyersList = buyersList(1:index);
                end
            end
            
            %update buyers_list
            
            node(seller).buyers_list = buyersList;
        end                   
    end
end
            
            
            
        
    
    
    