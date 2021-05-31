function avgU = avgPayment(B)

m = size(B,1);
pay = sum(B,2);
P = sum(pay)/m;

end

