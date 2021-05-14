function avgU = avgPayment(C,neta,tau,STO,C_min)

w = tau./STO;
m = size(C,1);
sum_C = sum(C,2)*neta;
U = zeros(m,1);
for i=1:m
    U(i) = w(i)*log(sum_C(i) - C_min(i) + 1);
end

avgU = mean(U);

end

