%% ПРОГРАММА ПОСТРОЕНИЯ ЛИНЕЙНЫХ МОДЕЛЕЙ ДВИЖЕНИЯ ЛА
clear all;
% Обозначение по осям
x=1;    y=2;    z=3;
    
%% Глобальные переменные
global  PARAM DT

% Режим полета
KEYREGIM = 0;

%% Инициализация временных параметров симуляции
DT      = 1.E-3;         % Шаг моделирования
 
%% Массо-габаритные параметры
PARAM.m     = 1.2;          % Масса, кг
PARAM.Jxx   = 2.344E-2;     % Моменты инерции
PARAM.Jyy   = 3.333E-2;
PARAM.Jzz   = 2.344E-3;
PARAM.Lq    = 0.3;          % Плечо

PARAM.kT    = 3.13E-5;      % коэффициент тяги 
PARAM.kM    = 7.4E-7;       % коэффициент момента
PARAM.kD    = 6.224E-8;     % коэффициент сопротивления 

%% Начальное состояние
Vxg0        = 0.0;      % в ГСК
Vyg0        = 0.0;
Vzg0        = 0.0;
Wxb0        = 0.0*pi/180.0;      % в ССК
Wyb0        = 0.0*pi/180.0;
Wzb0        = 0.0*pi/180.0;
PSI0        = 0.0*pi/180.0;
GAM0        = 0.0*pi/180.0;
TET0        = 0.0*pi/180.0;
L0          = 0.0;
H0          = 10;
Z0          = 0.0;
% Мартрица перехода
Cbg0 = C_bg(TET0,PSI0,GAM0);
% Скорость в ССК
Vg0 = [Vxg0;Vyg0;Vzg0];
Vb0 = Cbg0'*Vg0;
% Вектор начального состояния (требуемого в начальный момент времени)
Xzad=[Vb0(x),Vb0(y),Vb0(z),Wxb0,Wyb0,Wzb0,GAM0,PSI0,TET0,L0,H0,Z0];

%% Инициализация начального состояния квадракоптера
[X0,U0]    = INTSTATE(Xzad,KEYREGIM);

%% Вычисление матриц линейной модели
g=9.81;
kD=PARAM.kD;
m=PARAM.m;
Jxx=PARAM.Jxx;
Jyy=PARAM.Jyy;
Jzz=PARAM.Jzz;
% Опорная точка
Vbx=X0(1); Vby=X0(2);  Vbz=X0(3);
Wx=X0(4); Wy=X0(5); Wz=X0(6);
TET=X0(9); GAM=X0(7);  PSI=X0(8);
Cbg = C_bg(TET,PSI,GAM);
Vb=[Vbx;Vby;Vbz];
% Матрицы производных от направляющих матриц
C_TET=[-sin(TET)*cos(PSI)                               cos(TET)                sin(TET)*sin(PSI);...
       -cos(TET)*cos(GAM)*cos(PSI)                     -sin(TET)*cos(GAM)       cos(TET)*cos(GAM)*sin(PSI);...
       cos(TET)*sin(GAM)*cos(PSI)                       sin(TET)*sin(GAM)      -cos(TET)*sin(GAM)*sin(PSI)];
C_GAM=[0                                                0                       0;...
       sin(TET)*sin(GAM)*cos(PSI)+cos(GAM)*sin(PSI)     -cos(TET)*sin(GAM)      cos(GAM)*cos(PSI)-sin(TET)*sin(GAM)*sin(PSI);...
       sin(TET)*cos(GAM)*cos(PSI)-sin(GAM)*sin(PSI)     -cos(TET)*cos(GAM)    -sin(GAM)*cos(PSI)-sin(TET)*cos(GAM)*sin(PSI)];
C_PSI=[-cos(TET)*sin(PSI)                               0                      -cos(TET)*cos(PSI);...
        sin(TET)*cos(GAM)*sin(PSI)+sin(GAM)*cos(PSI)    0                      -sin(GAM)*sin(PSI)+sin(TET)*cos(GAM)*cos(PSI);...
       -sin(TET)*sin(GAM)*sin(PSI)+cos(GAM)*cos(PSI)    0                      -cos(GAM)*sin(PSI)-sin(TET)*sin(GAM)*cos(PSI)];
   
% Вспомогательные векторы
agamv=C_GAM*Vb;
atetv=C_TET*Vb;
apsiv=C_PSI*Vb;

% Матрицы модели продольного движения
% x=[Vx Vy Wz TET L H]; u=[uH uTET];
A_long=[-2*kD*Vbx/m     0                   0           -g*C_TET(1,2)/m     0   0;...
    0                  -2*kD*Vby/m          0           -g*C_TET(2,2)/m     0   0;...
    0                   0                   0           0                   0   0;...
    0                   0                   cos(GAM)    0                   0   0;...
    Cbg(1,1)            Cbg(1,2)            0           atetv(1)            0   0;...
    Cbg(2,1)            Cbg(2,2)            0           atetv(2)            0   0;];
B_long=[0 0; 1/m 0; 0 1/Jzz; 0 0; 0 0; 0 0];
C_long=[0 0 0 1 0 0];
D_long=0.0;
% Модель пространства состояния
sys_long=ss(A_long,B_long,C_long,D_long);
% Передаточные функции
G_long=tf(sys_long);
% Матрицы модели бокового движения
% x=[Vz Wx Wy GAM PSI Z]; u=[uGAM uPSI];
A_lat=[-2*kD*Vbz/m  0                 0                -g*C_GAM(3,2)/m                             -g*C_PSI(3,2)/m  0;...
        0           0                 (Jyy-Jzz)*Wz/Jxx  0                                           0               0;...
        0           (Jzz-Jxx)*Wz/Jyy  0                 0 0 0;...
        0           1                -cos(GAM)*tan(TET) Wz*cos(GAM)*tan(TET)+Wy*sin(GAM)*tan(TET)   0               0;...
        0           0                 cos(GAM)/cos(TET) (-Wy*sin(GAM)-Wz*cos(GAM))/cos(TET)         0               0;...
        Cbg(3,3)    0                 0                 agamv(3)                                    apsiv(3)        0];
B_lat=[0 0; 1/Jxx 0; 0 1/Jyy; 0 0; 0 0; 0 0;];
C_lat=[0 0 0 0 1 0];
D_lat=0.0;
% Модель пространства состояния
sys_lat=ss(A_lat,B_lat,C_lat,D_lat);
% Передаточные функции
G_lat=tf(sys_lat);
% save('Along.txt','A_long','-ascii');
% save('Blong.txt','B_long','-ascii');
% save('Alat.txt','A_lat','-ascii');
% save('Blat.txt','B_lat','-ascii');

%% Модель контура позиционированного управления
%x=[Vx Vy Vz L Z] u=[TET GAM]
A=[ -2*kD*Vbx/m  0           0          0    0;
    0           -2*kD*Vby/m  0          0    0;
    0            0          -2*kD*Vbx/m 0    0;
    Cbg(1,1)     Cbg(1,2)    0          0    0;
    0            0           Cbg(3,3)   0    0];
B=[ -g*C_GAM(1,2)/m 0;
    -g*C_GAM(2,2)/m 0;
     0              -g*C_GAM(3,2)/m;
     agamv(1)       0;
     0              agamv(3)];
     

