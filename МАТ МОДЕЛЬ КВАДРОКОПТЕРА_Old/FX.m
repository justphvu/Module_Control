%% МАТЕМАТИЧЕСКАЯ МОДЕЛЬ ДВИЖЕНИЯ 

function[DX]=FX(X, U, TIME) 
    global  PARAM 
    
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
    
    %% Векторы состояния
    % Скорость в ССК
    Vxb = X(1);     
    Vyb = X(2);
    Vzb = X(3);
    % Угловые скорости в ССК
    Wxb  = X(4);
    Wyb  = X(5);
    Wzb  = X(6);
    % Углы ориентации
    GAM  = X(7);    % крен
    PSI  = X(8);    % курс
    TET  = X(9);    % тангаж
    % Вектор скорости в CСК
    Vb  = [Vxb;Vyb;Vzb];
    % Матрица перехода из ССК в ГСК
    Cbg = C_bg(TET,PSI,GAM); 
    
    %% Силы и моменты   
    % Сила тяги             
    THRST = kT*U.^2;            % Тяга моторов
    FTb   = [0;sum(THRST);0];   % Вектор результирующий в ССК
    % Сила сопротивления    
    FDb   = -kD*Vb.^2;          % (в ССК)
    % Сила тяжести          
    FGg   = m*[0; -g; 0];         % (в ГСК)
    FGb   = Cbg'*FGg;           % (в ССК)
    % Момент                    % (в ССК)
    MM    = kM*U.^2;            % (в ССК)

    %% Динамика поступательного движения (в ССК)
    DVb=(FTb+FDb+FGb)/m;
        
    %% Динамика вращения твердого тела
    DWxb=(Lq*(THRST(4)-THRST(2))+(Jyy-Jzz)*Wyb*Wzb)/Jxx;
    DWyb=((MM(1)+MM(3))-(MM(2)+MM(4))+(Jzz-Jxx)*Wxb*Wzb)/Jyy;
    DWzb=(Lq*(THRST(1)-THRST(3))+(Jxx-Jyy)*Wxb*Wyb)/Jzz;
    
    %% Кинематика 
    % Дифф. для углов ориентации
    DPSI=-(sin(GAM)/cos(TET))*Wzb+(cos(GAM)/cos(TET))*Wyb;
    DTET=Wzb*cos(GAM)+Wyb*sin(GAM);
    DGAM=Wxb+Wzb*sin(GAM)*tan(TET)-Wyb*cos(GAM)*tan(TET);
    % Вектор скорости в ГСК
    Vg=Cbg*Vb;
    % Дифф. для координат
    DL=Vg(x);
    DH=Vg(y);
    DZ=Vg(z);

    %% Вектор системы дифф. движения ЛА
    DX=[DVb(x) DVb(y) DVb(z) DWxb DWyb DWzb DGAM DPSI DTET DL DH DZ];

end