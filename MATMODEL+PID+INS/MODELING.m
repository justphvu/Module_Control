%% МОДЕЛИРОВАНИЯ ПОЛЕТА
function [X]=MODELING(X0,U0,TF,DT)
global AfBI_b WBI_b PRSTOP
    % Файл для записи состояния ЛА
    fOUT = fopen('./OUT.ris','wt'); %,'s','KOI8-R');
    fprintf(fOUT,'Vxg Vyg Vzg Wxb Wyb Wzb Q0 Q1 Q2 Q3 L H Z GAM PSI TET deltaT1 deltaT2 deltaT3 deltaT4\r\n');
    % Файл для записи показаний ИНС
    fINS = fopen('./INS.ris','wt'); %,'s','KOI8-R');
    fprintf(fINS,'Wx Wy Wz GAM PSI TET Vx Vy Vz L H Z\r\n');
    % Формат записи
    str='%f ';
    % Для ЛА
    format=[];
    n=size(X0(:),1);
    for i=1:n+8
        format=[format str];
    end
    % Для ИНС
    format=[format '\n'];
    formatINS=[];
    for i=1:13
        formatINS=[formatINS str];
    end
    formatINS=[formatINS '\n'];

    % Время
    TIME=0;
    % Начальное состояние
    X=X0;
    U=U0;

    % Требуемое состояние
    Xd=[0 5  0 0*pi/180;
        5 5  0 0
        5 5 -5 0;
        0 5 -5 0;
        0 5  0 0;
        0 5  0 0];

%    Xd=[0 10 5 0*pi/180];

    % Прототип функции динамика полета
    f=@(X,U,TIME)FX(X,U,TIME);
    % Цикл моделирования
    count=0;

%    while (TIME<TF)
    while (PRSTOP==0)
        % Один шаг интегрирования уравнений движения ЛА
        [X,DX]=EULER(f,TIME,DT,X,U);
        Q=X(7:10);
        [TET,GAM,PSI]=QUAT2EULER(Q);
        % ИНС
        [XB]=INS(AfBI_b,WBI_b);
        % Печать результаты
        if (count==100)
            fprintf(fOUT,format,TIME,X(1:3),X(4:6)*180/pi,X(7:end),GAM,PSI,TET,U);
            fprintf(fINS,formatINS,TIME,XB(1:6)*180/pi,XB(7:end));
            count=0;
        end
        count=count+1;
        % ПНК
        [XPNK]=PNK(X);
        % Управление
        [U]=CONTROL(U0,XPNK,Xd,TIME);
        % Инскремент времени
        TIME=TIME+DT;
    end
end

