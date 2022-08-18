function [XPNK]=INS(AfBI_b,WBI_b)
global INSPAR Cbn0 XB0
persistent Cbn XB
    if isempty(Cbn)
        Cbn=Cbn0;
        XB=XB0;
    end
    % ������ ������ ���
    fINS=INSPAR.fINS;
    TAU=1.0/fINS;
    TAU=0.001;
    %% ������ ����������
    % ������ �� ����������
    Wx=WBI_b(1);
    Wy=WBI_b(2);
    Wz=WBI_b(3);
    % ������� ����������������� ��������� ��������
	KWBI=[  0 -Wz Wy; 
            Wz 0 -Wx;
           -Wy Wx 0];
    DCBI=Cbn*KWBI;   
    Cbn=Cbn+DCBI*TAU;
    
	% ������� ������ ����� ���������� �������� � ���
	TETB=asin(Cbn(2,1));
	GAMB=atan(-Cbn(2,3)/Cbn(2,2));
	PSIB=atan(-Cbn(3,1)/Cbn(1,1));
    
    %% ������ ���������
    % ������� ��������� �������������� �� ��� � ���
    AfBI_n=Cbn*AfBI_b;
    g=[0;-9.81;0];
    ABE_n=AfBI_n+g;
    % ������� ��������
    Vx=XB(1);    Vy=XB(2);    Vz=XB(3);
    % ���������� ������� ������������� ���������� XB
    DXB=[ABE_n(1);ABE_n(2);ABE_n(3);Vx;Vy;Vz];
    % ������� ������ ���������
    XB=XB+DXB*TAU;
    %% �����     
    XPNK=[Wx;Wy;Wz;GAMB;PSIB;TETB;XB];
end