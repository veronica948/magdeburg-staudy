# variable definitions and simple bounds
var x1 >= -1.5, <=2, default 1; # the two different blending procedures
var x2 >= -0.5, <=3, default 1;

# model
minimize  cost: (1 - x1)^2 +100*(x2 - x1^2)^2; #minimize #maximize

#subject to contract1:     x1>= -1.5;
#subject to contract2: 2 * x1 + 2 * x2 >= 5;

option solver ipopt; #ipopt; #cplex; #bonmin; #couenne;
solve;
model;
display x1, x2;
#display contract1, contract2, contract3;
#display cost - (contract1 * 4 + contract2 * 5 + contract3 * 3);

