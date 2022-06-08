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
[bids, bidb,D_mal,C_mal]=get_mal_sel_Bids(m,n,avgB,avgS,D,C,rho);
% The buying price in current algorithm is independent of bids submitted by
% the buyer. It depends on the selling prive of seller.
avgS_mal=mean2(bids);
avgB_mal=DSO_reward_ratio*mean2(bids);
D_max=20;
n_mal=15;
D(:,1:n_mal)=(D_max/m).*ones(m,n_mal);
D(:,n_mal+1:n)=zeros(m,n-n_mal);
C=rho*D;
fprintf('Average buying price: %f\n', avgB_mal/mean2(C_mal));
fprintf('Average selling price: %f\n', avgS_mal/mean2(D_mal));
social_welfare = socialWelfare(C,D)