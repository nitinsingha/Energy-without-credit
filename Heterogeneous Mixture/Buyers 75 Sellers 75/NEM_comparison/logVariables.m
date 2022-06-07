%Calling function: main

function [avg_currency_rnd, currency1, currency2, currency3, currency4, currency5, avg_service_rnd, avg_request_rnd, trade1, trade2, trade3, trade4, trade5, total_rnd_income, income_round1, income_round2, income_round3, income_round4, income_round5]=logVariables(node)
% Logs for nodes that will be considered
Id1=1;
Id2=2;
Id3=3;
Id4=4;
Id5=5;
[avg_currency_rnd, currency1, currency2, currency3, currency4, currency5]=logCurrency(node,Id1,Id2,Id3,Id4,Id5);
[avg_service_rnd, avg_request_rnd, trade1, trade2, trade3, trade4, trade5]=logTrade(node,Id1,Id2,Id3,Id4,Id5);
[total_rnd_income, income_round1, income_round2, income_round3, income_round4, income_round5]=logIncome(node,Id1,Id2,Id3,Id4,Id5);
end

