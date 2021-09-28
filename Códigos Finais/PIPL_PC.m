function [x, it] = PIPL_PC(A, b, c, x, lamb, mu)

%if nargin == 6
 %  dD = 0; 
%end
%Dados da Matriz
[m, n] = size(A);
Ind3=[n+m+1:2*n+m];


 
tol = 10^(-8);

F = [A * x - b ;
    A' * lamb + mu - c;
    x .* mu];
it = 0;

%if dD == 1
 %   plotAxesHandle = doisDplot(A, b);
%end
while (norm(F, inf) > tol) & (it < 100)
    
    it = it + 1;
    
    J = [A zeros(m) zeros(m,n); 
         zeros(n) A' eye(n); 
         diag(mu) zeros(n,m) diag(x)];
     
    d = -J \ F;
    dx = d(1:n);
    dlamb = d(n+1:n+m);
    dmu = d(n+m+1:2*n+m);
    pho = dx'*dmu/n
    pho=(x+dx)'*(mu+dmu)/n
    %pho = sum(dx.*dmu)/n
    
    %corretor
     dx.*dmu 
    Ind3
    F
     F(Ind3) = [x .* mu - pho + dx.*dmu];   
 F
 
    d = -J \ F;
    %pause
    
    dx = d(1:n);
    dlamb = d(n+1:n+m);
    dmu = d(n+m+1:2*n+m);
    
    raz = -x./ dx;
    indrazpos = find(raz > 0);
    [t, ind2] = min(raz(indrazpos));
    if isempty(t)
        t=1;
    elseif t>1
         t=1;   
    end
    
    x = x + 0.999 *t* dx;
    
    lamb = lamb + dlamb;
    
    raz = -mu./ dmu;
    indrazpos = find(raz > 0);
    [t, ind2] = min(raz(indrazpos));
    if isempty(t)
        t=1;
    elseif t>1
         t=1;   
    end
   

    mu = mu + 0.999 * t* dmu;

  
F = [A * x - b ;
    A' * lamb + mu - c;
    x .* mu];
    
      % if dD == 1
   %    disp(x(1:2, 1));
   %    plot(plotAxesHandle, x(1, 1), x(2, 1), 'r*'); 
   %end
    
    
    %pause;
    
end
    