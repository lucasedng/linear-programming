function [x, it] = PIPL_LN(A, b, c, x, lamb, mu)

%if nargin == 6
 %  dD = 0; 
%end

%Dados da Matriz
[m, n] = size(A);

pho = sum(x.*mu)/n;

tol = 10^(-8);

F = [A * x - b ;
    A' * lamb + mu - c;
    x .* mu + pho];

it = 0; 

%if dD == 1
%    plotAxesHandle = doisDplot(A, b);
%end
while norm(F, inf) > tol
   
    it = it + 1;
    J = [A zeros(m) zeros(m,n); 
         zeros(n) A' eye(n); 
         diag(mu) zeros(n,m) diag(x)];
    d = -J \ F;
    dx = d(1:n);
    dlamb = d(n+1:n+m);
    dmu = d(n+m+1:2*n+m);
    
    raz = -x./ dx;
    indrazpos = find(raz > 0);
    [t, ind2] = min(raz(indrazpos));
    
    x = x + 0.999 * t * dx;
    
    lamb = lamb + dlamb;
    
    raz = -mu./ dmu;
    indrazpos = find(raz > 0);
    [t, ind2] = min(raz(indrazpos));
    
    mu = mu + 0.999 * t * dmu;
    
    pho = sum(x.*mu)/n
    
    F = [A * x - b;
        A' * lamb + mu - c;
        x .* mu + pho];
    
   % if dD == 1
   %    disp(x(1:2, 1));
   %    plot(plotAxesHandle, x(1, 1), x(2, 1), 'r*'); 
   %end
    
    
    %pause;
end