% path following
function [x,y,z]= pf(A, b, c, x)

[m n] = size(A);
E = 1 + norm(c,1);
tau = 0.9955;
epsi = 1.e-6;
sigma =0.01;
y = zeros(m, 1);
z = c;
aux1 = find(z >= 0);
z(aux1,1) = z(aux1, 1) + E;
% para z<=0
aux2 = min(z, 0);
aux1 = find(aux2 <= -E);
aux2(aux1,1) = -z (aux1,1);
aux1 = find(aux2 > -E);
aux2(aux1,1) = E;
z=max(aux2, z);
clear aux2; clear aux1;
stopp = 1; %quando parar
k = 0; %nº de iteracoes
e= ones(n,1);

plotAxesHandle = doisDplot(A, b);

while stopp > epsi,
    gama = trace(diag(x)*diag(z));
    if gama < 1
        mi = gama^2/n;
    else
        mi = sigma * gama/n;
    end
    %calculo dos residuos%
    rp = b - A*x;
    rd = c - A'*y - z;
    rc = mi*e - diag(x)*diag(z)*e;
    D = diag(x.^-1)*diag(z);
    aux2 = inv(A*diag(diag(D).^-1)*A');
    dy = aux2*(rp + A*diag(diag(D).^-1)*rd - A*diag(z.^-1)*rc);
    dx = diag(diag(D).^-1)*(A'*dy - rd + diag(x.^-1)*rc);
    dz = diag(x.^-1)*(rc - diag(z)*dx);
    xdx = -x./dx;
    zdz = -z./dz;
    xdx(xdx<0) = [];
    zdz(zdz<0) = [];
    %calculo do rho
    rhop = min(xdx);
    rhod = min(zdz);
    alphap = min([tau*rhop, 1]);
    alphad = min([tau*rhod, 1]);
    x = x + alphap*dx
    y = y + alphad*dy;
    z = z + alphad*dz;
    Fp = A*x - b;
    Fd = A'*y + z -c;
    Fa = diag(x)*diag(z)*e;
    F = [Fp; Fd; Fa];
    stopp = norm(F, 1);
    k = k+1;
    
    disp(x(1:2, 1));
       plot(plotAxesHandle, x(1, 1), x(2, 1), 'r*'); 
    
end
fprintf(1,' \n');
% for i=1:(length(y))
%     fprintf(1,'y(%d) = %f \n',i,y(i));
% end
% fprintf(1,' \n');
% for i=1:(length(z))
%     fprintf(1,'z(%d) = %f \n',i,z(i));
% end

fprintf(1,'Iterações Realizadas: %d \n',k);
fprintf(1,' \n');
