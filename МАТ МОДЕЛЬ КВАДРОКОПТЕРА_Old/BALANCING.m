%% АЛГОРИТМ РЕШЕНИЯ ЗАДАЧИ БАЛАНСИРОВКИ ПОЛЕТА
function [BAL,J]=BALANCING(Xzad,KEY)    
    %% Прототип функции критерия
    f = @(BAL)FCT(BAL,Xzad,KEY);
    
    %% Начальное значение поисковых параметров балансировки
    BAL0=[1.E+3,1.E+3,1.E+3,1.E+3, 0];  
    options = optimset('fminunc');
    %options = optimset(options, 'TolFun',1e-10,'TolX',1e-10','TolCon',1e-10);
    %options = optimset(options,'Display','iter','PlotFcns',@optimplotfval);
    [BAL,J] = fminunc(f,BAL0,options);
end
