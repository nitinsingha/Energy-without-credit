m =10;        % Number of buyers
n= 10;        % Number of sellers

neta  = 1;    % Average charging efficiency
rho = 0.9;    % Average electricity transmission efficiency
B = randi([1 10],m,n);       % Prices bid by buyers
S = randi([1 10],m,n);       % Prices bid by sellers
C = optimvar('x',m,n,'LowerBound',0);     % Electricity demand of charging vehicles
D =optimvar('y',m,n,'LowerBound',0);      % Electricity supply by discharging vehicles
C_min = randi([0 5],m,1);
C_max = randi([5 10],m,1);
D_max = randi([5 10],n,1);
STO = randi([0 10],m,1);     % Energy state before charging
tau = 0.5;    % Constant
l1 = 0.9;     % Cost factor 1
l2 = -0.2;    % Cost factor 2


prob = optimproblem;
prob.Objective = fcn2optimexpr(@objective,C,D,B,S);    
prob.Constraints.cons1 = (sum(C,2)*neta >= C_min);            % These are the constraints
prob.Constraints.cons2 = (sum(C,2)*neta <= C_max);            % for the optimisation
prob.Constraints.cons3 = (transpose(sum(D))<=D_max);          % problem. In the paper,
prob.Constraints.cons4 = (rho*D == C);                        % they are written in eqn. (4).


x0.x = zeros(m,n);
x0.y = zeros(m,n);

options = optimoptions(@fmincon,'MaxFunctionEvaluations',10000,'PlotFcns',@optimplotfval);      % Solving the optimisation problem
prob.show()                                                                                     % using inbuilt optimiser.
[solution,fval,exitflag,output] = solve(prob,x0,'Options',options);

sum_C = sum(C,2)*neta;
for i = 1:m
    B(i,:) =  (neta*tau*C(i,:))/(STO(i)*(sum_C(i) - C_min(i) + 1));                             % Problem EB. Eqn (13) in the paper.
end
S = 2*l1*D + l2;                                                                                % Problem ES. Eqn (14) in the paper.

function y = objective(C,D,B,S)                              % Objective function that has to be optimised. Eqn (10) in the paper.
    y  = sum(dot(B,log(C))) - sum(dot(S,log(D)));
end
