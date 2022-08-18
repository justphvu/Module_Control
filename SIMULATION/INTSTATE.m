%% ������� ������������� ��������� �������������

function [X0,U0]=INTSTATE(Xzad,KEY) 
    % ����������� �� ����
    x=1;    y=2;    z=3;
    
    %% ������� ������ ������������ 
    [BAL,J]=BALANCING(Xzad,KEY);
    
    %% ���������� ���������� ���������� ���������
    Vxb = Xzad(1);  % �������� �������� � ���
    Vyb = Xzad(2); 
    Vzb = Xzad(3);           
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
    L  = Xzad(10);  % ���������� � ��� 
    H  = Xzad(11);
    Z  = Xzad(12);     

    PSI        = 0.0*pi/180.0;
    GAM        = 30.0*pi/180.0;
    TET        = 30.0*pi/180.0;
    %% ������ ���������� ��������� �������
    X0=[Vxb,Vyb,Vzb,Wxb,Wyb,Wzb,GAM,PSI,TET,L,H,Z];
    U0=[BAL(1);BAL(2);BAL(3);BAL(4)];      
end
    


