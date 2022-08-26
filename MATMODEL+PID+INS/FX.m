%% МАТЕМАТИЧЕСКАЯ МОДЕЛЬ ДВИЖЕНИЯ 

function[DX]=FX(X, U, TIME) 
    global  PARAM AfBI_b WBI_b
    % Параметры модели Земли и атмосферы
    g   = 9.81;  % ускорение силы тяжести
    pho = 1.225; % плотность воздуха 
        
    % Обозначение по осям
    x=1;    y=2;    z=3;
    
    %% Параметры пропеллеров
    %CT  = 1.0e-9;   % коэффициент подъемной силы пропеллера
    %D   = 11;       % диаметр пропеллера
    %CQ  =           % коэффициент момента пропеллера
    
    kT = PARAM.kT;   % коэффициент тяги 
    kM = PARAM.kM;   % коэффициент момента
    kD = PARAM.kD;   % коэффициент сопротивления 
  
    %% Массо-инерционные параметры
    % Масса
    m = PARAM.m;
    % Моменты инерции
    Jxx = PARAM.Jxx;    
    Jyy = PARAM.Jyy;    
    Jzz = PARAM.Jzz;
    % Плечо
    Lq  = PARAM.Lq;
    
    %% Вектор управления
    uH   = U(1);
    uTET = U(2);
    uGAM = U(3);
    uPSI = U(4);
    
    %% Векторы состояния
    % Скорость в ССК
    Vxg = X(1);     
    Vyg = X(2);
    Vzg = X(3);
    % Угловые скорости в ССК
    Wxb  = X(4);
    Wyb  = X(5);
    Wzb  = X(6);
    % Кватернион ориентации
    Q0  = X(7);    
    Q1  = X(8);    
    Q2  = X(9);    
    Q3  = X(10);
    % Вектор скорости в ГСК
    Vg  = [Vxg;Vyg;Vzg];
    % Вектор угловых скоростей в ССК
    Wb  = [Wxb;Wyb;Wzb];
    % Матрица перехода из ССК в ГСК
    Q=[Q0;Q1;Q2;Q3];
    Cbg = QUAT2MATR(Q); 
    % Вектор скорости в CСК
    Vb=Cbg'*Vg;
    
    %% Силы и моменты   
    % Сила тяги             
    FTb   = [0;uH;0];     % Вектор результирующий в ССК
    % Сила сопротивления    
    FDb   = -kD*Vb.^2;    % (в ССК)
    % Сила тяжести          
    FGg   = m*[0; -g; 0]; % (в ГСК)
    

    %% Динамика поступательного движения (в ГСК)  
    DVg=(Cbg*FTb+Cbg*FDb+FGg)/m;
        
    %% Динамика вращения твердого тела
    DWxb=(uGAM+(Jyy-Jzz)*Wyb*Wzb)/Jxx;
    DWyb=(uPSI+(Jzz-Jxx)*Wxb*Wzb)/Jyy;
    DWzb=(uTET+(Jxx-Jyy)*Wxb*Wyb)/Jzz;
    
    %% Кинематика 
    % Дифф. для кватерниона поворота
    QW=[0;Wxb;Wyb;Wzb];
    MQ=[Q0 -Q1 -Q2 -Q3;
        Q1  Q0 -Q3  Q2;
        Q2  Q3  Q0 -Q1;
        Q3 -Q2  Q1  Q0];
    DQ=0.5*MQ*QW;
    % Дифф. для координат
    DL=Vg(x);
    DH=Vg(y);
    DZ=Vg(z);

    %% Вектор системы дифф. движения ЛА
    DX=[DVg(x) DVg(y) DVg(z) DWxb DWyb DWzb DQ(1) DQ(2) DQ(3) DQ(4) DL DH DZ];
    
    %% ДЛЯ ИНС
    AfBI_b=(FTb+FDb)/m;
    WBI_b=[Wxb;Wyb;Wzb];  
%     persistent count
%     if isempty(count)
%         count=0;
%     end
%     if (count==0)
%         AfBI_b=(FTb+FDb)/m;
%         WBI_b=[Wxb;Wyb;Wzb];   
%     end
%     count=count+1;
%     if (count==4)
%         count=0;
%     end
end