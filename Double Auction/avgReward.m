function avgL = avgReward(D,l1,l2)

n = size(D,2);
sum_D = sum(D);
sum_D2 = sum(D.^2);

L = zeros(n,1);
for j=1:n
    L(j) = l1*sum_D2(j) + l2*sum_D(j);
end

avgL = mean(L);

end

