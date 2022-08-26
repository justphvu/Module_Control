%% ФУНКЦИЯ УПРАВЛЕНИЯ
% MO = 0.0;
% CKO = pi/(180*3.6*(10^3));
% DW = MO + CKO*rand(1);


function [U] = CONTROL(U0,X,Xd,TIME)
    global PARAM
        persistent DS0 SS0 dSf0

        %% Текущее состояние
        S = X(3);

        %% Требуемое состояние
        Sd = Xd(1);

        %% Отклонение от требуемой траектории
        DS = Sd - S;

        %% Инициализация параметров для алгоритмов САУ
        if isempty(DS0)
            DS0=DS;        SS0=0.0;    dSf0=0.0;
        end

        %% Вычисление ребуемого значения угла тангажа
        kP=100;    kI=-0.3;    kD=23;
        [DU,SS,dSf]=FCONTROL(DS,DS0,SS0,kP,kI,kD);
        DS0=DS; SS0=SS; dSf0=dSf;

        U = U0 + DU;
end

% Функция вычисления требуемого значения угла тангажа и крена по требуемым
% координатам L и Z
function [DELTA,Se,def]=FCONTROL(e,e0,Se0,kP,kI,kD)
global DT
    def=(e-e0)/DT;
%    N=10.0;
%    [def]=fFILTER(def0,de,N);
    Se=Se0+e*DT;

%    if (Se>max(SeLIM))
%        Se=max(SeLIM);
%    end

%    if (Se<min(SeLIM))
%        Se=min(SeLIM);
%    end

    DELTA=kP*e+kI*Se+kD*def;
end
% Функция фильтрации производной от сигнала
% W(s)=(Ns)/(N+s)
% function [xf]=fFILTER(xf0,x,N)
% global DT
%     xf=xf0+N*(x-xf0)*DT;
% end
