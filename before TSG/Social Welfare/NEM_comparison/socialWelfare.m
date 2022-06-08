function res = socialWelfare(node)

m = (length(node))/2;
n = (length(node))/2;

[s,b] = list_sellers_buyers(node);
D = zeros(m,n);

j = 1;
for i=1:2*m
    if node(i).type == 0
        continue
    end
    temp = node(i).final_buyers_list;
    for k=1:length(temp)
        byr = temp(k).buyers_id;
        idx = find(b==byr);
        D(idx,j) = D(idx,j) + temp(k).blocks;
    end
    j = j+1;
end

rho = 0.9;
C = D/rho;

neta = 0.9;
tau = 0.8;
STO = 0.2*ones(m,1);
C_min = 0.5*ones(m,1);
l1 = 0.01;
l2 = 0.015;
w = tau./STO;
sum_C = sum(C,2)*neta;
sum_D = sum(D);
sum_D2 = sum(D.^2);

U = zeros(m,1);
for i=1:m
    U(i) = w(i)*log(max(sum_C(i) - C_min(i), 0) + 1);
end

L = zeros(n,1);
for j=1:n
    L(j) = l1*sum_D2(j) + l2*sum_D(j);
end

res = abs(sum(U) - sum(L));
end