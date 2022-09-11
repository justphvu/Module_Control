%% ��������� ��������� ������
clear all;
%% ���������� ����������
global  PARAM INVAFM DT INSPAR Cbn0 XB0 AfBI_b WBI_b

% ����� ������
KEYREGIM = 0;

%% ������������� ��������� ���������� ���������
DT      = 1.E-3;            % ��� �������������
TMODEL  = 1.0E+1;           % ����� �������������

%% ������������� ����������
[PARAM,INVAFM,Xzad]=INITSIM;

%% ������������� ���������� ��������� �������������
[X0,U0]    = INTSTATE(Xzad,KEYREGIM);

%% ������������� ���������� ������������� ����������
[INSPAR,Cbn0,XB0] = INITINS(X0);

%% ���� �������������
X=MODELING(X0,U0,TMODEL,DT);

GRAPHPLOT;


