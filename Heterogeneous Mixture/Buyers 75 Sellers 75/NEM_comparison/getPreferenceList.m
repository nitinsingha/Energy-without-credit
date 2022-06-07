%calling function function [node]=energy_matching(sellers,buyers,node)

function [pref_list] = getPreferenceList(buyer,sellers,node)
% This function returns the preference list of a particular buyer.
% 'pref_list' contains list of sellers sorted in ascending orders of their
% bid. In case of tie nearest seller is preffered by a buyer

num_sellers = length(sellers);
quan = zeros(num_sellers,2);
global COORDINATES ;    % This variable stores the location of different nodes
for i = 1:num_sellers
    quan(i,1) = node(sellers(i)).bidPrice;   % Storing the bid price of the seller
    dist = sqrt((COORDINATES(sellers(i)).x-COORDINATES(buyer).x)^2 + (COORDINATES(sellers(i)).y-COORDINATES(buyer).y)^2);
    quan(i,2) = dist;  % Storing the distance of seller
end


% The sellers are arranged in order of increasing bid prices,and in case of
% tie distance is used.  sortrows(quan, [1 2]]) first sorts the rows of quan based on the elements in the frst column, then based on the elements in the second column it break ties.

[out,idx] = sortrows(quan, [1 2]); 

% The below variables stores sellers soted according to their bidprice, and
% in case of tie according to the distance
pref_list = sellers(idx);
end




