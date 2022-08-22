%% ПРОГРАММА СИМУЛЯЦИИ ПОЛЕТА
clear all;
%% Глобальные переменные
global  PARAM INVAFM DT INSPAR Cbn0 XB0 AfBI_b WBI_b

% Режим полета
KEYREGIM = 0;

%% Инициализация временных параметров симуляции
DT      = 1.E-3;            % Шаг моделирования
TMODEL  = 1.0E+1;           % Время моделирования

%% Инициализация симмуляции
[PARAM,INVAFM,Xzad]=INITSIM;

%% Инициализация начального состояния квадракоптера
[X0,U0]    = INTSTATE(Xzad,KEYREGIM);

%% Инициализация параметров навигационных комплексов
[INSPAR,Cbn0,XB0] = INITINS(X0);

%% Цикл моделирования
X=MODELING(X0,U0,TMODEL,DT);

GRAPHPLOT;


