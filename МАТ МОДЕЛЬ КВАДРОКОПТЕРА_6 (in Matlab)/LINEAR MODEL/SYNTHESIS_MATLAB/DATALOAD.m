%% ФУНКЦИЯ ЧТЕНИЯ ДАННЫХ 
% Нгуен Н.М., каф. 305, 2021
function [a,b]=DATALOAD()
    %% Загрузка данных
    MATRIXA=importdata('MATRIXA.xlsx');
    MATRIXB=importdata('MATRIXB.xlsx');
    MA=MATRIXA.data;
    MB=MATRIXB.data;
    %% Формирование матриц a и b линейной модели DX=aX+bU
    A=[]; B=[];
    % индекс режима (по скорость)
    %   V=0 км/ч   --> index=1
    %   V=150 км/ч --> index=2
    %   V=250 км/ч --> index=3
    index=2;
    for i=1:6
        A=[A MA((i-1)*9+1:i*9,index)];
        B=[B MB((i-1)*4+1:i*4,index)];
    end
    a=A';
    b=B';
end