# variable definitions and simple bounds
var x1 >= 0; # the two different blending procedures
var x2 >= 0;

# model
minimize cost: 3 * x1 + 5 * x2;

subject to contract1:     x1 + 4 * x2 >= 4;
subject to contract2: 2 * x1 + 2 * x2 >= 5;
subject to contract3: 2 * x1 +     x2 >= 3;

option solver cplex;
solve;
model;
display x1, x2;
display contract1, contract2, contract3;
display cost - (contract1 * 4 + contract2 * 5 + contract3 * 3);

