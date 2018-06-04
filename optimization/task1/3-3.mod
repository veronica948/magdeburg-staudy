param n_x := 5;
param n_y := 6;
set indexSet_x := {1..n_x};
set indexSet_y := {1..n_y};
param c{i in indexSet_x, j in indexSet_y} default (n_y - j) + (5 - 3 * j / n_y) * i;
param b{i in indexSet_x, j in indexSet_y} := 1.4 * (i + n_y - j) * i / (n_y * n_x) - (n_y / 2 - i)^2 / n_y^2;
let {i in indexSet_x} c[i,i] := c[i,i] + 250;

var x{indexSet_x};
var y{indexSet_y};

param currentMin;
let currentMin := 100000000;
param currentMinArg_x{indexSet_x};
param currentMinArg_y{indexSet_y};

# model
minimize  f: sum{i in indexSet_x}(c[i,i] * x[i] * x[i] + sum{j in indexSet_y}(c[i,j] * x[i] * y[j]));

subject to contract1{i in indexSet_x}: 1<= x[i] <= 2;
subject to contract3{i in indexSet_x, j in indexSet_y}: b[i,j] - (y[j] + 1) * x[i] <= 0;

option solver bonmin; #ipopt; cplex; bonmin; couenne;
option eexit 0;
for {i1 in 0..1, i2 in 0..1, i3 in 0..1, i4 in 0..1, i5 in 0..1, i6 in 0..1} {
fix y[1] := i1;
fix y[2] := i2;
fix y[3] := i3;
fix y[4] := i4;
fix y[5] := i5;
fix y[6] := i6;
solve;
if (f < currentMin) then { 
	let {i in indexSet_x} currentMinArg_x[i] := x[i]; 
	let {j in indexSet_y} currentMinArg_y[j] := y[j]; 
	let currentMin := f;
	}
}
display currentMin, currentMinArg_x, currentMinArg_y;

