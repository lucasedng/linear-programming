function [x, it] = testePILN(op, A, b, c)
% =============== INSTRUÇÕES =================
% Este script destina-se à fazer testes com o 
% programa PIPL_LN.m
% ---------------- SOLUÇÕES ------------------
% A solução de cada teste encontra-se comentada
% no final de cada teste. De maneira análoga, pode-se
% comparar o resultado obtido usando-se o comando:
%
% [X, FVAL, E] = linprog(c, [], [], A, b, zeros(n, 1));
%
% E = 1 implica que houve convergência da solução para X.
% Mais informações, consultar: help linprog.
% --------------------------------------------
% ---------------- OPÇÕES --------------------
% op = 0 [REQUISITA TODOS PARÂMETROS]: 
% Completa-se automaticamente os vetores lamb
% e mu e o ponto interior de início com val nos
% zeros.
% op = -1 [REQUISITA TODOS PARÂMETROS]: 
% Idêntico ao op = 0, porém plota o problema.
% Assume-se que é um problema bidimensional.
% OBS: O tamanho do plot ainda precisa ser alterado manualmente
% e pode ser alterado no arquivo doisDplot.m
% --------------------------------------------
% ------------- COMANDOS ÚTEIS ---------------
% [x, it] = testePILN(op, val, A, b, c)
% [x, it] = testePILN(op)
% --------------------------------------------
% ============================================
if op == -1
    % ============== TESTE 2D ================
    [m, n] = size(A);
    x = ones(n,1);
    lamb = zeros(m, 1);
    mu = ones(n, 1);
    mu = (mu*0.001)./x;
    [x, it] = PIPL_LN(A, b, c, x, lamb, mu, 1);
    % ========================================
end
if op == 0
    % =========== TESTE EXTERNO ==============
    [m, n] = size(A);
    x = ones(n,1);
    lamb = zeros(m, 1);
    mu = ones(n, 1);
    [x, it] = PIPL_LN(A, b, c, x, lamb, mu);
    % ========================================
end
if op == 1
    % ============= TESTE 1 ==================
    A = [1 1 1 0 0; 
         2 1 0 1 0; 
         5 10 0 0 1];
     b = [100 150 800]';
     c = [-80 -60 0 0 0]';
     x = [10 10 80 120 650]';
     lamb = [0; 0; 0];
     mu = [0.00001/10; 0.00001/10; 0.00001/80; 0.00001/120;0.00001/650];
    [x, it] = PIPL_LN(A, b, c, x, lamb, mu)
    % SOLUÇÃO FINAL: x = (50 50 0 0 50), f = 7000
end
if op == 2
    % ============= TESTE 2 ==================
    A = [-2 1 1 0 0;
        -1 2 0 1 0;
        1 0 0 0 1];
    b = [2 7 3]';
    c = [-1 -2 0 0 0]';
    x = [10 10 2 7 3]';
    lamb = [0; 0; 0];
    mu = [1/10; 1/10; 1/2; 1/7; 1/3];
    [x, it]= PIPL_LN(A, b, c, x, lamb, mu);
    %SOLUÇÃO FINAL: x = (3 5 3 0 0) f = -13
    %=========================================   
end
if op == 3
    % ============= TESTE 3 ==================
    A = [2 1 1 1 0 0; 
        1 2 3 0 1 0; 
        2 2 1 0 0 1];
    b = [2 5 6]';
    c = [-3 -1 -3 0 0 0]';
    x = [10 10 10 2 5 6]';
    lamb = [0; 0; 0];
    mu = [1/10; 1/10; 1/10; 1/2; 1/5; 1/6];
    [x, it] = PIPL_LN(A, b, c, x, lamb, mu);
    %SOLUÇÃO FINAL: x = (0.2 0 1.6 0 0 4) f = -5.4
    %=========================================   
end