set ind := 1 .. 2 by 1;
var x {i in ind};

minimize function: 1 + sum {i in ind}(x[i])^2/4000 - prod{i in ind} (cos(x[i]/sqrt(i)));

subject to contract1{i in ind}:     x[i]>= -600;
subject to contract2{i in ind}:     x[i]<= 600;

option solver couenne; #ipopt; #cplex; #bonmin; #couenne;
solve;
model;
display x;

