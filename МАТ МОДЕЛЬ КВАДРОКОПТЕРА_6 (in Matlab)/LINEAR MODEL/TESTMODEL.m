kP=1.0E00;
kI=1.0E-1;
kD=1.0E00;
WH_uH=G_long(1);
s = tf('s');

WVy_uH=WH_uH*s;
G1=feedback(WVy_uH,kD,+1);
G2=feedback(G1/s,kP,+1);
G3=feedback(kI*G2/s,1,-1);
%step(G3,10);
step(WH_uH,10);