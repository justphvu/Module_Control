% АЛГОРИТМ ИНИЦИАЛИЗАЦИИ НАЧАЛЬНОГО СОСТОЯНИЯ ИНС
function [INSPAR,XB]=INITINS(X0)
    % Обозначение
    x=1;y=2;z=3;
    % Кватернион по состоянию ЛА
    Q0  = X0(7);    
    Q1  = X0(8);    
    Q2  = X0(9);    
    Q3  = X0(10);
    % Углы ориентации ЛА
    TET0=asin(2*Q1*Q2+2*Q0*Q3);
    GAM0=atan(-(2*Q2*Q3-2*Q0*Q1)/(2*Q0^2+2*Q2^2-1));
    PSI0=atan(-(2*Q1*Q3-2*Q0*Q2)/(2*Q1^2+2*Q0^2-1));
    %СКО ошибок начальной выставки
    SIGVYST=0.1*pi/180/3600.0;
    % погрешность выставки в горизонт
    DTET = (-1+2*rand())*SIGVYST;
    DPH = (-1+2*rand())*SIGVYST;	
    % погрешность выставки по азимуту
    DPSI = (-1+2*rand())*SIGVYST;
    DTET=0.0;DPH=0.0;DPSI=0.0;
    % Оценка углов ориентации ЛА
    TETB=TET0+DTET;
    GAMB=GAM0+DPH;
    PSIB=PSI0+DPSI;
    % Оценка кватернионов
    QB=EULER2QUAT(TETB,GAMB,PSIB);
    % Оценка земной скорости ЛА
    Vxn = X0(1);  
    Vyn = X0(2); 
    Vzn = X0(3);  
    % Оценка координат в ГСК 
    L  = X0(11);  
    H  = X0(12);
    Z  = X0(13);   
    % Вектор начального состояния ИНС
    XB=[QB(1);QB(2);QB(3);QB(4);Vxn;Vyn;Vzn;L;H;Z];    
   
    
    %% Характеристики ДУС
    SIGW0=1.0*pi/180/ 3600.0;			% град/ч ->рад/с
    SIGKMW=1.E-4;
    SIGFIW=15*pi/180/3600.0;            % угл. сек. ->рад

    % Смещения нуля
    dw=[SIGW0*sign(randn());
        SIGW0*sign(randn());
        SIGW0*sign(randn())];
    % Погрешности масш. коэфф.
    kmw=[SIGKMW*sign(randn());
        SIGKMW*sign(randn());
        SIGKMW*sign(randn())];
    % Неортогональности
    fiw=[SIGFIW*sign(randn());
        SIGFIW*sign(randn());
        SIGFIW*sign(randn());
        SIGFIW*sign(randn());
        SIGFIW*sign(randn());
        SIGFIW*sign(randn())];
    % Характеристики шумов измерения ДУС
    PSD_GYRO=1.E-12;      % rad2s-1 (Paul D Groves)

    %% Характеристики ДЛУ
    SIGA0=0.001;			% м/с^2
    SIGKMA=1.E-4;
    SIGFIA=15*pi/180/3600.0;            % угл. сек. ->рад

    % Смещения нуля
    da0=[SIGA0*sign(randn());
         SIGA0*sign(randn());
         SIGA0*sign(randn())];
    % Погрешности масш. коэфф.
    kma=[SIGKMA*sign(randn());
         SIGKMA*sign(randn());
         SIGKMA*sign(randn())];
    % Неортогональности
    fia=[SIGFIA*sign(randn());
         SIGFIA*sign(randn());
         SIGFIA*sign(randn());
         SIGFIA*sign(randn());
         SIGFIA*sign(randn());
         SIGFIA*sign(randn())];
    % Характеристики шумов измерения ДЛУ
    PSD_ACEL=1.E-7;     % m2s-3(Paul D Groves)
    % Вектор параметров измерения ГИБ
    INSPAR.dw=dw;
    INSPAR.kmw=kmw;
    INSPAR.fiw=fiw;
    INSPAR.PSDw=PSD_GYRO;
    INSPAR.da0=da0;
    INSPAR.kma=kma;
    INSPAR.fia=fia;
    INSPAR.PSDa=PSD_ACEL;
    INSPAR.fINS=1.E+3;
end