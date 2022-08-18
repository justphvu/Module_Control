%% МОДЕЛИРОВАНИЯ ПОЛЕТА

function [X]=MODELING(X0,U0,TF,DT) 
global AfBI_b WBI_b
    fOUT = fopen('.\\TLM\\OUT.ris','wt','s','KOI8-R');
    fprintf(fOUT,'Vxb Vyb Vzb Wxb Wyb Wzb GAM PSI TET L H Z deltaT1 deltaT2 deltaT3 deltaT4\r\n');
    fINS = fopen('.\\TLM\\INS.ris','wt','s','KOI8-R');
    fprintf(fINS,'Wx Wy Wz GAM PSI TET Vx Vy Vz L H Z VVx VVy VVz\r\n');
    str='%f ';
    format=[];
    n=size(X0(:),1);
    for i=1:n+5  %12 воздействий + 4 двигателя + время 
        format=[format str];
    end
    format=[format '\n'];
    formatINS='%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n';
    % Время 
    TIME=0;
    % Начальное состояние
    X=X0;   
    U=U0; 
    % Требуемое состояние
    Xd=[1 11 1 45*pi/180];
    % Прототип функции динамика полета
    f=@(X,U,TIME)FX(X,U,TIME);
    
    % Цикл моделирования
    count=0;   
    
    while (TIME<TF)
        [X,DX]=RK4(f,TIME,DT,X,U); 
       % WBI_b=[X(4);X(5);X(6)];
        [XPNK]=INS(AfBI_b,WBI_b);
       
    Vxb = X(1);     
    Vyb = X(2);
    Vzb = X(3);
       
    GAM  = X(7);    % крен
    PSI  = X(8);    % курс
    TET  = X(9);    % тангаж
    % Вектор скорости в CСК
    Vb  = [Vxb;Vyb;Vzb];
    % Матрица перехода из ССК в ГСК
    Cbg = C_bg(TET,PSI,GAM); 
    Vg=Cbg*Vb;
    
 %       if (count==10)
            fprintf(fOUT,format,TIME,X,U); 
            fprintf(fINS,formatINS,TIME,XPNK,Vg); 
            count=0;
 %       end
        
        [U]=CONTROL(U0,X,Xd,TIME);
        TIME=TIME+DT;
        count=count+1;
    end
end

