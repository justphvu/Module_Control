%% ������� ������ ������ 
% ����� �.�., ���. 305, 2021
function [a,b]=DATALOAD()
    %% �������� ������
    MATRIXA=importdata('MATRIXA.xlsx');
    MATRIXB=importdata('MATRIXB.xlsx');
    MA=MATRIXA.data;
    MB=MATRIXB.data;
    %% ������������ ������ a � b �������� ������ DX=aX+bU
    A=[]; B=[];
    % ������ ������ (�� ��������)
    %   V=0 ��/�   --> index=1
    %   V=150 ��/� --> index=2
    %   V=250 ��/� --> index=3
    index=2;
    for i=1:6
        A=[A MA((i-1)*9+1:i*9,index)];
        B=[B MB((i-1)*4+1:i*4,index)];
    end
    a=A';
    b=B';
end