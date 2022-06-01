clc;
close all;
clear all;

m = 30;              %number of sellers
n = 60;              %number of buyers


% Constants
rho = 0.9;                   % Average electricity transmission efficiency


% Impoting data from double price auction mechanism
[D,C,B,S,rewd]=getDat();

% Since C and D are calculated so that they are equal. In addition, we also
% wan't to calculate the average pices. So no need to write matching
% algorithm.

avgS=mean2(sum(S,1));

total_rewd=sum(rewd,'all');
total_B=sum(B,'all');
DSO_reward_ratio=total_B/total_rewd;   % Per unit reward, what is the total bidding price
% The buyers have to pay the selling price quoted by the seller, and the
% service charge of the central authority. 
% The seller in double auction doesn't receive money based on its bid. It receives money based on its rewards.
% While seller in first come first receive money based on its reward.
% Therefore we have used rewd for calculating DSO_reward_ratio, but later on selling price is used for further calculation 

avgB=DSO_reward_ratio*avgS;
%get the bids for sellers and buyers in the current network, based on
%inputs from double auction mechanism
[bids, bidb]=getBids(m,n,avgB,avgS);


%fprintf('Average buying price: %f\n', sum(B,'all')/sum(C,'all'));
%fprintf('Average selling price: %f\n', sum(S,'all')/sum(D,'all'));
fprintf('Average buying price: %f\n', sum(bidb,'all')/sum(C,'all'));
fprintf('Average selling price: %f\n', sum(bids,'all')/sum(D,'all'));
