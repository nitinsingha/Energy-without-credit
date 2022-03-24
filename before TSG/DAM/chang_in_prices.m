function [B_change,S_change] = chang_in_prices(B,B_prev,S,S_prev)
% This function calculates changes in buying price and selling prices of
% current round w.r.t. previou round.

m= size(B,1); % No of buyers (No of rows in B)
n= size(B,2); % No of sellers (No of coloumns in B) 

   % Calculates change in the buying price w.r.t. previous round
    B_change=zeros(m,n);    
    for buy=1:1:m
        for sel=1:1:n
            if(B(buy,sel)~=0)
                B_change(buy,sel)=(B(buy,sel)-B_prev(buy,sel))/B(buy,sel);    % Change in the buying price
            end    
        end 
    end  
    % Calculates change in the Selling price w.r.t. previous round
    S_change=zeros(m,n);
    for buy=1:1:m
        for sel=1:1:n
            if(S(buy,sel)~=0)
                S_change(buy,sel)=(S(buy,sel)-S_prev(buy,sel))/S(buy,sel);    % Change in the buying price
            end    
        end 
    end    


end

