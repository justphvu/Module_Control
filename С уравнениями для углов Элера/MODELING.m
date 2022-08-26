%% ������������� ������

function [X]=MODELING(X0,U0,TF,DT) 
global AfBI_b WBI_b PRSTOP
    % ���� ��� ������ ��������� ��
    fOUT = fopen('.\\TLM\\OUT.ris','wt','s','KOI8-R');
    fprintf(fOUT,'Vxb Vyb Vzb Wxb Wyb Wzb GAM PSI TET L H Z deltaT1 deltaT2 deltaT3 deltaT4\r\n');
    % ���� ��� ������ ��������� ���
    fINS = fopen('.\\TLM\\INS.ris','wt','s','KOI8-R');
    fprintf(fINS,'Wx Wy Wz GAM PSI TET Vx Vy Vz L H Z\r\n');
    % ������ ������
    str='%15.12f ';
    % ��� ��
    format=[];    
    n=size(X0(:),1);
    for i=1:n+5  
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
%     Xd=[5 11 0 0*pi/180;
%         5 10 -5 0;
%         0 11 -5 0;
%         0 10 0 0];
    
    Xd=[5 10 0 0*pi/180];        
    
    % �������� ������� �������� ������
    f=@(X,U,TIME)FX(X,U,TIME);
    % ���� �������������
    count=0;   
    
    while (TIME<TF)
%    while (PRSTOP==0)
        % ���� ��� �������������� ��������� �������� ��
        [X,DX]=RK4(f,TIME,DT,X,U); 
        % ���
        [XPNK]=INS(AfBI_b,WBI_b);
        % ������ ����������
        if (count==100)
            fprintf(fOUT,format,TIME,X(1:3),X(4:9)*180/pi,X(10:end),U); 
            fprintf(fINS,formatINS,TIME,XPNK(1:6)*180/pi,XPNK(7:end)); 
            count=0;
        end
        count=count+1;
        % ����������
        [U]=CONTROL(U0,X,Xd,TIME);
        % ���������� �������
        TIME=TIME+DT;        
    end
end

