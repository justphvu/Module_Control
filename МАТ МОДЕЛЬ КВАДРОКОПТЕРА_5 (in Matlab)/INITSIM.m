%% ПРОГРАММА ПОДГОТОВКИ ДАННЫХ ДЛЯ МОДЕЛИРОВАНИЯ
function [PARAM,INVAFM,Xzad]=INITSIM()
      % Обозначение по осям
    x=1;    y=2;    z=3;
    %% Массо-габаритные параметры
    PARAM.m     = 1.2;          % Масса, кг
    PARAM.Jxx   = 2.344E-2;     % Моменты инерции
    PARAM.Jyy   = 3.333E-2;
    PARAM.Jzz   = 2.344E-3;
    PARAM.Lq    = 0.3;          % Плечо

    PARAM.kT    = 3.13E-5;      % коэффициент тяги
    PARAM.kM    = 7.4E-7;       % коэффициент момента
    PARAM.kD    = 6.224E-8;     % коэффициент сопротивления
    %% Матрица для вычисления приращения управления
    kT=PARAM.kT;
    kM=PARAM.kM;
    Lq=PARAM.Lq;
    AFM=[kT    kT    kT    kT;...
         0    -kT*Lq 0     kT*Lq;...
         kT*Lq 0     kT*Lq 0;...
         kM   -kM    kM   -kM];
%      A=[1 1 1 1;0 -1 0 1; 1 0 -1 0; 1 -1 1 -1];
%      B=inv(A);
%      C=[1/kT;1/kT/Lq;1/kT/Lq;1/kM];
%      F=B*C
     INVAFM=inv(AFM);
    %% Начальное состояние
    Vxg0        = 0.0;      % в ГСК
    Vyg0        = 0.0;
    Vzg0        = 0.0;
    Wxb0        = 0.0;      % в ССК
    Wyb0        = 0.0;
    Wzb0        = 0.0;
    PSI0        = 0.0*pi/180.0;
    GAM0        = 0.0*pi/180.0;
    TET0        = 0.0*pi/180.0;
    L0          = 0.0;
    H0          = 10;
    Z0          = 0.0;
    % Мартрица перехода
    Cbg = C_bg(TET0,PSI0,GAM0);
    % Скорость в ССК
    Vg0 = [Vxg0;Vyg0;Vzg0];
    Vb0 = Cbg'*Vg0;
    % Вектор начального состояния (требуемого в начальный момент времени)
    Xzad=[Vb0(x),Vb0(y),Vb0(z),Wxb0,Wyb0,Wzb0,GAM0,PSI0,TET0,L0,H0,Z0];
end

