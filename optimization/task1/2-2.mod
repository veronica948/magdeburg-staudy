# variable definitions and simple bounds
#var x default 4; # the two different blending procedures
#var y default 2;

param eps := 10^(-5);
var counter := 0;
var xk := 4;
var yk:= 2;
var xk1 := 4;
var yk1 := 2;
var ak;
var grx;
var gry;
minimize f: (((xk-ak*grx)-(yk - ak*gry)^2)^2 +1/100)^(1/4) + (yk-ak*gry)^2/100;
option solver ipopt;  #ipopt; cplex; bonmin; couenne;
repeat{
let counter := counter + 1;
let xk:=xk1;
let yk := yk1;
let grx := (xk-yk^2)/(2*((xk-yk^2)^2 +1/100)^(3/4));
let gry := yk - (yk/50 - yk*(xk-yk^2)/((xk-yk^2)^2 +1/100)^(3/4));
solve;
let xk1 := xk - ak * grx;
let yk1 := yk - ak * gry;
#print(xk1);
#print(yk1);
#let fk := ((xk-yk^2)^2 +1/100)^(1/4) + yk^2/100;
#let fk1 := ((xk1-yk1^2)^2 +1/100)^(1/4) + yk1^2/100;
} until abs(xk-xk1) < eps and abs(yk-yk1) < eps;

#option solver ipopt; #ipopt; #cplex; #bonmin; #couenne;
#solve;
display xk1, yk1, counter;

