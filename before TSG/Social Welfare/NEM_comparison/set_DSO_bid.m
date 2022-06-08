% Clling function : [CONST] = networkConstants()
function [DSO_block_cost,DSO_block_requisiton_cost]=set_DSO_bid()
% This function updates cost at which DSO sells and purchases blocks 

 [D,C,B,S,rewd]=getData();           
    %Calculating average value of loaded data
    avgD =  round(mean(sum(D,2)));      % Average demand of buyers. The average demand is rounded to the nearest integer.
    avgC =  round(mean(sum(C,1)));      % Average supply by sellers. The average supply is rounded to the nearest integer.
    avgB =  (mean(sum(B,2)));      % Average bid of a buyer, for all the blocks
    avgS =  (mean(sum(S,1)));      % Average bid by a seller, for all the blocks.
    
        
    % We have to calculate average bids per unit case for extreme cases. 
    DSO_block_cost = (avgB+2*(avgB/10))/avgC;  % This is maximum bid by buyers
    DSO_block_requisiton_cost = (avgS-2*(avgS/10))/17;  % This is minimum bid by a seller
end

