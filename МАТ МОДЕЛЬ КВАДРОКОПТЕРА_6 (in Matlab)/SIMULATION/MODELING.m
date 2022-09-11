%% ������������� ������

function [X]=MODELING(X0,U0,TF,DT) 

    fOUT = fopen('.\\TLM\\OUT.ris','wt','s','KOI8-R');
    fprintf(fOUT,'Vxb Vyb Vzb Wxb Wyb Wzb GAM PSI TET L H Z deltaT1 deltaT2 deltaT3 deltaT4\r\n');
    str='%f ';
    format=[];
    n=size(X0(:),1);
    for i=1:n+5  %12 ����������� + 4 ��������� + ����� 
        format=[format str];
    end
    format=[format '\n'];
   
    % ����� 
    TIME=0;
    % ��������� ���������
    X=X0;   
    U=U0; 
    % ��������� ���������
    Xd=[10 110 100 90*pi/180];
    % �������� ������� �������� ������
    f=@(X,U,TIME)FX(X,U,TIME);
    
    % ���� �������������
    count=0;   
    
    while (TIME<TF)
         [X,DX]=RK4(f,TIME,DT,X,U); 
        %if (count==10)
                fprintf(fOUT,format,TIME,X,U); 
                count=0;
        %end
        count=count+1;
        [U]=CONTROL(U0,X,Xd,TIME);
        TIME=TIME+DT;
    end
end

