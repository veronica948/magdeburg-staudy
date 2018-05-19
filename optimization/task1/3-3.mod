param n_x := 5;
param n_y := 6;
set indexSet_x := {1..n_x};
set indexSet_y := {1..n_y};
set valuesIndexSet_y = {1..2^n_y};
set Y{valuesIndexSet_y};
param c{i in indexSet_x, j in indexSet_y} default (n_y - j) + (5 - 3 * j / n_y) * i;
param b{i in indexSet_x, j in indexSet_y} := 1.4 * (i + n_y - j) * i / (n_y * n_x) - (n_y / 2 - i)^2 / n_y^2;
let {i in indexSet_x} c[i,i] := c[i,i] + 250;

var x{indexSet_x};
var y{indexSet_y} binary; #integer

var currentMin default Infinity;
var currentMinArg_x;
var currentMinArg_y;

# model
minimize  f: sum{i in indexSet_x}(c[i,i] * x[i] * x[i] + sum{j in indexSet_y}(c[i,j] * x[i] * y[j]));

subject to contract1{i in indexSet_x}: 1<= x[i] <= 2;
#subject to contract2{j in indexSet_y}: 0<= y[j] <= 1;
subject to contract3{i in indexSet_x, j in indexSet_y}: b[i,j] - (y[j] + 1) * x[i] <= 0;

option solver bonmin; #ipopt 2047.79; cplex 0; bonmin 2743.64; couenne 2072.35;

for {k in valuesIndexSet_y} {
y = Y[k];
solve;
if f < currentMin then {currentMinArg_x = x; currentMinArg_y = y; currentMin = f;}
}
display currentMin, currentMinArg_x, currentMinArg_y;

