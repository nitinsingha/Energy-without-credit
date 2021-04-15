m = 10;        % Number of buyers
n = 10;        % Number of sellers

B = randi([1 10],m,n);       % Prices bid by buyers
S = randi([1 10],m,n);       % Prices bid by sellers
B_prev = zeros(m,n);
S_prev = zeros(m,n);

C_min = randi([0 5],m,1);    % Minimum electricity demand of charging vehicle
C_max = randi([5 10],m,1);   % Maximum electricity demand of charging vehicle
D_max = randi([5 10],n,1);   % Maximum electricity supply of discharging vehicle

%Constants
epsi = 1;                   % Convergence criterion parameter
neta  = 1;                  % Average charging efficiency
rho = 0.9;                  % Average electricity transmission efficiency
tau = 0.5;                  % Constant
l1 = 0.9;                   % Cost factor 1
l2 = 0.2;                  % Cost factor 2
STO = randi([0 10],m,1);    % Energy state before charging

%Algorithm
flag = 1;                   % Convergence checker variable
t = 1;
while flag == 1
    [C, D] = problemA(B,S,neta,rho,C_min,C_max,D_max);           % Problem A solved to get C and D from initial B and S
    B_prev = B;                                                  % Placeholder variable to store value of B
    S_prev = S;                                                  % Placeholder variable to store value of S
    B = problemEB(C,neta,tau,C_min,STO);                         % Problem EB solved to get new B
    S = problemES(D,l1,l2);                                      % Problem ES solved to get new S
    RDB = mean2((abs(B - B_prev))./B);                             % RDB calculation for convergence check
    RDS = mean2((abs(S - S_prev))./S);                             % RDS calculation for convergence check
    t = t+1;
    if (RDB<epsi) && (RDS<epsi)                                  % Convergence check
        flag = 0;                                                % If converged, our algorithm has finished
    end
end

%C, D, B, S are final results