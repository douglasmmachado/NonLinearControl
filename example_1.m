clear all;
close all;

k = .8;
m = .3;
l = .3;
g = 9.8;
Jm = 4e-4;
Jl = 4e-4;
J = 4e-4;
Bm = .015;
Bl = 0;

n = 4;
%% Non linear system
 A = [0 1 0 0;
      0 0 1 0;
      0 0 0 1;
      0 0 0 0];

Q = 1e3*eye(4);
 
R = 1e-3;
 
B = [0;0;0;1];
 
C = [1 0 0 0];

x_est_initial = [pi/2;0;pi/2;0];

[K,S,e]=lqr(A,B, Q, R);
static_gain=inv(C*inv(-A+B*K)*B);%gain statique

%%
% the following command creates a vector x = [x(1), x(2), x(3), x(4)] of symbolic variables
x = sym('x', [n, 1]);
% create the symbolic control variable
syms u;

% it is important not to create functions here but vector and/or expressions
f = [ x(2);
            -1/J*(k*(x(1)-x(3)) + m*g*l*cos(x(1)));
            x(4);
            1/J*(-Bm*x(4) + k*(x(1)-x(3)) + u)];
dyn = matlabFunction(f, 'vars', [x; u]);
h = pi/2 - x(1);


[alpha, beta, T] = computeLinearization(f, h, x, u);