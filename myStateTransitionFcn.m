function x = myStateTransitionFcn(x,u)

k = .8;
m = .3;
l = .3;
g = 9.8;
Jm = 4e-4;
Jl = 4e-4;
J = 4e-4;
Bm = .015;
Bl = 0;

x = [ x(2);
             -1/J*(k*(x(1)-x(3)) + m*g*l*cos(x(1)));
             x(4);
             1/J*(-Bm*x(4) + k*(x(1)-x(3)) + u)];
end