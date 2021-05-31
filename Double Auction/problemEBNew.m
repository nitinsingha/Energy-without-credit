function B = problemEBNew(C,neta,tau,C_min,STO)

m = size(C,1);

w = tau./STO;
sum_C = sum(C)*neta;
U = w*log(sum_C - C_min + 1);

B = optimvar('x',m,1,'LowerBound',0);
prob = optimproblem;
prob.Objective = fcn2optimexpr(@objective,U,B);

x0.x = ones(m,1);

options = optimoptions(@fmincon,'MaxFunctionEvaluations',25000); % Solving the optimisation problem
[solution,fval,exitflag,output] = solve(prob,x0,'Options',options);                  % using inbuilt optimiser.
B = solution.x;

function y = objective(U,B)                              % Objective function that has to be optimised. Eqn (8) in the paper.
    y = sum(B) - U;
end
end

