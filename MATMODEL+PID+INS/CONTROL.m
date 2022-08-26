%% ������ ���������� �� ��� ����������
% Xd - ������ ��������� ���������� ��������� 
% Xd = [Ld,Hd,Zd,PSId)
function [U]=CONTROL(U0,XPNK,Xd,TIME)
global  PARAM INVAFM PRSTOP
kT = PARAM.kT;   % ����������� ���� 
Lq = PARAM.Lq;   % �����
kM = PARAM.kM;   % ����������� �������
KEY=0;
    persistent DL0 DZ0 DH0 DTET0 DGAM0 DPSI0 SDL0 SDZ0 SDH0 SDTET0 SDGAM0 SDPSI0 dDLf0 dDZf0 dDHf0 dDTETf0 dDGAMf0 dDPSIf0

    %% ������� ��������� (������ ���������� �� ������������� ����������  
    Wx  = XPNK(1);
    Wy  = XPNK(2);
    Wz  = XPNK(3);
    GAM = XPNK(4);
    PSI = XPNK(5);
    TET = XPNK(6); 
    Vx  = XPNK(7);
    Vy  = XPNK(8);
    Vz  = XPNK(9); 
    L   = XPNK(10);
    H   = XPNK(11);
    Z   = XPNK(12);     
    
    %% ��������� ��������� 
    [m,n]=size(Xd);     % ������ ������ �������� ���������
    persistent i        % ������ ������� ������
    if isempty(i)
        i=1;
    end
    % ������ ��������� ��������� � ������ ������� ������
    Xdi=Xd(i,:);
    Ld  = Xdi(1);
    Hd  = Xdi(2);
    Zd  = Xdi(3);
    PSId= Xdi(4);
    % �������� ��������
    DR=sqrt((Ld-L)^2+(Hd-H)^2+(Zd-Z)^2);
    % ���� �������� �������� �� ������ ������� ������ ������� --> ��������� �� ������ ������� ������
    if (DR<0.01)
        i=i+1;
        % ���� ��� ������� ��� ��������� --> ��������� �������������
        if (i==m+1)
            PRSTOP=1;
        end
    end
    
%     Ld  = Xd(1);
%     Hd  = Xd(2);
%     Zd  = Xd(3);
%     PSId= Xd(4);
    %% ���������� �� ��������� ���������� (�� �����������)
    % ���������� � ���
    DLg=Ld-L;  DH=Hd-H;  DZg=Zd-Z;
        
    % ������� �������������� ���������� � ��� ��� ���������� ���������
    % ����� ������� � �����
    Cbg=C_bg(TET,PSI,GAM);    
    DL=DLg*Cbg(1,1)+DZg*Cbg(3,1);
    DZ=DLg*Cbg(1,3)+DZg*Cbg(3,3);
%    DL=DLg;DZ=DZg;
    
    % ����������� (����� �� ���������� ������� ������� ��������� �������� ����� �����
    % � �������
    DLmax=1.0; DZmax=1.0; DHmax=1.0; % ����� ������ �� �������   
    if (abs(DL)>DLmax)        % �� X
        DL=DLmax*sign(DL);
    end

    if (abs(DZ)>DZmax)        % �� Z
        DZ=DZmax*sign(DZ);
    end       
    if (abs(DH)>DHmax)        % �� H
        DH=DHmax*sign(DH);
    end
    
    %% ������������� ���������� ��� ���������� ���
    if isempty(DL0)
        DL0=DL;        SDL0=0.0;    dDLf0=0.0;
        DZ0=DZ;        SDZ0=0.0;    dDZf0=0.0;             
    end
    
    %% ���������� ���������� �������� ����� ������� � �����
    % ����������� �� ��������� ��������� �����
    % ���������� ���������� �������� ���� �������
    TETmax=30*pi/180; GAMmax=30*pi/180;
    kP=-0.467101; kI=0.000925; kD=-0.358818;
    sLIM=[-10;10];    
    [TETd,SDL,dDLf]=FCONTROL(DL,-Vx,SDL0,dDLf0,sLIM,kP,kI,kD);  
    if (abs(TETd)>TETmax)
        TETd=30*pi/180*sign(TETd);
    end
    DL0=DL; SDL0=SDL; dDLf0=dDLf;
    % ���������� ���������� �������� ���� �����
    kP=0.467101; kI=-0.000925; kD=0.358818;
    sLIM=[-10;10];
    [GAMd,SDZ,dDZf]=FCONTROL(DZ,-Vz,SDZ0,dDZf0,sLIM,kP,kI,kD);
    DZ0=DZ; SDZ0=SDZ;   dDZf0=dDZf;
    if (abs(GAMd)>GAMmax)
        GAMd=GAMmax*sign(GAMd);
    end

    %% ������� ���������� �� ��������� ���������� �� ����� ����������
    DTET=TETd-TET;
    DGAM=GAMd-GAM;
    DPSI=PSId-PSI;

    if isempty(SDH0)
        SDH0=0.0;    dDHf0=0.0;
        SDTET0=0.0;  dDTETf0=0.0;
        SDGAM0=0.0;  dDGAMf0=0.0;
        SDPSI0=0.0;  dDPSIf0=0.0;        
    end
    %% ����� ������
    kP=46.51; kI=-0.016; kD=13.04;
    %kP=121.891975; kI=0.031686; kD=22.212291;
    sLIM=[-100;100];

    [UH,SDH,dDHf]=FCONTROL(DH,-Vy,SDH0,dDHf0,sLIM,kP,kI,kD);
    SDH0=SDH;   dDHf0=dDHf;
    
    %% ����� �������
    kP=102.501439; kI=-1.568238; kD=0.641291;
    sLIM=[-90;90]*pi/180;
    [UTET,SDTET,dDTETf]=FCONTROL(DTET,-Wz,SDTET0,dDTETf0,sLIM,kP,kI,kD);
    SDTET0=SDTET;   dDTETf0=dDTETf;
    
    %% ����� �����
    kP=139.975588; kI=1.013681; kD=2.977457;
    sLIM=[-90;90]*pi/180;
    [UGAM,SDGAM,dDGAMf]=FCONTROL(DGAM,-Wx,SDGAM0,dDGAMf0,sLIM,kP,kI,kD);
    SDGAM0=SDGAM;   dDGAMf0=dDGAMf;
    
    %% ����� �����
    kP=100.000000; kI=-1.648288; kD=1.892632;
    sLIM=[-90;90]*pi/180;
    [UPSI,SDPSI,dDPSIf]=FCONTROL(DPSI,-Wy,SDPSI0,dDPSIf0,sLIM,kP,kI,kD);
    SDPSI0=SDPSI;   dDPSIf0=dDPSIf;
    
%     if (KEY==0)
%         UH=0.0;
%         UGAM=0.0;
%         UTET=0.0;
%         UPSI=0.0;
%     end

    DU=[UH;UTET;UGAM;UPSI];
    U=U0+DU;    

end

% ������� ���������� ���������� �������� ���� ������� � ����� �� ���������
% ����������� L � Z
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
% ������� ���������� ����������� �� �������
% W(s)=(Ns)/(N+s)
function [xf]=fFILTER(xf0,x,N)
global DT
    xf=xf0+N*(x-xf0)*DT;
end