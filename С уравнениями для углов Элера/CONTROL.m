%% ФУНЦИЯ УПРАВЛЕНИЯ ПО ПИД РЕГУЛЯТОРУ
% Xd - вектор требуемых параметров состояния 
% Xd = [Ld,Hd,Zd,PSId)
function [U]=CONTROL(U0,X,Xd,TIME)
global  PARAM INVAFM PRSTOP
kT = PARAM.kT;   % коэффициент тяги 
Lq = PARAM.Lq;   % Плечо
kM = PARAM.kM;   % коэффициент момента
KEY=0;
    persistent DL0 DZ0 DH0 DTET0 DGAM0 DPSI0 SDL0 SDZ0 SDH0 SDTET0 SDGAM0 SDPSI0 dDLf0 dDZf0 dDHf0 dDTETf0 dDGAMf0 dDPSIf0

    %% Текущее состояние   
%     Wx  = XPNK(1);
%     Wy  = XPNK(2);
%     Wz  = XPNK(3);
%     GAM = XPNK(4);
%     PSI = XPNK(5);
%     TET = XPNK(6); 
%     Vx  = XPNK(7);
%     Vy  = XPNK(8);
%     Vz  = XPNK(9); 
%     L   = XPNK(10);
%     H   = XPNK(11);
%     Z   = XPNK(12); 
    
    Vxb = X(1);     
    Vyb = X(2);
    Vzb = X(3);
    Wx  = X(4);
    Wy  = X(5);
    Wz  = X(6);
    GAM = X(7);
    PSI = X(8);
    TET = X(9); 
    L   = X(10);
    H   = X(11);
    Z   = X(12);  
    Cbg = C_bg(TET,PSI,GAM); 
    Vb  = [Vxb;Vyb;Vzb];
    Vg=Cbg*Vb;
    Vx=Vg(1);
    Vy=Vg(2);
    Vz=Vg(3);
    
    %% Требуемое состояние 
%     persistent i
%     if isempty(i)
%         i=1;
%     end
%     
%     Xdi=Xd(i,:);
%     Ld  = Xdi(1);
%     Hd  = Xdi(2);
%     Zd  = Xdi(3);
%     PSId= Xdi(4);
%     DR=sqrt((Ld-L)^2+(Hd-H)^2+(Zd-Z)^2);
%     if (DR<0.1)
%         i=i+1;
%         if (i==5)
%             PRSTOP=1;
%         end
%     end
    
    Ld  = Xd(1);
    Hd  = Xd(2);
    Zd  = Xd(3);
    PSId= Xd(4);
    %% Отклонение от требуемой траектории
    % Отклонение в ГСК
    DLg=Ld-L;  DH=Hd-H;  DZg=Zd-Z;
        
    % Перевод горизонтальных отклонений в ССК
    Cbg=C_bg(TET,PSI,GAM);    
    DL=DLg*Cbg(1,1)+DZg*Cbg(3,1);
    DZ=DLg*Cbg(1,3)+DZg*Cbg(3,3);
