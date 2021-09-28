function [x, f] = simplex(A, b, c, x, IB, IN)
    [m, n] = size(A);
    i = 0;
    B = A(:, IB);
    [L,U,P] = lu(B);
    lambda = (B')\c(IB);
    rd = c(IN) - A(:, IN)'*lambda;
    [v, vEnter] = min(rd); %acha o coeficiente de c com menor valor para aumentar na var p
    while v < 0
        % Teste da Razão
        cEnter = IN(vEnter); %colula a entrar na base           
        y_aux = L\(P*A(:, cEnter)); %Uyq=y_aux, L*y_aux = aq
        yq = U\y_aux; %U*yq = y_aux
        
        raz = x(IB) ./ yq; 
        indrazpos=find(raz>0);
        [u,ind2]=min(raz(indrazpos));
         uSai = indrazpos(ind2); %pega o mínimo positivo da razão
        if u<=0
            'problema ilimitado';
            pause
        end
        IN(:, vEnter) = IB(:, uSai); %atualiza variáveis não básicas
        IB(:, uSai) = cEnter;  %atualiza variáveis básicas      
        
        
        % Calcula nova solução básica
        B = A(:, IB);
        [L,U,P] = lu(B); 
        %LUx=b
        y =  L \ (P * b); %Ux = y, Ly = Pb
        x = zeros(n, 1);
        x(IB) = U \ y; 
        lambda = (B')\c(IB);
        rd = c(IN) - A(:, IN)'*lambda;
        [v, vEnter] = min(rd);
        i = i + 1;
    end
    f = c'*x;
    disp(i)
end




