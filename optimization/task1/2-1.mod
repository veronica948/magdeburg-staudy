# variable definitions and simple bounds
var x default 4; # the two different blending procedures
var y default 2;

# model
minimize  cost: ((x-y^2)^2 +1/100)^(1/4) + y^2/100;

#subject to contract1:     x1>= -1.5;
#subject to contract2: 2 * x1 + 2 * x2 >= 5;

option solver ipopt; #ipopt; #cplex; #bonmin; #couenne;
solve;
display x, y;

