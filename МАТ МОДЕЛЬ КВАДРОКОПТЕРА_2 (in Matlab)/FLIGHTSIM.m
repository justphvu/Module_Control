clear all;
global  PARAM DT

DT      = 0.001;
TMODEL  = 10.0;

[PARAM, Xzad]=INITSIM;

[X0,U0]    = INTSTATE(Xzad);

X=MODELING(X0,U0,TMODEL,DT);

GRAPHPLOT;
