param n_x := 5;
param n_y := 6;

set Kx;
set Ky;
set indexSet_x := {1..n_x};
set indexSet_y := {1..n_y};
param c{i in indexSet_x, j in indexSet_y} default (n_y - j) + (5 - 3 * j / n_y) * i;
param b{i in indexSet_x, j in indexSet_y} := 1.4 * (i + n_y - j) * i / (n_y * n_x) - (n_y / 2 - i)^2 / n_y^2;
let {i in indexSet_x} c[i,i] := c[i,i] + 250;
param sizeK; #?

var x{indexSet_x};
var y{indexSet_y} binary;
var xk{indexSet_x}; #solutions of NLPs for K
var yk{indexSet_y};
var eta;

# model
#NLP
minimize  rf: sum{i in indexSet_x}(c[i,i] * x[i] * x[i]  + sum{j in indexSet_y}(c[i,j] * x[i] * y[j]));
subject to contract1r{i in indexSet_x}: 1<= x[i] <= 2;
subject to contract2r{i in indexSet_x, j in indexSet_y}: b[i,j] - (y[j] + 1) * x[i] <= 0;
#fixing y?

option solver bonmin;

#build K


#MILP-OA
minimize  f: eta;

subject to contract1{k in 1..sizeK}: sum{i in indexSet_x}(c[i,i] * Kx[k,i] * Kx[k,i]  2 * c[i,i] * x[i] * (x[i] - Kx[k,i]) + sum{j in indexSet_y}(c[i,j] * Kx[k,i] * Ky[k,j] + c[i,j] * y[j] * (x[i] - Kx[k,i]) + c[i,j] * x[i] * (y[j] - Ky[k,i]))) <= eta;
subject to contract2{i in indexSet_x}: 1 <= x[i] <= 2;
subject to contract3{i in indexSet_x, j in indexSet_y, k in 1..sizeK}: b[i,j] - (Ky[k,j] + 1) * Kx[k,i] - Ky[k,j] * (x[i] - Kx[k,i]) <= 0;
subject to contract4{i in indexSet_x, j in indexSet_y, k in 1..sizeK}: b[i,j] - (Ky[k,j] + 1) * Kx[k,i] - Kx[k,i] * (y[j] - Ky[k,j]) <= 0;

solve;
display n_x, n_y, f, eta, x, y;






