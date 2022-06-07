function R = avgRewardNew(S, l1)

n = size(S, 2);   % No of sellers
rew = sum(S.^2,1); % It is a row vector containing the the S values partaining to each seller. 
R = sum(rew)/(4*l1*n);
end

