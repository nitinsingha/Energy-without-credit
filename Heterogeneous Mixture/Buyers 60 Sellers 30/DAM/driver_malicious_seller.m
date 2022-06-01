close all;
%clear all;
clc;
rng(2)   

m = 45;        % Number of buyers
n = 45;        % Number of sellers
n_mal=15;      % Numner of sellers who have entered into mailicious agreemnet with central authority to get all the energy

% Initalizing demand and supply matrices
C = zeros(m,n);   % Demand matrix
D = zeros(m,n);   % Supply matrix

S = zeros(1, 45);   %selling price matrix
B = zeros(45, 45);   %buying price matrix

j = 1;
for i=1:9
    S(j:j+4) = [5, 6, 7, 8, 9];
    j = j+5;
end

S = repmat(S, 45, 1);
B = transpose(S);
B_prev = zeros(m,n);
S_prev = zeros(m,n);

%C_min = randi([5 10],m,1);    % Minimum electricity demand of charging vehicle
C_min = 5*ones(m,1);
%C_max = randi([12 18],m,1);   % Maximum electricity demand of charging vehicle
%C_max = 18*ones(m,1);
C_max = 18;
%D_max = randi([10 20],n,1);   % Maximum electricity supply of discharging vehicle
%D_max = 20*ones(n,1);
D_max = 20;
%Constants
epsi = 0.001;                % Convergence criterion parameter
neta  = 0.8;                 % Average charging efficiency
rho = 0.9;                   % Average electricity transmission efficiency
tau = 0.6;                   % Constant
l1 = 0.01;                   % Cost factor 1
l2 = 0.015;                  % Cost factor 2
int_rwd=0.01;                 % The initial reqard offered to seller for joining the network.
%STO = randi([1 5],m,1);     % Energy state before charging
STO = 0.2*ones(m,1);

%Social Welfare
sw = zeros(13,1);
%Charging Electricity
ce = zeros(13,1);
ce2 = zeros(13,1);
%Discharging Electricity
de = zeros(13,1);
de2 = zeros(13,1);
%Average payment
ap = zeros(13,1);
%Average reward
ar = zeros(13,1);

%Cells for storing data
CC = {};
CD = {};
CB = {};
CS = {};
CB{1,1} = B;
CS{1,1} = S;

%Algorithm
flag = 1;                   % Convergence checker variable
t = 1;
while flag == 1
   % [C, D] = problemA(B,S,neta,rho,C_min,C_max,D_max);           % Problem A solved to get C and D from initial B and S
     % Introducing malicious seller behaviour in the network
    D(:,1:n_mal)=(D_max/m).*ones(m,n_mal);
    D(:,n_mal+1:n)=zeros(m,n-n_mal);
  % D(:,1:n)=(D_max/m).*ones(m,n);
     C=rho*D;    % The energy that is being transmitted from sellers to consumers with some transmission losses.
     CC{t,1} = C;
    CD{t,1} = D;
    sw(t) = socialWelfare(C,D,neta,tau,STO,C_min,l1,l2);
    ce(t) = sum(C(15,:));
    de(t) = sum(D(:,15));
%    ce2(t) = C(15,20);
%    de2(t) = D(15,20);
    %ap(t) = avgPayment(C, neta, tau, STO, C_min);
    ap(t) = avgPaymentNew(B);
    %ar(t) = avgReward(D, l1, l2);
   
    B_prev = B;                                                  % Placeholder variable to store value of B
    S_prev = S;                                                  % Placeholder variable to store value of S
    
    B = problemEB(C,neta,tau,C_min,STO);                         % Problem EB solved to get new B
    S = problemES(D,l1,l2);                                      % Problem ES solved to get new S
    CB{t+1,1} = B;
    CS{t+1,1} = S;
    [ar(t),rewd] = avgReward(S, l1,int_rwd);
    % This function calculates changes in buying price and selling prices of
    % current round w.r.t. previou round.
    [B_change,S_change] = chang_in_prices(B,B_prev,S,S_prev); % B_change,S_change store change in selling and buying [ices, respectively.
    RDB = mean2(B_change);                           % RDB calculation for convergence check
    RDS = mean2(S_change);                           % RDS calculation for convergence check
    
    disp(t)
    t = t+1;
    if (RDB<epsi) && (RDS<epsi)                                  % Convergence check
        flag = 0;                                                % If converged, our algorithm has finished
    end
end

%C, D, B, S are final results

%fprintf('Average buying price: %f\n', mean(sum(B,'all')/sum(C,'all')));
%fprintf('Average selling price: %f\n', mean(sum(S,'all')/sum(D,'all') + 0.001));
fprintf('Average buying price: %f\n', sum(B,'all')/sum(C,'all'));
fprintf('Average selling price: %f\n', sum (rewd,'all')/sum(D,'all'));
%sel=sum(D,1);
%fprintf('Average selling price: %f\n', mean2(rewd./sel));
sD = sum(D,2);
save('data_seller_210722.mat');

% Plots
% figure
% plot(sw(1:end), '-b')
% legend('Social Welfare')
% xlabel('Iterations')
% ylabel('Social Welfare')
% 
% figure
% hold on
% plot(ce(1:end), '-b')
% plot(de(1:end), '--r')
% title('Using all PHEVs')
% legend('Charging Electricity', 'Discharging Electricity')
% xlabel('Iterations')
% ylabel('Amount of traded electricity')
% hold off
% 
% figure
% hold on
% plot(ce2(1:end), '-b')
% plot(de2(1:end), '--r')
% title('Using single PHEV')
% legend('Charging Electricity', 'Discharging Electricity')
% xlabel('Iterations')
% ylabel('Amount of traded electricity')
% hold off
% 
% figure
% hold on
% plot(ap(2:end), '-b')
% plot(ar(2:end), '--r')
% legend('Average Payment', 'Average Reward')
% xlabel('Iterations')
% ylabel('Average payment/reward')
% hold off