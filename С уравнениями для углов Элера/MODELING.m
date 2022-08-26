%% МОДЕЛИРОВАНИЯ ПОЛЕТА

function [X]=MODELING(X0,U0,TF,DT) 
global AfBI_b WBI_b PRSTOP
    % Файл для записи состояния ЛА
    fOUT = fopen('.\\TLM\\OUT.ris','wt','s','KOI8-R');
    fprintf(fOUT,'Vxb Vyb Vzb Wxb Wyb Wzb GAM PSI TET L H Z deltaT1 deltaT2 deltaT3 deltaT4\r\n');
    % Файл для записи показаний ИНС
    fINS = fopen('.\\TLM\\INS.ris','wt','s','KOI8-R');
    fprintf(fINS,'Wx Wy Wz GAM PSI TET Vx Vy Vz L H Z\r\n');
    % Формат записи
    str='%15.12f ';
    % Для ЛА
    format=[];    
    n=size(X0(:),1);
    for i=1:n+5  
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
%     Xd=[5 11 0 0*pi/180;
%         5 10 -5 0;
%         0 11 -5 0;
%         0 10 0 0];
    
    Xd=[5 10 0 0*pi/180];        
    
    % Прототип функции динамика полета
    f=@(X,U,TIME)FX(X,U,TIME);
    % Цикл моделирования
    count=0;   
    
    while (TIME<TF)
%    while (PRSTOP==0)
        % Один шаг интегрирования уравнений движения ЛА
        [X,DX]=RK4(f,TIME,DT,X,U); 
        % ИНС
        [XPNK]=INS(AfBI_b,WBI_b);
        % Печать результаты
        if (count==100)
            fprintf(fOUT,format,TIME,X(1:3),X(4:9)*180/pi,X(10:end),U); 
            fprintf(fINS,formatINS,TIME,XPNK(1:6)*180/pi,XPNK(7:end)); 
            count=0;
        end
        count=count+1;
        % Управление
        [U]=CONTROL(U0,X,Xd,TIME);
        % Инскремент времени
        TIME=TIME+DT;        
    end
end

