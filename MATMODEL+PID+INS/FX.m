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
    Vxg = X(1);     
    Vyg = X(2);
    Vzg = X(3);
    % ������� �������� � ���
    Wxb  = X(4);
    Wyb  = X(5);
    Wzb  = X(6);
    % ���������� ����������
    Q0  = X(7);    
    Q1  = X(8);    
    Q2  = X(9);    
    Q3  = X(10);
    % ������ �������� � ���
    Vg  = [Vxg;Vyg;Vzg];
    % ������ ������� ��������� � ���
    Wb  = [Wxb;Wyb;Wzb];
    % ������� �������� �� ��� � ���
    Q=[Q0;Q1;Q2;Q3];
    Cbg = QUAT2MATR(Q); 
    % ������ �������� � C��
    Vb=Cbg'*Vg;
    
    %% ���� � �������   
    % ���� ����             
    FTb   = [0;uH;0];     % ������ �������������� � ���
    % ���� �������������    
    FDb   = -kD*Vb.^2;    % (� ���)
    % ���� �������          
    FGg   = m*[0; -g; 0]; % (� ���)
    

    %% �������� ��������������� �������� (� ���)  
    DVg=(Cbg*FTb+Cbg*FDb+FGg)/m;
        
    %% �������� �������� �������� ����
    DWxb=(uGAM+(Jyy-Jzz)*Wyb*Wzb)/Jxx;
    DWyb=(uPSI+(Jzz-Jxx)*Wxb*Wzb)/Jyy;
    DWzb=(uTET+(Jxx-Jyy)*Wxb*Wyb)/Jzz;
    
    %% ���������� 
    % ����. ��� ����������� ��������
    QW=[0;Wxb;Wyb;Wzb];
    MQ=[Q0 -Q1 -Q2 -Q3;
        Q1  Q0 -Q3  Q2;
        Q2  Q3  Q0 -Q1;
        Q3 -Q2  Q1  Q0];
    DQ=0.5*MQ*QW;
    % ����. ��� ���������
    DL=Vg(x);
    DH=Vg(y);
    DZ=Vg(z);

    %% ������ ������� ����. �������� ��
    DX=[DVg(x) DVg(y) DVg(z) DWxb DWyb DWzb DQ(1) DQ(2) DQ(3) DQ(4) DL DH DZ];
    
    %% ��� ���
    AfBI_b=(FTb+FDb)/m;
    WBI_b=[Wxb;Wyb;Wzb];  
%     persistent count
%     if isempty(count)
%         count=0;
%     end
%     if (count==0)
%         AfBI_b=(FTb+FDb)/m;
%         WBI_b=[Wxb;Wyb;Wzb];   
%     end
%     count=count+1;
%     if (count==4)
%         count=0;
%     end
end