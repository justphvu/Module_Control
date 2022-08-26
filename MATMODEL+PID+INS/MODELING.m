%% ������������� ������
function [X]=MODELING(X0,U0,TF,DT)
global AfBI_b WBI_b PRSTOP
    % ���� ��� ������ ��������� ��
    fOUT = fopen('./OUT.ris','wt'); %,'s','KOI8-R');
    fprintf(fOUT,'Vxg Vyg Vzg Wxb Wyb Wzb Q0 Q1 Q2 Q3 L H Z GAM PSI TET deltaT1 deltaT2 deltaT3 deltaT4\r\n');
    % ���� ��� ������ ��������� ���
    fINS = fopen('./INS.ris','wt'); %,'s','KOI8-R');
    fprintf(fINS,'Wx Wy Wz GAM PSI TET Vx Vy Vz L H Z\r\n');
    % ������ ������
    str='%f ';
    % ��� ��
    format=[];
    n=size(X0(:),1);
    for i=1:n+8
        format=[format str];
    end
    % ��� ���
    format=[format '\n'];
    formatINS=[];
    for i=1:13
        formatINS=[formatINS str];
    end
    formatINS=[formatINS '\n'];

    % �����
    TIME=0;
    % ��������� ���������
    X=X0;
    U=U0;

    % ��������� ���������
    Xd=[0 5  0 0*pi/180;
        5 5  0 0
        5 5 -5 0;
        0 5 -5 0;
        0 5  0 0;
        0 5  0 0];

%    Xd=[0 10 5 0*pi/180];

    % �������� ������� �������� ������
    f=@(X,U,TIME)FX(X,U,TIME);
    % ���� �������������
    count=0;

%    while (TIME<TF)
    while (PRSTOP==0)
        % ���� ��� �������������� ��������� �������� ��
        [X,DX]=EULER(f,TIME,DT,X,U);
        Q=X(7:10);
        [TET,GAM,PSI]=QUAT2EULER(Q);
        % ���
        [XB]=INS(AfBI_b,WBI_b);
        % ������ ����������
        if (count==100)
            fprintf(fOUT,format,TIME,X(1:3),X(4:6)*180/pi,X(7:end),GAM,PSI,TET,U);
            fprintf(fINS,formatINS,TIME,XB(1:6)*180/pi,XB(7:end));
            count=0;
        end
        count=count+1;
        % ���
        [XPNK]=PNK(X);
        % ����������
        [U]=CONTROL(U0,XPNK,Xd,TIME);
        % ���������� �������
        TIME=TIME+DT;
    end
end

