function [XPNK]=PNK(X)
    Vxg = X(1);     
    Vyg = X(2);
    Vzg = X(3);
    Wx  = X(4);
    Wy  = X(5);
    Wz  = X(6);
    Q=X(7:10);
    [TET,GAM,PSI]=QUAT2EULER(Q);
    TET=TET*pi/180;
    PSI=PSI*pi/180;
    GAM=GAM*pi/180;
    L   = X(11);
    H   = X(12);
    Z   = X(13);        
    XPNK=[Wx,Wy,Wz,GAM,PSI,TET,Vxg,Vyg,Vzg,L,H,Z];
end