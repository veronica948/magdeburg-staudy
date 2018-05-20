clear;
load('sylv_eqn.mat');
[AA,S] = schur(A, 'complex');
[BB,D] = schur(B, 'complex');
QQ = ctranspose(S) * Q * D;


