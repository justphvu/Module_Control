clear all;

%% �������� ������������� �� ���������
[a,b]=DATALOAD();

%% ��������� ������ �����
kGAM=0.4;
kWx=0.1;
T_ETA=0.1;

%% ������ ������������ ��������� �� ���� �������
A=[ a(2,2) a(2,3) a(2,4) a(2,8);
    a(3,2) a(3,3) a(3,4) a(3,8);
    a(4,2) a(4,3) a(4,4) a(4,8);
    0       0       1       0];
B=[b(2,2); b(3,2); b(4,2); 0];
C=[0 0 0 1];
D=0;
sys=ss(A,B,C,D);
%% ������������ ������� �� ���� �����
G_GAM=tf(sys);
%% ������������ ������� �� ������� �������� �����
s = tf('s');
G_Wx=G_GAM*s;
%% ������������ ������� ������������
tETA=50.E-3;
G_servo=tf(1,[tETA 1]); 
%% ������������ ������� ��
G_bf=tf(1,[T_ETA 1]);
%% ������������ ������� �������
% ������� ������+Wx
G1=series(G_servo,G_Wx);
% ���������� ������ (�����������)
G_Iraz=G1*G_bf;
% ���������� ������ (���������)
G_Izam=feedback(kWx*G_Iraz,1);
% ������� ������ (�����������)
G_sys_raz=1/kWx*G_Izam*(1/s);
% ������� ������ (���������)
G_sys_zam=feedback(kGAM*G_sys_raz,1);
% ��� ���������
G_noautopilot=series(G_servo,G_GAM);
%figure;
%margin(G_Iraz);
%rlocus(G_sys_raz);
%margin(kTET*G_sys_raz);
figure;
t=0:0.01:200;
[y,T]=step(G_sys_zam,t);
plot(T,y);