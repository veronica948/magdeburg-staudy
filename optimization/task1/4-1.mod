param n_x := 5;
param n_y := 6;
set indexSet_x := {1..n_x};
set indexSet_y := {1..n_y};
param c{i in indexSet_x, j in indexSet_y} default (n_y - j) + (5 - 3 * j / n_y) * i;
param b{i in indexSet_x, j in indexSet_y} := 1.4 * (i + n_y - j) * i / (n_y * n_x) - (n_y / 2 - i)^2 / n_y^2;
let {i in indexSet_x} c[i,i] := c[i,i] + 250;

var x{indexSet_x};
var y{indexSet_y} binary; #integer

# model
minimize  f: sum{i in indexSet_x}(c[i,i] * x[i] * x[i]  + sum{j in indexSet_y}(c[i,j] * x[i] * y[j]));

#minimize  f: sum{i in indexSet_x}(c[i,i] * x[i] * x[i]  + sum{j in indexSet_y}(c[i,j] * x[i] * y[j] * (x[i] + y[j])));

subject to contract1{i in indexSet_x}: 1<= x[i] <= 2;
subject to contract3{i in indexSet_x, j in indexSet_y}: b[i,j] - (y[j] + 1) * x[i] <= 0;


option solver bonmin;
#option bonmin_options "bonmin.algorithm B-BB bonmin.num_resolve_at_node=1";
 option bonmin_options "bonmin.algorithm B-OA";
# option bonmin_options "bonmin.algorithm B-QG";
# option bonmin_options "bonmin.algorithm B-Hyb";
# option bonmin_options "bonmin.algorithm B-Ecp";

# B-OA: OA Decomposition algorithm
# B-QG: Quesada and Grossmann branch-and-cut algorithm
# B-Hyb: hybrid outer approximation based branch-and-cut
# B-Ecp: ecp cuts based branch-and-cut a la FilMINT

solve;
display n_x, n_y, f, x, y;

