function [D,C,B,S,rewd]=getData()
% Import data from double price auction mechanism
temp = matfile('saveD.mat');


import = matfile('Data_210713.mat');   % Importing data from double price auction mechanism
%D = temp.sD;
% We are importing thr data to normalize the things.
D = import.D;                  % Importing demnad matrix of buyers
C = import.C;                  % Importing supply matrix of sellers
B = import.B;                  % Importing bids by buyers
S = import.S;                  % Importing bids by sellers 
rewd = import.rewd;

end

