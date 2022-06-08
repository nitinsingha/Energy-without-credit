function res = socialWelfare(C,D)

m = size(C,1);
n = size(C,2);
neta = 0.8;
tau = 0.6;
STO = 0.2*ones(m,1);
C_min = 5*ones(m,1);
l1 = 0.1;
l2 = 0.15;
w = tau./STO;
sum_C = sum(C,2)*neta;
sum_D = sum(D);
sum_D2 = sum(D.^2);

U = zeros(m,1);
for i=1:m
    U(i) = w(i)*log(sum_C(i) - C_min(i) + 1);
end

L = zeros(n,1);
for j=1:n
    L(j) = l1*sum_D2(j) + l2*sum_D(j);
end

res = abs(sum(U) - sum(L));
end