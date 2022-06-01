clc;
clear all;
close all;

m = 45;             %number of sellers
n = 45;             %number of buyers
% Constants
rho = 0.9;                   % Average electricity transmission efficiency

% Impoting data from double price auction mechanism
[D,C,B,S,rewd]=getDat();
avgB=mean2(B);
avgS=mean2(S);
total_rewd=sum(rewd,'all');
total_B=sum(B,'all');
DSO_reward_ratio=total_B/total_rewd;   % Per unit reward, what is the total bidding price
% The centralling authority is tampering with bids to help malicious
% sellers. It is promoting bids from the first 15 highest bidding sellers.
[ttl_S, ttl_B,ttl_D,ttl_C]=get_mal_buy_Bids(m,n,avgB,avgS,D,C,rho,DSO_reward_ratio);
DSO_reward_ratio
fprintf('Average buying price: %f\n', ttl_B/ttl_C);
fprintf('Average selling price: %f\n', ttl_S/ttl_D);