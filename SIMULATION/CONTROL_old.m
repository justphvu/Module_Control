%% ФУНЦИЯ УПРАВЛЕНИЯ ПО ПИД РЕГУЛЯТОРУ
% Xd - вектор требуемых параметров состояния 
% Xd = [Ld,Hd,Zd,PSId)
function [U]=CONTROL(U0,X,Xd,TIME)
global  PARAM INVAFM
kT = PARAM.kT;   % коэффициент тяги 
Lq = PARAM.Lq;   % Плечо
kM = PARAM.kM;   % коэффициент момента
KEY=0;
    persistent DL0 DZ0 DH0 DTET0 DGAM0 DPSI0 SDL0 SDZ0 SDH0 SDTET0 SDGAM0 SDPSI0 dDLf0 dDZf0 dDHf0 dDTETf0 dDGAMf0 dDPSIf0

    %% Текущее состояние
    GAM = X(7);
    PSI = X(8);
    TET = X(9); 
    L   = X(10);
    H   = X(11);
    Z   = X(12);    
    
    %% Требуемое состояние 
    Ld  = Xd(1);
    Hd  = Xd(2);
    Zd  = Xd(3);
    PSId= Xd(4);    
    
    %% Отклонение от требуемой траектории
    DL=Ld-L;
    DZ=Zd-Z;
    DH=Hd-H;
    DPSI=PSId-PSI;
    
    %% Инициализация параметров для алгоритмов САУ
    if isempty(DL0)
        DL0=DL;        SDL0=0.0;    dDLf0=0.0;
        DZ0=DZ;        SDZ0=0.0;    dDZf0=0.0;             
    end
    
    %% Вычисление требуемого значения угла тангажа
    kP=5.0;    kI=1.0;    kD=6.0;
    sLIM=[-10;10];    
    [TETd,SDL,dDLf]=FCONTROL(DL,DL0,SDL0,dDLf0,sLIM,kP,kI,kD);    
    DL0=DL; SDL0=SDL; dDLf0=dDLf;
    % Вычисление требуемого значения угла крена
    kP=5.0;    kI=1.0;    kD=6.0;
    sLIM=[-10;10];
    [GAMd,SDZ,dDZf]=FCONTROL(DZ,DZ0,SDZ0,dDZf0,sLIM,kP,kI,kD);
    DZ0=DZ; SDZ0=SDZ;   dDZf0=dDZf;
    
    %% Отклонение от требуемой траектории по углам тангажа и крена
    TETd=0.0*pi/180; GAMd=0.0*pi/180; 
    DTET=TETd-TET;
    DGAM=GAMd-GAM;
    
    if isempty(DH0)
        DH0=DH;        SDH0=0.0;    dDHf0=0.0;
        DTET0=DTET;    SDTET0=0.0;  dDTETf0=0.0;
        DGAM0=DGAM;    SDGAM0=0.0;  dDGAMf0=0.0;
        DPSI0=DPSI;    SDPSI0=0.0;  dDPSIf0=0.0;        
    end
    %% Канал высоты
    kP=-1.0E+3;    kI=1.880E-2;    kD=-3.0E+1;
    sLIM=[-100;100];
    [UH,SDH,dDHf]=FCONTROL(DH,DH0,SDH0,dDHf0,sLIM,kP,kI,kD);
    DH0=DH; SDH0=SDH;   dDHf0=dDHf;
    
    %% Канал тангажа
    kP=5.0E00;    kI=5.0E-1;    kD=1.0E00;
    sLIM=[-100;100]*pi/180;
    [UTET,SDTET,dDTETf]=FCONTROL(DTET,DTET0,SDTET0,dDTETf0,sLIM,kP,kI,kD);
    DTET0=DTET; SDTET0=SDTET;   dDTETf0=dDTETf;
    
    %% Канал крена
    kP=5.0E00;    kI=5.0E-1;    kD=1.0E00;
    sLIM=[-100;100]*pi/180;
    [UGAM,SDGAM,dDGAMf]=FCONTROL(DGAM,DGAM0,SDGAM0,dDGAMf0,sLIM,kP,kI,kD);
    DGAM0=DGAM; SDGAM0=SDGAM;   dDGAMf0=dDGAMf;
    
    %% Канал курса
    kP=5.0E-1;    kI=5.0E-1;    kD=1.0E-1;
    sLIM=[-10;10]*pi/180;
    [UPSI,SDPSI,dDPSIf]=FCONTROL(DPSI,DPSI0,SDPSI0,dDPSIf0,sLIM,kP,kI,kD);
    DPSI0=DPSI; SDPSI0=SDPSI;   dDPSIf0=dDPSIf;
    
    if (KEY==0)
        UGAM=0.0;
        UTET=0.0;
        UPSI=0.0;
    end
    
     UH=1.0;
%     UGAM=0.0;
%     UTET=10.0;
%     UPSI=0.0;
    %% Требуемое изменение угловых скоростей
%     A=[ 2*U0(1) 2*U0(2) 2*U0(3) 2*U0(4);...
%         0 -2*U0(2) 0 2*U0(4);...
%         2*U0(1) 0 -2*U0(3) 0;...
%         2*U0(1) -2*U0(2) 2*U0(3) -2*U0(4)];
%     B=inv(A);
%     U1=[UH/kT;UGAM/kT/Lq;UTET/kT/Lq;UPSI/kM];
%    DUSQ=B*U1;
%    U=U0+DUSQ;

    DUSQ1=UH/(4*kT)+UTET/(2*kT*Lq)+UPSI/(4*kM);
    DUSQ2=UH/(4*kT)-UGAM/(2*kT*Lq)-UPSI/(4*kM);
    DUSQ3=UH/(4*kT)-UTET/(2*kT*Lq)+UPSI/(4*kM);
    DUSQ4=UH/(4*kT)+UGAM/(2*kT*Lq)-UPSI/(4*kM);
    DUSQ=[DUSQ1;DUSQ2;DUSQ3;DUSQ4];

    U0SQ=U0.^2;
    USQ=U0SQ+DUSQ;
    USQ(USQ<0)=0;
    U=USQ.^0.5;    

end

% Функция вычисления требуемого значения угла тангажа и крена по требуемым
% координатам L и Z
function [DELTA,Se,def]=FCONTROL(e,e0,Se0,def0,SeLIM,kP,kI,kD)
global DT  
    de=(e-e0)/DT;    
    N=10.0;
    [def]=fFILTER(def0,de,N);
    Se=Se0+e*DT;
    
    if (Se>max(SeLIM))
        Se=max(SeLIM);
    end
    
    if (Se<min(SeLIM))
        Se=min(SeLIM);
    end
    
    DELTA=kP*e+kI*Se+kD*def;
end
% Функция фильтрации производной от сигнала
% W(s)=(Ns)/(N+s)
function [xf]=fFILTER(xf0,x,N)
global DT
    xf=xf0+N*(x-xf0)*DT;
end