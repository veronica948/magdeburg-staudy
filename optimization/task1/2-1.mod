# variable definitions and simple bounds
var x default 4;
var y default 2;

# model
minimize  bf: ((x-y^2)^2 +1/100)^(1/4) + y^2/100;

option solver ipopt; #ipopt; #cplex; #bonmin; #couenne;
solve;
display x, y;

