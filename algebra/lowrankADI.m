clear;
load('large_lyap.mat');
b;
A;
shifts;
tol = 10^(-8);
k = length(shifts);
[n,m] = size(A);
j = 1;
Z = [];
W = b;
%Rb = zeros(k,1);
%Rb(1) = ctranspose(W) + W/(norm(b,2)^2);
while(j <= k && norm(W) > tol)%Rb(j) > tol) 
    V = (A + shifts(j)*eye(n))\W;
    W = W - 2 * real(shifts(j)) * V;
    Z = [Z, sqrt(-2*real(shifts(j)))*V];
    j = j+1;
end;
X = Z * ctranspose(Z);
j
norm(A * X + X * ctranspose(A) + b * ctranspose(b))