%    DL=DLg;DZ=DZg;
    
    % Ограничения 
    if (abs(DL)>1.0)        % По X
        DL=1.0*sign(DL);
    end

    if (abs(DZ)>1.0)        % По Z
        DZ=1.0*sign(DZ);
    end       
    if (abs(DH)>1.0)        % По H
        DH=1.0*sign(DH);
    end
    
    %% Инициализация параметров для алгоритмов САУ
    if isempty(DL0)
        DL0=DL;        SDL0=0.0;    dDLf0=0.0;
        DZ0=DZ;        SDZ0=0.0;    dDZf0=0.0;             
    end
    
    %% Вычисление требуемого значения угла тангажа
    %kP=34.509554; kI=0.001688; kD=23.051581;
    %kP=0.467101; kI=-0.000925; kD=0.358818;
    kP=-0.467101; kI=0.000925; kD=-0.358818;
    sLIM=[-10;10];    
    [TETd,SDL,dDLf]=FCONTROL(DL,-Vx,SDL0,dDLf0,sLIM,kP,kI,kD);  
    if (abs(TETd)>30*pi/180)
        TETd=30*pi/180*sign(TETd);
    end
    DL0=DL; SDL0=SDL; dDLf0=dDLf;
    % Вычисление требуемого значения угла крена
    kP=0.467101; kI=-0.000925; kD=0.358818;
    sLIM=[-10;10];
    [GAMd,SDZ,dDZf]=FCONTROL(DZ,-Vz,SDZ0,dDZf0,sLIM,kP,kI,kD);
    DZ0=DZ; SDZ0=SDZ;   dDZf0=dDZf;
    if (abs(GAMd)>30*pi/180)
        GAMd=30*pi/180*sign(GAMd);
    end

    %% Отклонение от требуемой траектории по углам ориентации
    %TETd=30.0*pi/180; 
    %GAMd=0.0*pi/180; 
    DTET=TETd-TET;
    DGAM=GAMd-GAM;
    DPSI=PSId-PSI;

    if isempty(DH0)
        DH0=DH;        SDH0=0.0;    dDHf0=0.0;
        DTET0=DTET;    SDTET0=0.0;  dDTETf0=0.0;
        DGAM0=DGAM;    SDGAM0=0.0;  dDGAMf0=0.0;
        DPSI0=DPSI;    SDPSI0=0.0;  dDPSIf0=0.0;        
    end
    %% Канал высоты
    %kP=46.51; kI=-0.016; kD=13.04;
    %kP=1.55; kI=-0.0003; kD=-2.24;
    kP=121.891975; kI=0.031686; kD=22.212291;
    sLIM=[-100;100];

    [UH,SDH,dDHf]=FCONTROL(DH,-Vy,SDH0,dDHf0,sLIM,kP,kI,kD);
    DH0=DH; SDH0=SDH;   dDHf0=dDHf;
    
    %% Канал тангажа
    %P=0.07; kI=0.001; kD=-0.03;
    kP=102.501439; kI=-1.568238; kD=0.641291;
    sLIM=[-90;90]*pi/180;
    [UTET,SDTET,dDTETf]=FCONTROL(DTET,-Wz,SDTET0,dDTETf0,sLIM,kP,kI,kD);
    DTET0=DTET; SDTET0=SDTET;   dDTETf0=dDTETf;
    
    %% Канал крена
    %kP=0.52; kI=0.006; kD=-0.29;
    kP=139.975588; kI=1.013681; kD=2.977457;
    sLIM=[-90;90]*pi/180;
    [UGAM,SDGAM,dDGAMf]=FCONTROL(DGAM,-Wx,SDGAM0,dDGAMf0,sLIM,kP,kI,kD);
    DGAM0=DGAM; SDGAM0=SDGAM;   dDGAMf0=dDGAMf;
    
    %% Канал курса
    %kP=0.75; kI=0.01; kD=-0.41;
    kP=100.000000; kI=-1.648288; kD=1.892632;
    sLIM=[-90;90]*pi/180;
    [UPSI,SDPSI,dDPSIf]=FCONTROL(DPSI,-Wy,SDPSI0,dDPSIf0,sLIM,kP,kI,kD);
    DPSI0=DPSI; SDPSI0=SDPSI;   dDPSIf0=dDPSIf;
    
%     if (KEY==0)
%         UH=0.0;
%         UGAM=0.0;
%         UTET=0.0;
%         UPSI=0.0;
%     end

    DU=[UH;UTET;UGAM;UPSI];
    U=U0+DU;    

end

% Функция вычисления требуемого значения угла тангажа и крена по требуемым
% координатам L и Z
function [DELTA,Se,def]=FCONTROL(e,edot,Se0,def0,SeLIM,kP,kI,kD)
global DT  
    N=10.0;
    [def]=fFILTER(def0,edot,N);
    Se=Se0+e*DT;
    
%     if (Se>max(SeLIM))
%         Se=max(SeLIM);
%     end
%     
%     if (Se<min(SeLIM))
%         Se=min(SeLIM);
%     end
    
%    DELTA=kP*e+kI*Se+kD*def;
    DELTA=kP*e+kI*Se+kD*edot;
end
% Функция фильтрации производной от сигнала
% W(s)=(Ns)/(N+s)
function [xf]=fFILTER(xf0,x,N)
global DT
    xf=xf0+N*(x-xf0)*DT;
end