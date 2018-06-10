param n_x := 5;
param n_y := 6;

set problemSet;
set indexSet_x := {1..n_x};
set indexSet_y := {1..n_y};
param c{i in indexSet_x, j in indexSet_y} default (n_y - j) + (5 - 3 * j / n_y) * i;
param b{i in indexSet_x, j in indexSet_y} := 1.4 * (i + n_y - j) * i / (n_y * n_x) - (n_y / 2 - i)^2 / n_y^2;
let {i in indexSet_x} c[i,i] := c[i,i] + 250;
param L;
param U;
param UB;
param i;

var x{indexSet_x};
var y{indexSet_y} binary;

# model
minimize  f: sum{i in indexSet_x}(c[i,i] * x[i] * x[i]  + sum{j in indexSet_y}(c[i,j] * x[i] * y[j]));

#minimize  f: sum{i in indexSet_x}(c[i,i] * x[i] * x[i]  + sum{j in indexSet_y}(c[i,j] * x[i] * y[j] * (x[i] + y[j])));

subject to contract1{i in indexSet_x}: 1<= x[i] <= 2;
subject to contract3{i in indexSet_x, j in indexSet_y}: b[i,j] - (y[j] + 1) * x[i] <= 0;

let UB := Infinity;
let i:= 0;
let problemSet := {{L, U}};


option solver bonmin;
solve;
display n_x, n_y, f, x, y;






