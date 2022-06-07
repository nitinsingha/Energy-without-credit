close all;
clear all;
clc;
rng(1)         %Seed

m = 75;        % Number of buyers
n = 75;        % Number of sellers

S = zeros(1, 75);   %selling price matrix
B = zeros(75, 75);   %buying price matrix

j = 1;
for i=1:15
    S(j:j+4) = [5, 6, 7, 8, 9];
    j = j+5;
end

S = repmat(S, 75, 1);
B = transpose(S);

B_prev = zeros(m,n);
S_prev = zeros(m,n);

%C_min = randi([5 10],m,1);    % Minimum electricity demand of charging vehicle
C_min = 5*ones(m,1);
%C_max = randi([12 18],m,1);   % Maximum electricity demand of charging vehicle
C_max = 18*ones(m,1);
%D_max = randi([10 20],n,1);   % Maximum electricity supply of discharging vehicle
D_max = 20*ones(n,1);

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
    [C, D] = problemA(B,S,neta,rho,C_min,C_max,D_max);           % Problem A solved to get C and D from initial B and S
    CC{t,1} = C;
    CD{t,1} = D;
    ce(t) = sum(C(15,:));
    de(t) = sum(D(:,15));
    ce2(t) = C(15,20);
    de2(t) = D(15,20);
    %ap(t) = avgPayment(C, neta, tau, STO, C_min);
    ap(t) = avgPaymentNew(B);
    %ar(t) = avgReward(D, l1, l2);
    [ar(t),rewd] = avgReward(S, l1,int_rwd);
    B_prev = B;                                                  % Placeholder variable to store value of B
    S_prev = S;                                                  % Placeholder variable to store value of S
    
    B = problemEB(C,neta,tau,C_min,STO);                         % Problem EB solved to get new B
    S = problemES(D,l1,l2);                                      % Problem ES solved to get new S
    [ar(t),rewd] = avgReward(S, l1,int_rwd);
    CB{t+1,1} = B;
    CS{t+1,1} = S;
    RDB = mean2((abs(B - B_prev))./B);                           % RDB calculation for convergence check
    RDS = mean2((abs(S - S_prev))./S);                           % RDS calculation for convergence check
    disp(t)
    t = t+1;
    if (RDB<epsi) && (RDS<epsi)                                  % Convergence check
        flag = 0;                                                % If converged, our algorithm has finished
    end
end

%C, D, B, S are final results

fprintf('Average buying price: %f\n', sum(B,'all')/sum(C,'all'));
fprintf('Average selling price: %f\n', sum (rewd,'all')/sum(D,'all'));
sD = sum(D,2);
save('saveD.mat','sD');

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