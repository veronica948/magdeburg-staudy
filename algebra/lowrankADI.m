clear;
load('large_lyap.mat');
tol = 10^(-8);
k = length(shifts);
[n,m] = size(A);
j = 1;
Z = [];
W = b;
%Rb = zeros(k,1);
%Rb(1) = norm(W * ctranspose(W))/(norm(b,2)^2);
while(j <= k && norm(W * ctranspose(W),2)/(norm(b,2)^2) > tol) %norm(W,2)
    j
    V = (A + shifts(j)*eye(n))\W;
    W = W - 2 * real(shifts(j)) * V;
    Z = [Z, sqrt(-2*real(shifts(j)))*V];
    j = j+1;
end;
X = Z * ctranspose(Z);
j
norm(A * X + X * ctranspose(A) + b * ctranspose(b))

