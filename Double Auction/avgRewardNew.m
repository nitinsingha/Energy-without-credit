function R = avgRewardNew(S, l1)

n = size(S, 2);
rew = sum(S.^2);
R = sum(rew)/(4*l1*n);
end

