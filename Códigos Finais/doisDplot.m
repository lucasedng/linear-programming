function plotAxesHandle = doisDplot(A, b)
    rge = 100; %ALTERAR ESTE  VALOR MANUALMENTE!!!!!
    %rge = max(b);
    x = 0:1:rge;
    A = A(:, 1:2);
    [m, n] = size(A);
    y = zeros(m, rge + 1);
    plotFigureHandle = figure;
    set(plotFigureHandle, 'Position', [306,100, 800, 600]); 
    set(plotFigureHandle,'name','Plot','numbertitle','off'); 
    plotAxesHandle = gca;
    hold(plotAxesHandle,'on');
    for i = 1:m
        if(A(i, 2) == 0)
            x1 = b(i, 1) * ones(1, rge + 1)/A(i, 1);
            plot(plotAxesHandle, x1, 0:1:rge, 'b');
        else
            y(i, :) = (b(i, 1) * ones(1, rge + 1) - A(i, 1) * x)/A(i, 2);
            aux = y(i, :);
            aux = aux(aux>=0);
            [j, k] = size(aux);
            plot(plotAxesHandle, x(1, 1:k), aux, 'b');
        end
    end
end