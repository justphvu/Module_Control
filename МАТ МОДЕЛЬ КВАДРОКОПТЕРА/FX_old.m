%% �������������� ������ �������� 

function[DX]=FX(X, U, TIME) 
    global  PARAM 
    
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
    % ������� �������� �� ��� � ���
    Cbg = C_bg(TET,PSI,GAM); 
    
    %% ���� � �������   
    % ���� ����             
    THRST = kT*U.^2;            % ���� �������
    FTb   = [0;sum(THRST);0];   % ������ �������������� � ���
    % ���� �������������    
    FDb   = -kD*Vb.^2;          % (� ���)
    % ���� �������          
    FGg   = m*[0; -g; 0];         % (� ���)
    FGb   = Cbg'*FGg;           % (� ���)
    % ������                    % (� ���)
    MM    = kM*U.^2;            % (� ���)

    %% �������� ��������������� �������� (� ���)
    DVb=(FTb+FDb+FGb)/m;
        
    %% �������� �������� �������� ����
    DWxb=(Lq*(THRST(4)-THRST(2))+(Jyy-Jzz)*Wyb*Wzb)/Jxx;
    DWyb=((MM(1)+MM(3))-(MM(2)+MM(4))+(Jzz-Jxx)*Wxb*Wzb)/Jyy;
    DWzb=(Lq*(THRST(1)-THRST(3))+(Jxx-Jyy)*Wxb*Wyb)/Jzz;
    
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

end