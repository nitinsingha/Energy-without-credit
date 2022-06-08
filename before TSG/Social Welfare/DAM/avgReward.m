function [avR,R] = avgReward(S, l1,int_rwd)
% Caluclate the average and total reward received by sellers in the network
rew = sum(S.^2,1); % It is a row vector containing the the S values partaining to each seller. 
R = (rew/(4*l1))+int_rwd;
avR=mean2(R);
end

