function x = pathfollowing(A,b,c,tau,epsilon);

% start the clock
tp=cputime;

% 1st Big M%
[m,n] = size(A);
x = ones(n,1);
M=1e4;
sigma=1;
p=b-A*x;
c = [c; M];
A=[A p];
x=[x; sigma];
cm = c;
Am = A;
fm = cm'*x;
mi = 200;
k=0;
beta = 0.001;
delta = 1;
[m,n] = size(Am);


while (delta > epsilon) | (x(length(x)) > epsilon)
 passo = 1/mi;
 X=diag(x);
 c = X*cm;
 A = Am * X;
 P = eye(n) - A' * inv( A * A' ) * A; 
 dx = -X* P * ( c - mi );
 xdx = -x./dx;
 xdx(xdx<0) = [];
 lambda = min(xdx);
 alpha = min(passo, tau*lambda);
 x = x + alpha * dx;
 f = cm'*x;
 delta = abs(f - fm);
 if delta > 1
 mi = mi*beta;
 end
 fm = f;
 k = k+1;
end
 tp=cputime-tp;
 x=x(1:length(x)-1,:); 
 c=c(1:length(c)-1,:); 

 fprintf(1,' \n');
for i=1:(length(x))
 fprintf(1,'x(%d) = %f \n',i,x(i));
end
 fprintf(1,' \n');
 fprintf(1,'Mínimo da função objetivo Primal (c`*x): %f \n',c'*x);
 fprintf(1,' \n');
 fprintf(1,'Tempo de processamento (ms): %f \n',tp/1e-3);
 fprintf(1,'Iterações Realizadas: %d \n',k);
 fprintf(1,' \n'); 