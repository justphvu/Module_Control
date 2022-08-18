%% ФУНКЦИЯ ИНИЦИАЛИЗАЦИИ СОСТОЯНИЯ КВАДРОКОПТЕРА

function [X0,U0]=INTSTATE(Xzad,KEY) 
    % Обозначение по осям
    x=1;    y=2;    z=3;
    
    %% Решение задачи балансировки 
    [BAL,J]=BALANCING(Xzad,KEY);
    
    %% Вычисление параметров начального состояния
    Vxb = Xzad(1);  % Линейнве скорости в ССК
    Vyb = Xzad(2); 
    Vzb = Xzad(3);           
    Wxb = Xzad(4);  % Угловые скорости в ССК
    Wyb = Xzad(5);
    Wzb = Xzad(6);        
    GAM = Xzad(7);  % крен
    PSI = Xzad(8);  % курс
    if (KEY==0)     % тангаж
        TET = Xzad(9); % Режим висения/взлет/посадка   
    else
        TET = BAL(5);  % Режим разгона
    end  
    L  = Xzad(10);  % Координаты в ССК 
    H  = Xzad(11);
    Z  = Xzad(12);     

    PSI        = 0.0*pi/180.0;
    GAM        = 30.0*pi/180.0;
    TET        = 30.0*pi/180.0;
    %% Вектор начального состояния коптера
    X0=[Vxb,Vyb,Vzb,Wxb,Wyb,Wzb,GAM,PSI,TET,L,H,Z];
    U0=[BAL(1);BAL(2);BAL(3);BAL(4)];      
end
    


