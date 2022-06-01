% Calling function: [node]=energy_trade(node,n,total_sellers);

function [node]=energy_matching(sellers,buyers,node)
%Matching sellers with buyers
% We employ a very simple matching, where cost of each unit of energy is same.


%getting prefernce list
%prefernce list is unprocessed list

%latest service provider(lsp) 
%all initialized to zeros


% creating prference list for buyer
 disp('****** Prefrence list of buyers')
for i = 1:length(buyers)
    p = getPreferenceList(buyers(i),sellers,node); % This function returns the preference list of a particular buyer, i.e., list of preffered sellers.
    node(buyers(i)).unProcessedList = p; 
    node(buyers(i)).lsp = 0;     % It rests the latest service provider variable 
end

% Generating mapping of the sellers with the buyers
while (~isempty(getBuyers(node,buyers)) )
    current_buyers = getBuyers(node,buyers);   % get buyers function returns lst of buyers who can participate in energy matching process.
    for itr= 1:length(current_buyers)
        % This function submits bid of the current_buyers(itr) to the seller at the top of its preference list
        [node]=sendRequest(node,current_buyers(itr));
    end    

    current_sellers = getSellers(node,sellers);
    for i = 1:length(current_sellers)
        node  = performTrade2(node,current_sellers(i));
    end
    
    for i =1 :length(buyers)
        if node(buyers(i)).rejected_last == 1 
            node(buyers(i)).rejected_last =0;
            if node(buyers(i)).lsp >0
                node(buyers(i)).unProcessedList = [node(buyers(i)).lsp , node(buyers(i)).unProcessedList];
            end
        end
    end
    
    for i = 1:length(sellers)     % Resetting the request list of seller. A seller has already selected the best buyer out of this list.
        node(sellers(i)).requestList = [];
    end
end    
end