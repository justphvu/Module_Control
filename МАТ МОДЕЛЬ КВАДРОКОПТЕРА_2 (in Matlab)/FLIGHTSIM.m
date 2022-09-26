// Project được tạo ra với mục đích mô phỏng tín hiệu đầu vào (U - hiệu điện thế) và đầu ra (w - vận tóc góc quay)
// của một bộ điều khiển mini (được khái quát tại file pdf đính kèm)

clear all;
global  PARAM DT

DT      = 0.001;
TMODEL  = 10.0;

[PARAM, Xzad]=INITSIM;

[X0,U0]    = INTSTATE(Xzad);

X=MODELING(X0,U0,TMODEL,DT);

GRAPHPLOT;
