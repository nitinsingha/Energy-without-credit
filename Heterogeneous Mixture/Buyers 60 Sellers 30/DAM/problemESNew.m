function S = problemESNew(D, l1, l2)

n = size(D,2);
sum_D = sum(D);
sum_D2 = sum(D.^2);

L = l1*sum_D2 + l2*sum_D;
disp(L);

S = optimvar('x',1,n,'LowerBound',0);
prob = optimproblem;
prob.Objective = fcn2optimexpr(@objective,L,S,l1);

x0.x = ones(1,n);

options = optimoptions(@fmincon,'MaxFunctionEvaluations',25000);     % Solving the optimisation problem
[solution,fval,exitflag,output] = solve(prob,x0,'Options',options);  % using inbuilt optimiser.
S = solution.x;

function y = objective(L,S,l1)       % Objective function that has to be optimised. Eqn (9) in the paper.
    y = L - (sum(S.^2)/(4*l1));
end
end

