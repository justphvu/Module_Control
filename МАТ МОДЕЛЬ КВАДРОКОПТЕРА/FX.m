%% �������������� ������ �������� 

function[DX]=FX(X, U, TIME) 
    global  PARAM AfBI_b WBI_b
    
    % ��������� ������ ����� � ���������
    g   = 9.81;  % ��������� ���� �������
    pho = 1.225; % ��������� ������� 
        
    % ����������� �� ����
    x=1;    y=2;    z=3;
    
    %% ��������� �����������
    %CT  = 1.0e-9;   % ����������� ��������� ���� ����������
    %D   = 11;       % ������� ����������
    %CQ  =           % ����������� ������� ����������
    
    kT = PARAM.kT;   % ����������� ���� 
    kM = PARAM.kM;   % ����������� �������
    kD = PARAM.kD;   % ����������� ������������� 
  
    %% �����-����������� ���������
    % �����
    m = PARAM.m;
    % ������� �������
    Jxx = PARAM.Jxx;    
    Jyy = PARAM.Jyy;    
    Jzz = PARAM.Jzz;
    % �����
    Lq  = PARAM.Lq;
    
    %% ������ ����������
    uH   = U(1);
    uTET = U(2);
    uGAM = U(3);
    uPSI = U(4);
    
    %% ������� ���������
    % �������� � ���
    Vxb = X(1);     
    Vyb = X(2);
    Vzb = X(3);
    % ������� �������� � ���
    Wxb  = X(4);
    Wyb  = X(5);
    Wzb  = X(6);
    % ���� ����������
    GAM  = X(7);    % ����
    PSI  = X(8);    % ����
    TET  = X(9);    % ������
    % ������ �������� � C��
    Vb  = [Vxb;Vyb;Vzb];
    % ������ ������� ��������� � ���
    Wb  = [Wxb;Wyb;Wzb];
    % ������� �������� �� ��� � ���
    Cbg = C_bg(TET,PSI,GAM); 
    
    %% ���� � �������   
    % ���� ����             
    FTb   = [0;uH;0];   % ������ �������������� � ���
    % ���� �������������    
    FDb   = -kD*Vb.^2;          % (� ���)
    % ���� �������          
    FGg   = m*[0; -g; 0];         % (� ���)
    FGb   = Cbg'*FGg;           % (� ���)

    %% �������� ��������������� �������� (� ���)
    DVb=(FTb+FDb+FGb)/m+cross(Vb,Wb);
        
    %% �������� �������� �������� ����
    DWxb=(uGAM+(Jyy-Jzz)*Wyb*Wzb)/Jxx;
    DWyb=(uPSI+(Jzz-Jxx)*Wxb*Wzb)/Jyy;
    DWzb=(uTET+(Jxx-Jyy)*Wxb*Wyb)/Jzz;
    
    %% ���������� 
    % ����. ��� ����� ����������
    DPSI=-(sin(GAM)/cos(TET))*Wzb+(cos(GAM)/cos(TET))*Wyb;
    DTET=Wzb*cos(GAM)+Wyb*sin(GAM);
    DGAM=Wxb+Wzb*sin(GAM)*tan(TET)-Wyb*cos(GAM)*tan(TET);
    % ������ �������� � ���
    Vg=Cbg*Vb;
    % ����. ��� ���������
    DL=Vg(x);
    DH=Vg(y);
    DZ=Vg(z);

    %% ������ ������� ����. �������� ��
    DX=[DVb(x) DVb(y) DVb(z) DWxb DWyb DWzb DGAM DPSI DTET DL DH DZ];
    
    %% ��� ���
    AfBI_b=(FTb+FDb)/m;
    WBI_b=[Wxb;Wyb;Wzb];

end