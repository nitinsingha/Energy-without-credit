function [avg_currency_rnd, currency1, currency2, currency3, currency4, currency5,avg_service_rnd, avg_request_rnd, trade1, trade2, trade3, trade4, trade5,total_rnd_income, total_rnd_income_DSO, total_rnd_income_sellers, income_round1, income_round2, income_round3, income_round4, income_round5] = log_varibale_Initilization()
% This function initializes various variable
% Cost initialiation
[avg_currency_rnd, currency1, currency2, currency3, currency4, currency5]=setCurrency();  
% Trading variable initialization
[avg_service_rnd, avg_request_rnd, trade1, trade2, trade3, trade4, trade5]=setTrade();
% Income variable initialization
[total_rnd_income, total_rnd_income_DSO, total_rnd_income_sellers, income_round1, income_round2, income_round3, income_round4, income_round5]=setIncome_round();

end


