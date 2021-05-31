  
function R = avgRewardNew(S,l1)
n = size(S, 2);
rew = sum(S.^2);
rew_sellr= sum(rew,1);
for itr = 1:1:n
    rew_sellr(itr)=rew_sellr(itr)/(4*l1)+randi([1,2]);
end  
%R = sum(rew)/(4*l1*n);
R=sum(rew_sellr)/n;
end

