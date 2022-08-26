%% ������� ������������� ��������� �������������

function [X0,U0]=INTSTATE(Xzad,KEY) 
    % ����������� �� ����
    x=1;    y=2;    z=3;
    
    %% ������� ������ ������������ 
    [BAL,J]=BALANCING(Xzad,KEY);
    
    %% ���������� ���������� ���������� ���������
    Vxg = Xzad(1);  % �������� �������� � ���
    Vyg = Xzad(2); 
    Vzg = Xzad(3);           
    Wxb = Xzad(4);  % ������� �������� � ���
    Wyb = Xzad(5);
    Wzb = Xzad(6);        
    GAM = Xzad(7);  % ����
    PSI = Xzad(8);  % ����
    if (KEY==0)     % ������
        TET = Xzad(9); % ����� �������/�����/�������   
    else
        TET = BAL(5);  % ����� �������
    end  
    L   = Xzad(10);  % ���������� � ��� 
    H   = Xzad(11);
    Z   = Xzad(12);     
    % ��� �������� �������
    PSI = 0.0*pi/180.0;
    GAM = 0.0*pi/180.0;
    TET = 0.0*pi/180.0;
    
    Q=EULER2QUAT(TET,GAM,PSI);
    %% ������ ���������� ��������� �������
    X0=[Vxg,Vyg,Vzg,Wxb,Wyb,Wzb,Q(1),Q(2),Q(3),Q(4),L,H,Z];
    U0=[BAL(1);BAL(2);BAL(3);BAL(4)];      
end
    


