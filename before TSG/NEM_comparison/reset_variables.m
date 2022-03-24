%Calling function = [node]=energy_trade(node)
function [node] = reset_variables(sellers,buyers,node)
%Reset variables for next iteration of energy matching

% %Retrieving network constants
% CONST = networkConstants();
% n = CONST.n;
% 
% for itr =1:n
%     if(node(itr).type==0)   % Buyer
%         node(itr).request = node(itr).request - node(itr).request_fulfilled;
%         node(itr).required = node(itr).request;
%         node(itr).request_fulfilled = 0;
%         node(itr).mapping = [];
%     elseif(node(itr).type==1)   % Seller
%         node(itr).service = node(itr).service - node(itr).sold_blocks;
%         node(itr).sold_blocks = 0;
%         node(itr).buyers_list = [];
%     end   
% end    

for itrs = 1:length(sellers)
    node(sellers(itrs)).service = node(sellers(itrs)).ini_service - node(sellers(itrs)).sold_blocks;
    node(sellers(itrs)).buyers_list = [];
end

for itrb = 1:length(buyers)
    node(buyers(itrb)).request = node(buyers(itrb)).ini_request - node(buyers(itrb)).request_fulfilled;
    node(buyers(itrb)).required = node(buyers(itrb)).request;
    node(buyers(itrb)).mapping = [];
end

end

